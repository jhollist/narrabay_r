

# Tidy Data in R

In this lesson we will cover the basics of data in R and will do so from a somewhat opinionated viewpoint of "Tidy Data".  There are other paradigms and other ways to work with data in R, but focusing on Tidy Data concepts and tools (a.k.a., The Tidyverse) gets people to a productive place the quickest.  For more on the data analysis using the Tidyverse, the best resource I know of is [R for Data Science](http://r4ds.had.co.nz).  The approaches we will cover are very much inspired by this book.

## Lesson Outline
- [Data in R: The data frame](#data-in-r-the-data-frame)
- [Reading in data](#reading-in-data)
- [Tidy data](#tidy-data)

## Exercises
- [Excercise 3.1](#exercise-31)
- [Excercise 3.2](#exercise-32)
- [Excercise 3.3](#exercise-33)

## Data in R: The data frame

Simply put, a data structure is a way for programming languages to handle storing information.  Like most languages, R has several structures (vectors, matrix, lists, etc.) but since R is built for data analysis the data frame, a spreadsheet like structure with rows and columns, is the most widely used and useful to learn first.  In addition, the data frame (or is it data.frame) is the basis for many modern R pacakges (e.g. the tidyverse) and getting used to it will allow you to quickly build your R skills.

*Note:* It is useful to know more about the different data structures such as vectors, lists, and factors (a weird one that is for catergorical data).  But that is beyond what we have time for.  You can look at what I think is the best source on this information, Hadley Wickham's [Data Structures Chapter in Advanced R](http://adv-r.had.co.nz/Data-structures.html).

## Reading in data

The best way to learn what a data frame is is to look at one.  We can build one from scratch with the `data.frame()` function and while completely creating a data frame from scratch is useful (especially when you start writing your own functions), more often than not data is stored in an external file that you need to read into R.  These may be delimited text files, spreadsheets, relational databases, SAS files ...  You get the idea.  Instead of treating this subject exhaustively, we will focus just on a single file type, `.csv`, that is very commonly encountered and (usually) easy to create from other file types.  For this, we will use the Tidyverse way to do this and use  `read_csv()` from the `readr` pacakge.

The `read_csv()` is a re-imagined version of the base R fucntion, `read.csv()`.  This command assumes a header row with column names and that the delimiter is a comma. The expected no data value is NA and by default, strings are NOT converted to factors.  This is a big benefit to using `read_csv()` as opposed to `read.csv()`.  Additionally, `read_csv()` has some performance enhancements that make it preferrable when working with larger data sets.  In my limited experience it is about 45% faster than the base R options.  For instance a ~200 MB file with hundreds of columns and a couple hundred thousand rows took ~14 seconds to read in with `read_csv()` and about 24 seconds with `read.csv()`.  As a comparison at 45 seconds Excel had only opened 25% of the file!

Source files for `read_csv()` can either be on a local hard drive or, and this is pretty cool, on the web. We will be using the former for our examples and exercises. If you had a file available from a URL it would be accessed like `mydf <- read.csv("https://example.com/my_cool_file.csv")`. This is what is shown in our the `narrabay_analysis.R` script on lines 31-42, albeit with some additional magic.  As an aside, paths and the use of forward vs back slash is important. R is looking for forward slashes ("/"), or unix-like paths. You can use these in place of the back slash and be fine. You can use a back slash but it needs to be a double back slash ("\\\\"). This is becuase the single backslash in an escape character that is used to indicate things like newlines or tabs. 

For today's workshop we will focus on grabbing data from a local file, and we already have an example of this in our `narrabay_analysis.R`.  In that file look for the (uncommented) code labeled "read_csv".

For your convenience, it looks like:


```r
narrabay_data <- read_csv("narrabay_buoy_1517.csv")
```


And now we can take a look at our data frame


```r
narrabay_data
```

```
## # A tibble: 236,096 x 5
##    Location               Time                     Chl    pH  Temp
##    <chr>                  <chr>                  <dbl> <dbl> <dbl>
##  1 Phillipsdale (bottom)  12/31/2017 11:45:00 PM    NA -7999 -7999
##  2 Phillipsdale (surface) 12/31/2017 11:45:00 PM -7999 -7999 -7999
##  3 Phillipsdale (bottom)  12/31/2017 11:30:00 PM    NA -7999 -7999
##  4 Phillipsdale (surface) 12/31/2017 11:30:00 PM -7999 -7999 -7999
##  5 Phillipsdale (bottom)  12/31/2017 11:15:00 PM    NA -7999 -7999
##  6 Phillipsdale (surface) 12/31/2017 11:15:00 PM -7999 -7999 -7999
##  7 Phillipsdale (bottom)  12/31/2017 11:00:00 PM    NA -7999 -7999
##  8 Phillipsdale (surface) 12/31/2017 11:00:00 PM -7999 -7999 -7999
##  9 Phillipsdale (bottom)  12/31/2017 10:45:00 PM    NA -7999 -7999
## 10 Phillipsdale (surface) 12/31/2017 10:45:00 PM -7999 -7999 -7999
## # ... with 236,086 more rows
```

If you've worked with data before in a spreadsheet or from a table in a database, this rectangular structure should look somewhat familiar.   One way (there are many!) we can access the different parts of the data frame is like:


```r
# Use the dollar sign to get a column
narrabay_data$Chl
```

```
##   [1]    NA -7999    NA -7999    NA -7999    NA -7999    NA -7999    NA
##  [12] -7999    NA -7999    NA -7999    NA -7999    NA -7999    NA -7999
##  [23]    NA -7999    NA -7999    NA -7999    NA -7999    NA -7999    NA
##  [34] -7999    NA -7999    NA -7999    NA -7999    NA -7999    NA -7999
##  [45]    NA -7999    NA -7999    NA -7999    NA -7999    NA -7999    NA
##  [56] -7999    NA -7999    NA -7999    NA -7999    NA -7999    NA -7999
##  [67]    NA -7999    NA -7999    NA -7999    NA -7999    NA -7999    NA
##  [78] -7999    NA -7999    NA -7999    NA -7999    NA -7999    NA -7999
##  [89]    NA -7999    NA -7999    NA -7999    NA -7999    NA -7999    NA
## [100] -7999
##  [ reached getOption("max.print") -- omitted 235996 entries ]
```

```r
# Grab a row with indexing
narrabay_data[2,]
```

```
## # A tibble: 1 x 5
##   Location               Time                     Chl    pH  Temp
##   <chr>                  <chr>                  <dbl> <dbl> <dbl>
## 1 Phillipsdale (surface) 12/31/2017 11:45:00 PM -7999 -7999 -7999
```

At this point, we have:

- read in a data frame
- seen rows and columns
- heard about "rectangular" structure
- seen how to get a row and a column

The purpose of all this was to introduce the concept of the data frame and read in data

## Exercise 3.1
We have our data frame, `narrabay_data`, read in.  Let's take some time to get to know the data a bit better.  

1. Use `View()` to bring up an interactive view of the data frame
2. Use `dim()`, `str()`, `summary()`, and simply printing to the console to answer the following:
  - How many rows are in this dataset?
  - How many columns?
  - What is the average Temperature for the dataset?
  - What is the maximum pH?

# Tidy data

We have learned about data frames, how to read them in, and about the basic structure we want.   At this point there have been only a few rules applied to our data frames (which already separates them from spreadsheets) and that is our datasets must by rectangular.  Beyond that we havent disscussed how best to organize that data so that subsequent analyses are easier to accomplish. This is, in my opinion, the biggest decision we make as data analysts and it takes a lot of time to think about how best to organize data and to actually re-organize that data.  Luckily, we can use an existing concept for this that will help guide our decisions and re-organization.  The best concept I know of to do this is the concept of [tidy data](http://r4ds.had.co.nz/tidy-data.html).  The essence of which can be summed up as:

1. Each column is a single variable
2. Each row is an observation
3. Each cell has a single value 
4. The data must be rectangular

Lastly, if you want to read more about this there are several good sources:

- The previously linked R4DS Chapter on [tidy data](http://r4ds.had.co.nz/tidy-data.html)
- The [original paper by Hadley Wickham](https://www.jstatsoft.org/article/view/v059i10)
- The [Tidy Data Vignette](http://tidyr.tidyverse.org/articles/tidy-data.html)
- Really anything on the [Tidyverse page](https://www.tidyverse.org/)

Let's now see some of the basic tools for tidying data using the `tidyr` and `dplyr` packages.  We will learn these tools as we work through doing some basic QA and cleaning up of our `narrabay_data` data frame.

## QA and Tidy Data

Based on the answers to our questions in the previous exercise, some red flags should have been raised.  A summary of the data frame will find several of these issues.


```r
summary(narrabay_data)
```

```
##    Location             Time                Chl         
##  Length:236096      Length:236096      Min.   :-7999.0  
##  Class :character   Class :character   1st Qu.:    1.9  
##  Mode  :character   Mode  :character   Median :    4.7  
##                                        Mean   :-1117.3  
##                                        3rd Qu.:   12.2  
##                                        Max.   :  714.9  
##                                        NA's   :111671   
##        pH                Temp         
##  Min.   :-7999.00   Min.   :-7999.00  
##  1st Qu.:    7.21   1st Qu.:    8.37  
##  Median :    7.52   Median :   17.10  
##  Mean   :-1220.49   Mean   :-1146.96  
##  3rd Qu.:    7.76   3rd Qu.:   22.45  
##  Max.   :   40.53   Max.   :71615.00  
## 
```

What is the primary issue we see with all three of the the data variables? 

It appears that -7999 is being used as a missing data value.  Using actual values for missing data is problematic for several reasons.  First, it might be a possible value and second, R (and really any other language) will include that value in calculations.  Luckily, R has a value just for this, `NA`.  Let's take a look at our first `dplyr` funtion, `mutate()`.  It creates a new column or replaces an existing one.  We will do the latter.  Let's run this and talk about a few things...


```r
library(dplyr)
narrabay_data_qa1 <- narrabay_data %>%
  mutate(Chl = case_when(Chl == -7999 ~ NA_real_,
                         TRUE ~ Chl),
         Temp = case_when(Temp == -7999 ~ NA_real_,
                          TRUE ~ Temp))
```



## Exercise 3.2

1. Now that we have replaced the -7999 with `NA` for `Chl` and `Temp`. We need to do the same for pH.

Let's take a look at the summary again to see if everything looks good.


```r
summary(narrabay_data_qa1)
```

```
##    Location             Time                Chl               pH        
##  Length:236096      Length:236096      Min.   :-22.00   Min.   :-89.00  
##  Class :character   Class :character   1st Qu.:  2.80   1st Qu.:  7.36  
##  Mode  :character   Mode  :character   Median :  5.90   Median :  7.60  
##                                        Mean   : 15.34   Mean   :  7.58  
##                                        3rd Qu.: 14.30   3rd Qu.:  7.80  
##                                        Max.   :714.90   Max.   : 40.53  
##                                        NA's   :129255   NA's   :36213   
##       Temp         
##  Min.   :   -9.99  
##  1st Qu.:   12.78  
##  Median :   19.21  
##  Mean   :   94.39  
##  3rd Qu.:   23.00  
##  Max.   :71615.00  
##  NA's   :36212
```

What issues do we see now (i.e. Whoa, that's hot!)?

What we can do now is filter out these observations using the `filter()` function for `dplyr`.


```r
narrabay_data_qa2 <- narrabay_data_qa1 %>%
  filter(Chl >= 0) %>%
  filter(pH >= 0 & pH <= 14)
```



And one last look:


```r
summary(narrabay_data_qa2)
```

```
##    Location             Time                Chl               pH       
##  Length:105386      Length:105386      Min.   :  0.00   Min.   :0.000  
##  Class :character   Class :character   1st Qu.:  2.90   1st Qu.:7.380  
##  Mode  :character   Mode  :character   Median :  6.00   Median :7.610  
##                                        Mean   : 15.63   Mean   :7.612  
##                                        3rd Qu.: 14.50   3rd Qu.:7.820  
##                                        Max.   :714.90   Max.   :9.260  
##       Temp      
##  Min.   :-7.17  
##  1st Qu.:13.12  
##  Median :19.86  
##  Mean   :17.91  
##  3rd Qu.:23.43  
##  Max.   :39.76
```

## Exercise 3.3 

1. Let's add one more `filter()` to take care of the Temperatures.  Just to be safe, we can filter our temperatures greater than 40.

This should take are of our QA needs.  We do however have one issue that is making our data un-tidy.  Can anyone spot it?

Let's take care of that multiple data in a single column then!  Also, while we are at it we can turn the data time string into a date format that will work better for looking at time series kind of things.   This one is a bit tricky so we will do it together and will also select out, with `select()` our final set of columns.


```r
library(stringr)
library(lubridate)
narrabay_tidy <- narrabay_data_qa2 %>%
  rename_all(tolower) %>%
  mutate(layer = str_extract(.$location, "\\(\\w+\\)"),
         location = str_extract(.$location, "\\w+")) %>%
  mutate(layer = str_extract(.$layer, "\\w+")) %>%
  mutate(date_time = mdy_hms(time)) %>%
  mutate(date = date(date_time)) %>%
  select(location, layer, date, chl, ph, temp)
narrabay_tidy
```

```
## # A tibble: 105,386 x 6
##    location     layer   date         chl    ph  temp
##    <chr>        <chr>   <date>     <dbl> <dbl> <dbl>
##  1 Phillipsdale surface 2017-12-27  2.80  7.44 1.13 
##  2 Phillipsdale surface 2017-12-27  1.90  7.45 0.790
##  3 Phillipsdale surface 2017-12-27  2.10  7.43 1.23 
##  4 Phillipsdale surface 2017-12-27  2.20  7.42 0.750
##  5 Phillipsdale surface 2017-12-27  2.20  7.46 1.12 
##  6 Phillipsdale surface 2017-12-27  2.00  7.44 1.50 
##  7 Phillipsdale surface 2017-12-27  2.50  7.43 1.55 
##  8 Phillipsdale surface 2017-12-27  2.20  7.40 1.83 
##  9 Phillipsdale surface 2017-12-27  2.10  7.36 0.890
## 10 Phillipsdale surface 2017-12-27  2.10  7.37 0.600
## # ... with 105,376 more rows
```

