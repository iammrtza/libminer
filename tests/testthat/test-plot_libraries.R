test_that("plot_libraries draws a plot and returns sorted data", {
  data <- data.frame(
    Library = c("/second", "/first"),
    n_packages = c(20L, 5L)
  )
  file <- tempfile(fileext = ".pdf")
  grDevices::pdf(file)
  on.exit({
    grDevices::dev.off()
    unlink(file)
  })

  result <- plot_libraries(data)

  expect_equal(result$n_packages, c(5L, 20L))
  expect_equal(result$Library, c("/first", "/second"))
  expect_invisible(plot_libraries(data))
})

test_that("plot_libraries validates its input", {
  expect_snapshot(error = TRUE, plot_libraries(data.frame()))
  expect_snapshot(
    error = TRUE,
    plot_libraries(data.frame(Library = "/lib", n_packages = NA_real_))
  )
})
