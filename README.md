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

The easiest way to work with these materials is to open the RStudio project. This will allow you to easily see the folders in RStudio. Each folder contains a file `app.R` which contains the code for a [shiny](https://shiny.rstudio.com/) application. You can then open these in RStudio and then you can click on the `Run App` button to run the application. The image below should give you some idea of the process.

![](images/RStudio.png)

