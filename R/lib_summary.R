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
    pkg_df$lib_size <- fs::as_fs_bytes(vapply(
      pkg_df$Library,
      function(x) {
        sum(fs::dir_info(x, recurse = TRUE, type = "file")$size)
      },
      FUN.VALUE = numeric(1)
    ))
  }
  pkg_df
}
