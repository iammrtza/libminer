# plot_libraries validates its input

    Code
      plot_libraries(data.frame())
    Condition
      Error:
      ! `data` must be a data frame with `Library` and `n_packages` columns.

---

    Code
      plot_libraries(data.frame(Library = "/lib", n_packages = NA_real_))
    Condition
      Error:
      ! `n_packages` must contain non-missing numeric values.

