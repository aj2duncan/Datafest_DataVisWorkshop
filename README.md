# Introduction to Interactive Data Visualisation in R Workshop Materials

This repository contains all the materials needed for the Introduction to Data Visualisation in R workshop, held at Inverness College as part of the [Fringe](https://www.datafest.global/fringe-events) events for [Datafest 2020](https://www.datafest.global/).

## What you need

First you need to have [R]() installed. It is also suggested that you install [RStudio]() as it generally makes things a little easier. Once these are installed you need to add some additional packages. Packages give **R** some additional functionality. To run all the code included herein you'll need the following packages installed.

- [Shiny](https://shiny.rstudio.com/)
- [plotly](https://plot.ly/r/)
- [dplyr](https://dplyr.tidyverse.org/)
- [readr](https://readr.tidyverse.org/)

You can install all of these packages at once using the following line of code.

```r
install.packages(c("shiny", "plotly", "dplyr", "readr"), dependencies = TRUE)
```

## Shiny Applications

Each folder contains a file called `app.R` which is a [shiny](https://shiny.rstudio.com/) application. If you open these in RStudio then you can click on `Run App` to run the application.



