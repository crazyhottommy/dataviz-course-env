# Publication-Ready Figures in 3 Hours: course environment (R 4.4 / Bioconductor 3.19, RStudio Server)
FROM bioconductor/bioconductor_docker:RELEASE_3_19

# Course packages (binary installs from Bioconductor's container repo where available), then presto from GitHub (makes FindAllMarkers fast, as in the course pages).
RUN Rscript -e 'BiocManager::install(c("ComplexHeatmap", "Polychrome", "Seurat", "circlize", "dplyr", "forcats", "ggplot2", "gplots", "here", "jsonlite", "knitr", "magick", "patchwork", "readr", "remotes", "rmarkdown", "tibble", "tidyr", "tidyverse"), ask = FALSE, update = FALSE, Ncpus = 4)' \
 && Rscript -e 'remotes::install_github("immunogenomics/presto", upgrade = "never")' \
 && Rscript -e 'ok <- vapply(c("ComplexHeatmap", "Polychrome", "Seurat", "circlize", "dplyr", "forcats", "ggplot2", "gplots", "here", "jsonlite", "knitr", "magick", "patchwork", "readr", "remotes", "rmarkdown", "tibble", "tidyr", "tidyverse", "presto"), requireNamespace, logical(1), quietly = TRUE); if (!all(ok)) stop("missing: ", paste(names(ok)[!ok], collapse = " ")); cat("all course packages installed\n")' \
 && rm -rf /tmp/downloaded_packages /tmp/Rtmp*

# RStudio Server without a login page (rocker's /init configures it from DISABLE_AUTH/USER); open the course folder by default.
RUN { echo; echo "session-default-working-dir=/workspaces/dataviz-course-env"; echo "session-default-new-project-dir=/workspaces/dataviz-course-env"; } >> /etc/rstudio/rsession.conf \
 && echo "rstudio ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/rstudio && chmod 0440 /etc/sudoers.d/rstudio
ENV DISABLE_AUTH=true USER=rstudio
