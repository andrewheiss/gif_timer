# -----------
# Libraries
# -----------
library(animation)
library(dplyr)
library(lubridate)
library(ggplot2)


# ----------
# Settings
# ----------
secs <- 1 * 60
extra.secs <- 5
font.color <- "black"
font.size <- 50
timer.bg.color <- "white"
filename <- "timer_r.gif"
width <- 600
height <- 400
frame.duration <- 1
loop <- 1


# -----------------------
# Build timer animation
# -----------------------
# Create data frame of all the times to display
df <- data_frame(timer = rev(format(seq(ymd_hms("2015-04-08 00:00:00"), 
                                        ymd_hms("2015-04-08 00:00:00") + seconds(secs), 
                                        by="sec"), "%M:%S")))
df.extra <- data_frame(timer = rep("00:00", extra.secs))
df <- bind_rows(df, df.extra)


# Faster functional way of creating list of plots
animation.frame <- function(df) {
  lapply(1:nrow(df), FUN=function(i) {
    p <- ggplot(slice(df, i), aes(x=1, y=1, label=timer)) + 
      geom_text(size=font.size, family="Source Sans Pro Light", colour=font.color) + 
      theme_bw() + 
      theme(line = element_blank(), #rect = element_blank(),
            strip.text = element_blank(), axis.text = element_blank(),
            plot.title = element_blank(), axis.title = element_blank(),
            plot.margin = structure(c(0, 0, -1, -1), unit = "lines", 
                                    valid.unit = 3L, class = "unit"),
            panel.background = element_rect(fill=timer.bg.color),
            panel.border=element_blank())
    print(p)
  })
}

# Save final animation
# TODO: Looping doesn't work (maybe an ImageMagick/GIF problem though)
saveGIF(animation.frame(df), interval=frame.duration, movie.name=filename, 
        ani.width=width, ani.height=height, loop=loop) 


#-------------------------------------------------------------------------------
# TODO: This almost seems to be the only way to get transparency to work. 
# ggsave can handle transparency, but I don't want to save anything. CairoPNG 
# also tries to save to file. If I can get CairoPNG or ggsave to save to an 
# object, not a file, we'll be good.
# library(Cairo)
# CairoPNG(bg = "transparent")
# qplot(1:3, 1:3)
# dev.off()
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Procedural way, with explicit ani.record() calls
# # Start recording
# ani.record(reset=TRUE)
# 
# # Plot each time as text
# for (i in 1:nrow(df)) {
#   p <- ggplot(slice(df, i), aes(x=1, y=1, label=timer)) + 
#     geom_text(size=50, family="Source Sans Pro Light", colour="white") + 
#     blank_theme
#   print(p)
#   ani.record()
# }
# 
# saveGIF(ani.replay(), interval=1, movie.name="timer_r1.gif", 
#         ani.width=400, ani.height=200, loop=1) 
#-------------------------------------------------------------------------------
