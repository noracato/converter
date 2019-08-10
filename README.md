Hi!

As it was my first time with ruby, I used the application framework that looked the most popular on my web-search (Rails). I feel the framework looks quite large for the small application I've built :)

I created two versions, a 'full' one that explicitly handles the type of conversion, and a 'simple' one that just bounces if there is no conversion entry between the given measures. In converter_web/app/controllers/convert_controller.rb you can (un)comment the one you like to  use.

Run the rails server in converter_web with 'bin/rails server'

Supported measures are:
*	length	- cm, metres, inch, feet
*	mass 	- kg, lb

PS. In the converter_terminal folder I put the terminal-based solution I created first, but it's basically the same
