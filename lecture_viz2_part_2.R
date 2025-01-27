## Visualizing Multi-dimensional Relationships

## New functions covered:
# select()
# rename()
# geom_errorbar()
# scale_fill_brewer()
# facet_wrap()
# geom_line()
# theme()
# scale_color_discrete()

## Load tidyverse as usual (which includes ggplot2)
library(tidyverse)
library(viridis)

maait <- read_csv("maait.csv")
####

## Quick look
glimpse(maait)

## See the first few rows
maait

## Last few rows
tail(maait)

## Focus on a subset of variables
dat <- maait %>% 
    select(ID, VisitNum, group, sxsgeneral, IgE) %>% 
    rename(visit = VisitNum,
           treatment = group,
           symptoms = sxsgeneral)

## Double check first few rows
dat

## Make a bar plot showing the number of observations at each visit
dat %>% 
    ggplot(aes(x = visit)) + 
    geom_bar()

# Make a bar plot showing the mean level of IgE for each treatment group
dat %>% 
    ggplot(aes(x = treatment, 
               y = IgE)) +
    geom_bar(stat = "summary", fun = "mean")

# Add error bars (+/- 1 SE) to the bar plot
dat %>% 
    ggplot(aes(x = treatment, y = IgE)) + 
    geom_bar(aes(fill = treatment),
             stat = "summary", fun = "mean") +
    geom_errorbar(stat = "summary", fun.data = "mean_se")

# Change the color scheme of the bar plot
dat %>% 
    ggplot(aes(x = treatment, y = IgE)) + 
    geom_bar(aes(fill = treatment),
             stat = "summary", fun = "mean") +
    geom_errorbar(stat = "summary", fun.data = "mean_se",
                  width = 0.3) +
    scale_fill_brewer("Treatment Group",
                      type = "qual",
                      palette = "Set2")

# Show average symptoms by visit
dat %>% 
    ggplot(aes(x = visit, y = symptoms)) + 
    geom_bar(stat = "summary", fun = "mean")

## Facet by treatment group
dat %>% 
    ggplot(aes(x = visit, y = symptoms)) + 
    geom_bar(stat = "summary", fun = "mean") +
    facet_wrap(vars(treatment))

# Make the y axis scale more fine-grained by 0.5 steps
dat %>% 
    ggplot(aes(x = visit, y = symptoms)) + 
    geom_bar(stat = "summary", fun = "mean") +
    facet_wrap(vars(treatment)) +
    labs(y = "IgE Levels (ng/mL)") +
    scale_y_continuous(breaks = seq(0, 5, 0.5)) 


## Make a scatterplot of visits and symptoms
dat %>% 
    ggplot(aes(x = visit, y = symptoms)) + 
    geom_point()

## Jitter the points a little to show individual points
dat %>% 
    ggplot(aes(x = visit, y = symptoms)) + 
    geom_jitter(width = 0.1, height = 0.1)

## Add lines connecting dots
dat %>% 
    ggplot(aes(x = visit, y = symptoms)) + 
    geom_point() +
    geom_line()

## Group points by ID and connect with lines (spaghetti plot)
dat %>% 
    ggplot(aes(x = visit, y = symptoms)) + 
    geom_point() +
    geom_line(aes(group = ID))

## Color each line grouping by ID
dat %>% 
    ggplot(aes(x = visit, y = symptoms)) + 
    geom_point() +
    geom_line(aes(group = ID, color = ID))

## Color each line AND point by ID
dat %>% 
    ggplot(aes(x = visit, y = symptoms)) + 
    geom_point(aes(color = ID)) +
    geom_line(aes(group = ID, color = ID))

## Remove the legend
dat %>% 
    ggplot(aes(x = visit, y = symptoms)) + 
    geom_point(aes(color = ID)) +
    geom_line(aes(group = ID, color = ID)) +
    theme(legend.position = "none")

## Color lines by treatment variable and fixed color for points
dat %>% 
    ggplot(aes(x = visit, y = symptoms)) +
    geom_line(aes(group = ID, color = treatment)) +
    geom_point(size = 2, color = "magenta")

# Make a scatter plot of the mean of symptoms by visit and by treatment group
dat %>% 
    ggplot(aes(x = visit, y = symptoms)) +
    geom_point(aes(color = treatment),
               stat = "summary",
               fun = "mean",
               size = 4) +
    geom_line(aes(color = treatment),
              stat = "summary",
              fun = "mean")

## Add the points back (jittered) in to show the variation in the data and
## modify the legend title
dat %>% 
    ggplot(aes(x = visit, y = symptoms)) +
    geom_jitter(aes(color = treatment), alpha = 1/2,
                width = 0.1) +
    geom_point(aes(color = treatment),
               stat = "summary",
               fun = "mean",
               size = 4) +
    geom_line(aes(color = treatment),
              stat = "summary",
              fun = "mean") +
    scale_color_discrete("Treatment Group")

## Add the points and lines back in to show the variation in the data and modify
## the legend title
dat %>% 
    ggplot(aes(x = visit, y = symptoms)) +
    geom_point(aes(color = treatment), alpha = 1/2) +
    geom_line(aes(group = ID, color = treatment), alpha = 1/2) +
    geom_point(aes(color = treatment),
               stat = "summary",
               fun = "mean",
               size = 5) +
    geom_line(aes(color = treatment),
              stat = "summary",
              fun = "mean",
              size = 2) +
    scale_color_discrete("Treatment Group")

# Make jittered scatterplot with linear regression lines showing the trends for
# each treatment group
dat %>% 
    ggplot(aes(x = visit, y = symptoms)) + 
    geom_jitter(aes(color = treatment), 
                width = 0.1, height = 0.4) +
    geom_smooth(aes(color = treatment),
                method = "lm", size = 2)


# Make jittered scatterplot with smoother lines showing the trends for each
# treatment group
dat %>% 
    ggplot(aes(x = visit, y = symptoms)) + 
    geom_jitter(aes(color = treatment), 
                width = 0.1, height = 0.4) +
    geom_smooth(aes(color = treatment),
                size = 2)













