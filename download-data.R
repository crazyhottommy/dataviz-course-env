# Download the course data into ./data (run from your project folder): source("download-data.R")
# Reads https://learn.chatomics.com/data/<course>/manifest.json, downloads each file, verifies its md5, unpacks it.
download_course_data <- function(course = "dataviz", dir = "data") {
  base <- paste0("https://learn.chatomics.com/data/", course)
  dir.create(dir, showWarnings = FALSE, recursive = TRUE)
  manifest <- jsonlite::fromJSON(paste0(base, "/manifest.json"))
  options(timeout = max(3600, getOption("timeout")))
  for (i in seq_len(nrow(manifest))) {
    m <- manifest[i, ]; file <- basename(m$key); dest <- file.path(dir, file); target <- file.path(dir, m$target)
    if (m$unpack != "none" && file.exists(target)) { message("✓ ", m$target, " already present"); next }
    if (!(file.exists(dest) && unname(tools::md5sum(dest)) == m$md5)) {
      message("↓ ", file, " (", round(m$size / 1e6), " MB)")
      utils::download.file(paste0(base, "/", file), dest, mode = "wb", quiet = TRUE)
      if (unname(tools::md5sum(dest)) != m$md5) stop("checksum mismatch for ", file, " — delete it and run again")
    }
    if (m$unpack == "tar.gz") { utils::untar(dest, exdir = dir); unlink(dest) }
    if (m$unpack == "gunzip") { R.utils_available <- requireNamespace("R.utils", quietly = TRUE)
      if (R.utils_available) R.utils::gunzip(dest, destname = target, overwrite = TRUE, remove = TRUE)
      else { con <- gzfile(dest, "rb"); out <- file(target, "wb"); while (length(b <- readBin(con, "raw", 1e7))) writeBin(b, out); close(con); close(out); unlink(dest) } }
  }
  message("Done. Data is in ", normalizePath(dir)); invisible(list.files(dir))
}
download_course_data()
