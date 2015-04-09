# Libraries
library(animation)
library(dplyr)
library(lubridate)
library(ggplot2)

# Blank ggplot theme
blank_theme <- theme_bw() + 
  theme(line = element_blank(), rect = element_blank(),
        strip.text = element_blank(), axis.text = element_blank(),
        plot.title = element_blank(), axis.title = element_blank(),
        plot.margin = structure(c(0, 0, -1, -1), unit = "lines", 
                                valid.unit = 3L, class = "unit"))

# Create data frame of all the times to display
df <- data_frame(timer = rev(format(seq(ymd_hms("2015-04-08 00:00:00"), 
                                        ymd_hms("2015-04-08 00:00:00") + minutes(1), 
                                        by="sec"), "%M:%S")))

# Start recording
ani.record(reset=TRUE)

# Plot each time as text
for (i in 1:nrow(df)) {
  p <- ggplot(slice(df, i), aes(x=1, y=1, label=timer)) + 
    geom_text(size=50, family="Source Sans Pro Light") + 
    blank_theme
  print(p)
  ani.record()
}

# Save final animation
# TODO: Looping doesn't work (maybe an ImageMagick/GIF problem though)
saveGIF(ani.replay(), interval=1, movie.name="timer_r.gif", 
        ani.width=600, ani.height=400, loop=1) 
