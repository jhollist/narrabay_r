# Introduction to R and Markdown

**Date:** Monday April 23, 2018

**Location:** Narragansett Bay Comission 

**Details:** In this one day workshop we will introduce the R programming language with a focus on tidy data and reproducibility.  Attendees should leave with some basic skills in R, be able to create a reproducible research document in markdown, and know the basics of how to use git and GitHub.  Our examples will focus on data visualization and examples from the Narragansett Bay Comission's own datasets.

# Set Up

For this workshop, we will be using R and RStudio.  All attendees should have these installed and working prior to the workshop.  The best instructions I know of for R are the [Software Carpentry](https://software-carpentry.org/) workshop set up instructions so I will rely on those.

- R: [Software Carpentry R Installation Directions](https://swcarpentry.github.io/workshop-template/#r)

If you follow these directions you should have a working install of R.  They do also point you to RStudio in the R set up instructions.  If you followed along there you might have also installed RStudio.  If you did not or need some more guidance here are some additional details.

- Go to the [RStudio page for the Desktop downloads](https://www.rstudio.com/products/rstudio/download/#download)
- Select from the "Installers for Supported Platforms" for your operating system.  The two most likely will be:
  - [Windows 7/8/10 64-bit RStudio 1.1.423](https://download1.rstudio.org/RStudio-1.1.423.exe)
  - [Mac OS X 10.6+ 64-bit](https://download1.rstudio.org/RStudio-1.1.423.dmg)
- Using the installer, install RStudio how you normally would install any application on your computer.

# Data

I have grabed some buoy data from the Narragansett Bay Commission's Snapshot of the bay.  Instead of having us all work through the download (with R!) I saved it as a `.csv`.  Go ahead and download the file prior to the workshop.  

- [download the `narrabay_buoy_1517.csv` file](https://raw.githubusercontent.com/jhollist/narrabay_r/master/narrabay_buoy_1517.csv)

# Agenda (subject to change!)

|Time               |Subject                           |
|-------------------|----------------------------------|
|9:30 AM - 9:45 AM  |Introductions and Checking Set Ups| 
|9:45 AM - 10:30 AM |[RStudio](lessons/01_rstudio.md)|
|10:30 AM - Noon    |[R Basics](lessons/02_r_basics.md)|
|Noon - 1:00 PM     |LUNCH|
|1:00 PM - 3:00 PM  |[Tidy Data in R](lessons/04_tidy_data_in_r.md)|
|3:00 PM - 4:30 PM  |[Data Visualization with `ggplot2`](lessons/05_data_viz_with_ggplot2.md)|
 
# Addtional links

just stashing stuff here for now.

- <http://socviz.co/appendix.html#how-to-read-an-r-help-page>
