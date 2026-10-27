# Publication-Ready Figures in 3 Hours: ready-made environment

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/crazyhottommy/dataviz-course-env?quickstart=1&machine=basicLinux32gb)

One click gives you RStudio in the browser with R 4.4, Bioconductor 3.19 and every package the [course](https://learn.chatomics.com/data-visualization/) uses, with the course data already downloaded. Nothing to install.

## Start here (about 3 minutes the first time)
1. Click the **Open in GitHub Codespaces** button above (you need a free GitHub account; sign in if asked).
2. Keep the preselected **2-core / 8 GB** machine and click **Create codespace**.
3. Wait while the environment starts and the data downloads (progress is in `data-download.log`). When RStudio is ready a notification appears at the bottom right: click **Open in Browser**. Missed it? Click the **Ports** tab in the bottom panel, find the **RStudio** row (port **8787**, the only one listed), hover its address and click the **globe icon**, or simply click the address. RStudio opens in a new tab, no login needed.
4. In RStudio, open the project: **File → Open Project → dataviz-course.Rproj**.
5. Get the course code: log in at https://learn.chatomics.com/data-visualization/ and click **Download the code (zip)** in the page footer. In RStudio's **Files** pane click **Upload**, choose `code.zip`, and it unpacks into `qmd/` (the chapters) and `R/` (plain R scripts). Open `qmd/02-ggplot2.qmd` and start typing along.

The data the lessons read (about 15 MB: a TCGA expression table and the 10x PBMC 3k dataset) is downloaded automatically when the codespace is created; `bash download-data.sh dataviz` fetches it again if needed.

Coming back later: the same button reopens your existing codespace (that's what `quickstart=1` does); starts take about 30 seconds and your files are kept. GitHub's free tier is 120 core-hours a month, about 60 hours on this machine.

**Everyday controls**
- *Lost the Ports panel?* Press **Cmd/Ctrl+Shift+P** and run **Ports: Focus on Ports View**, or click the radio-tower icon with a number in the bottom-left status bar.
- *Stop the codespace when you're done* (saves your free hours): click the **Codespaces: …** button in the very bottom-left corner of the window (blue or green depending on your theme) → **Stop Current Codespace**, or use the "…" menu at github.com/codespaces. Stopping keeps your files; it also stops by itself after 30 minutes idle.
- *Delete* only when you no longer need it (github.com/codespaces → "…" → Delete). Unused codespaces are deleted automatically after 30 days, so download anything you want to keep.

**RStudio tab stuck on "Authenticating" or "just getting your codespace ready"?** That page is GitHub signing you in to the forwarded port, not RStudio. It spins forever when your browser blocks GitHub's sign-in cookie: Safari's "Prevent cross-site tracking", ad blockers, private windows, or a browser where you aren't signed in to GitHub. Any one of these fixes it:
- In the **Ports** tab, right-click the **RStudio** row → **Preview in Editor**. RStudio opens inside the codespace window, which is already signed in.
- Open the address in Chrome (signed in to GitHub), or in Safari turn off **Settings → Privacy → Prevent cross-site tracking** and reload.
- Still stuck? Check RStudio itself: open **Terminal → New Terminal** in the codespace and run `curl -s -o /dev/null -w '%{http_code}\n' http://localhost:8787/`. `200` means RStudio is running and the problem is the browser (use one of the fixes above). `000` means RStudio isn't running: press **Cmd/Ctrl+Shift+P** and run **Codespaces: Rebuild Container** (your files are kept).

Prefer to own the repo (for example to push your notes to GitHub)? Click **Use this template → Create a new repository** first, then open a codespace on your copy; everything else is identical.

## On your own computer
You don't need this repo. Install R ≥ 4.3 and RStudio, run `bash download-data.sh dataviz` (or `source("download-data.R")`) from your project folder to fetch the data, and install the packages: `install.packages(c("tidyverse", "here", "Polychrome", "patchwork", "gplots", "circlize", "Seurat"))` and `BiocManager::install("ComplexHeatmap")`. `renv.lock` has the exact versions (`install.packages("renv"); renv::restore()`). Optional: `remotes::install_github("immunogenomics/presto")` makes `FindAllMarkers()` faster.

## What's in here
- `.devcontainer/`: the Dockerfile that builds the image (`ghcr.io/crazyhottommy/dataviz-course-env`) and the Codespace settings
- `download-data.sh` / `download-data.R`: download and verify the course data into `data/`
- `renv.lock`: the package versions that built the course pages
- `dataviz-course.Rproj`, `.here`: so `here()` and relative paths behave like in the chapters

The course content itself is for enrolled students and is not in this repository.
