# Code Review: cr/sentry-0001 — Audit Log Pagination Changes

## Summary

These changes introduce an "optimized" pagination path for the organization audit logs endpoint and add support for negative offsets in the paginator. There are several **critical issues** that would cause runtime failures and potential security concerns.

---

## Critical Issues

### 1. Django QuerySet Does Not Support Negative Slicing

The code introduces negative offset handling in QuerySet slicing:

```python
# BasePaginator & OptimizedCursorPaginator
queryset[start_offset:stop]  # start_offset can be negative
```

**Django's QuerySet does not support negative indices.** Slicing with a negative start raises `AssertionError: Negative indexing is not supported.`

Any request that triggers `queryset[negative_offset:stop]` will crash the application.

### 2. `organization_context.member` Can Be `None`

```python
enable_advanced = request.user.is_superuser or organization_context.member.has_global_access
```

`RpcUserOrganizationContext.member` is `None` when the user has no membership in the organization. Accessing `organization_context.member.has_global_access` in that case will raise `AttributeError`.

**Fix:** Add a null check:
```python
enable_advanced = (
    request.user.is_superuser
    or (organization_context.member is not None and organization_context.member.has_global_access)
)
```

### 3. BasePaginator Change Affects All Paginated Endpoints

The modification to `BasePaginator.get_result()` affects **all** paginators that inherit from it (`DateTimePaginator`, `Paginator`, etc.), not just the audit log endpoint.

Cursors are parsed from user input (`request.GET.get("cursor")`). A malicious user could craft a cursor with a negative offset (e.g., `0:-100:0`) and cause Django to crash on **any** paginated endpoint that uses these paginators.

---

## Medium Issues

### 4. Wrong Variable in OptimizedCursorPaginator Prev Cursor Logic

```python
elif len(results) == offset + limit + extra:
```

When `offset` is negative, this should use `start_offset` for consistency. The comparison `len(results) == offset + limit + extra` yields incorrect results when offset is negative (e.g., offset=-5, limit=5, extra=2 → 2, which may not match the actual result count).

### 5. Typo in paginator.py (Pre-existing)

```python
queryset.query.order_b = tuple(new_order_by)  # Should be order_by
```

### 6. Misleading "Performance Optimization" Comments

The comments claim negative offsets enable "efficient bidirectional pagination" and "high-performance scenarios." However:

- Django doesn't support this—it would crash
- Even if it did, negative slicing typically requires a full count or full scan, which would be **expensive** on large datasets, not performant

---

## Minor Issues

### 7. Query Parameter as Feature Gate

Using `optimized_pagination=true` as a feature gate is fragile—it can be omitted from links, mistyped, and isn't discoverable. A feature flag or similar mechanism would be more robust.

### 8. cursors.py Change

The only change in `cursors.py` is a comment. The `Cursor` class already accepts any `int` for offset via `from_string()`. The real behavioral change is that negative offsets are now propagated to the paginator, where they cause crashes.

---

## Recommendations

1. **Remove negative offset handling** from both `BasePaginator` and `OptimizedCursorPaginator` until there's a design that works with Django's QuerySet API.
2. **Add null check** for `organization_context.member` before accessing `has_global_access`.
3. **Revert BasePaginator changes**—if an optimized path is needed, confine it entirely to `OptimizedCursorPaginator` so other endpoints aren't affected.
4. **Add tests** for: `organization_context.member is None`, malformed cursors with negative offsets, and the optimized path when enabled for admins.

---

## Positive Aspects

- The intent to optimize high-volume audit log access is reasonable.
- Restricting the optimized path to superusers and users with global access is a sensible security choice.
- Making it opt-in via `optimized_pagination=true` limits blast radius.
- The `OptimizedCursorPaginator` is isolated in its own class rather than overloading `DateTimePaginator`.
