#' R Library Summary
#'
#' Provides a brief summary of the package libraries on your machine
#'
#' @param sizes Logical; if `TRUE`, also compute the total size on disk
#'   (in bytes) of the packages in each library. Defaults to `FALSE`.
#'
#' @returns A `data.frame` containing the count of packages in each of the
#'   user's libraries, and optionally the total size on disk
#' @export
#'
#' @examples
#' lib_summary()
#' lib_summary(sizes = TRUE)
lib_summary <- function(sizes = FALSE) {
  pkgs <- utils::installed.packages()
  pkg_tbl <- table(pkgs[, "LibPath"])
  pkg_df <- as.data.frame(pkg_tbl, stringsAsFactors = FALSE)
  names(pkg_df) <- c("Library", "n_packages")

  if (sizes) {
    pkg_df$size_bytes <- vapply(
      pkg_df$Library,
      function(lib) {
        pkg_names <- pkgs[pkgs[, "LibPath"] == lib, "Package"]
        pkg_dirs <- file.path(lib, pkg_names)
        sum(vapply(
          pkg_dirs,
          function(dir) sum(file.size(list.files(dir, recursive = TRUE, full.names = TRUE))),
          numeric(1)
        ), na.rm = TRUE)
      },
      numeric(1)
    )
  }

  pkg_df
}