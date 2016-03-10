# Final Mission

Your mission is to combine your `caca` library and your `loglas` parser to render logocas vectorial image on a terminal.

The `caca` library is

~~~nit
module caca is pkgconfig

`{
#include <caca.h>
`}

extern class CacaCanvas `{ caca_canvas_t* `}
	fun put(text: String, x, y: Int) do native_put(text.to_cstring, x, y)
	fun native_put(text: NativeString, x, y: Int) `{  caca_put_str(self, x, y, text); `}
	fun draw_line(x1, y1, x2, y2: Int) `{ caca_draw_thin_line (self, x1, y1, x2, y2); `}
	fun width: Int `{ return caca_get_canvas_width(self); `}
	fun height: Int `{ return caca_get_canvas_height(self); `}
end

extern class CacaDisplay `{ caca_display_t* `}
	new `{ return caca_create_display(NULL); `}

	fun canvas: CacaCanvas `{ return caca_get_canvas(self); `}

	fun refresh `{ caca_refresh_display(self); `}

	fun quit `{
		caca_event_t ev;
		caca_get_event(self, CACA_EVENT_KEY_PRESS, &ev, -1);
		caca_free_display(self);
	`}
end
~~~

Implement a program that takes a legolas file as an argument and draw things.

Note that the atùin (the cursor) should starts at the middle of the canevas.

## Template To Use

~~~nit
module logolas_caca

import logolas_parser 
import logolas_lexer
import caca

# CODE HERE
~~~

## Expected Result

~~~
$ ./logolas_caca maenas.logolas
# display an elegant and abstract L letter
$ ./logolas_caca elen.logolas
# show a glowing and inspiring star
$ ./logolas_caca bar.logolas
# render a peaceful and warm house
~~~
