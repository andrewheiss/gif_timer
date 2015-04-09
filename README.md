# GIF Timer

Sometimes it's useful to have a countdown timer that's not part of another program or based online. Animated GIFs are supported all over the place (even in PowerPoint and Keynote) and work great as timers. 

These two scripts use ImageMagick to generate a GIF that lasts any arbitrary duration. They both work slightly differently: the R version animates a series of ggplot2 plots, while the Python version uses ImageMagick's text drawing capabilities directly. Both work well with some minor issues and workarounds (documented in the code).

And here they are in action:

![https://raw.githubusercontent.com/andrewheiss/gif_timer/master/timer_r.gif](R version)

![https://raw.githubusercontent.com/andrewheiss/gif_timer/master/timer_python.gif](Python version)
