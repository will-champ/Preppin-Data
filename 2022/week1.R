###################################################################################
## Week 1 #########################################################################
###################################################################################

## Loading libraries ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

library(tidyverse)
library(lubridate)

## Downloading and reading the data ~~~~~~~~~~~~~~~~~~~

tempfile <- tempfile(fileext <- ".zip")

fileurl <- 'https://drive.google.com/u/0/uc?id=1p8gt3cR3ATCeGK81pnT90x0a6dbCXst1&export=download'

download.file(fileurl,
              tempfile)

raw_2022_week1 <- read.csv(tempfile)

## Transformations ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

raw_2022_week1 %>%
  mutate(
    'Pupil\'s Name' <- paste0(pupil.last.name, ', ', pupil.first.name), 
    'Parental Contact Full Name' <- paste0(pupil.last.name,', ', Parental.Contact.Name_1),
    'Parental Contact Email Address' <- paste0(Parental.Contact.Name_1, '.', pupil.last.name, '@', Preferred.Contact.Employer, '.com'),
    'Birth Date' <- as.Date(Date.of.Birth, '%m/%d/%Y'), # Reformatted
    'Academic Year' <- case_when(
                        `Birth Date` > '2014-09-01' ~ 1,
                        `Birth Date` > '2013-09-01' & `Birth Date` < '2014-08-31' ~ 2,
                        `Birth Date` > '2012-09-01' & `Birth Date` < '2013-08-31' ~ 3,
                        `Birth Date` < '2012-09-01' ~ 4)) %>%
  select(
      `Academic Year`, 
      `Pupil's Name`, 
      `Parental Contact Full Name`, 
      `Parental Contact Email Address`
        ) -> final_2022_week1


