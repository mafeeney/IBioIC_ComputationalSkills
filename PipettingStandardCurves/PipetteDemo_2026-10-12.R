#Hello this is my commentary at the top of the script
#include a comment explaining that I am creating a variable

TestVariable <- 5 #this is also a comment
TestSum <- 100076382439 + 9457058204 
sin(0) #demonstrate the use of function

#Load my libraries
library(tidyverse)

#Load my data
PipettingData <- read_csv("PipettingCalibrationCurve.csv",
         col_types="fdddd")

head(PipettingData)
str(PipettingData)

LongPipetteData <- pivot_longer(PipettingData, 
                                cols = starts_with("Replicate"), 
                                names_to = "Replicate", 
                                values_to = "Mass")

head(LongPipetteData)

ggplot(data=LongPipetteData, mapping =
         aes(x=Volume, 
             y=Mass,
             color=Solution)) +
  geom_point(alpha=0.5) +
  geom_smooth(method="lm") +
  theme_minimal() +
  labs(x="Volume pipetted (uL)", 
       y="Mass weighed (mg)")

ggsave("PipettingCalibrationCurve.png")

#use a linear model to analyse our water data
confint(lm(Mass ~ Volume * Solution, data=LongPipetteData))
