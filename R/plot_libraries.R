#' Plot R Libraries
#'
#' Draws a horizontal dot plot showing the number of installed packages in
#' each R library. Library paths are shortened to keep the labels readable.
#'
#' @param data A data frame returned by [lib_summary()]. By default, a new
#'   summary is created.
#' @param main Character string giving the plot title.
#'
#' @returns The plotted data, invisibly.
#' @export
#'
#' @examples
#' plot_libraries()
plot_libraries <- function(
  data = lib_summary(),
  main = "Installed packages by R library"
) {
  required <- c("Library", "n_packages")
  if (!is.data.frame(data) || !all(required %in% names(data))) {
    stop(
      "`data` must be a data frame with `Library` and `n_packages` columns.",
      call. = FALSE
    )
  }
  if (!is.numeric(data$n_packages) || anyNA(data$n_packages)) {
    stop("`n_packages` must contain non-missing numeric values.", call. = FALSE)
  }
  if (nrow(data) == 0L) {
    stop("`data` must contain at least one library.", call. = FALSE)
  }

  data <- data[order(data$n_packages), , drop = FALSE]
  labels <- path.expand(data$Library)
  home <- path.expand("~")
  system_library <- normalizePath(.Library, mustWork = FALSE)
  normalized_labels <- normalizePath(labels, mustWork = FALSE)
  labels[normalized_labels == system_library] <- "R system library"
  labels[startsWith(labels, home)] <- paste0(
    "~",
    substring(labels[startsWith(labels, home)], nchar(home) + 1L)
  )
  labels[nchar(labels) > 36L] <- paste0(
    ".../",
    basename(labels[nchar(labels) > 36L])
  )

  old_par <- graphics::par(
    mar = c(4.5, max(8, min(14, max(nchar(labels)) * 0.55)), 3.5, 2),
    las = 1,
    xaxs = "i"
  )
  on.exit(graphics::par(old_par), add = TRUE)

  x_max <- max(data$n_packages) * 1.12
  if (x_max == 0) {
    x_max <- 1
  }
  y <- seq_len(nrow(data))

  graphics::plot(
    data$n_packages,
    y,
    type = "n",
    axes = FALSE,
    xlab = "Number of installed packages",
    ylab = "",
    main = main,
    xlim = c(0, x_max),
    ylim = c(0.5, nrow(data) + 0.5)
  )
  ticks <- graphics::axTicks(1)
  graphics::abline(v = ticks, col = "grey90", lwd = 1)
  graphics::segments(0, y, data$n_packages, y, col = "grey75", lwd = 3)
  graphics::points(
    data$n_packages,
    y,
    pch = 21,
    cex = 1.8,
    lwd = 1.5,
    bg = "steelblue2",
    col = "steelblue4"
  )
  graphics::axis(1, at = ticks, col = NA, col.axis = "grey30")
  graphics::axis(2, at = y, labels = labels, tick = FALSE, col.axis = "grey20")
  graphics::text(
    data$n_packages,
    y,
    labels = data$n_packages,
    pos = 4,
    offset = 0.7,
    cex = 0.85,
    col = "grey20"
  )
  graphics::box(bty = "l", col = "grey70")

  invisible(data)
}
