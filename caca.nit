
module caca is pkgconfig "caca"

`{
#include <caca.h>
`}

extern class CacaCanvas `{ caca_canvas_t* `}
	fun put(text: String, x,y: Int) do native_put(text.to_cstring, x, y)
	fun native_put(text: NativeString, x,y: Int) `{  caca_put_str(self, x, y, text); `}
	fun draw_line(x1, y1, x2, y2: Int) `{ caca_draw_thin_line (self, x1, y1, x2, y2); `}
	fun width: Int `{ return caca_get_canvas_width(self); `}
	fun height: Int `{ return caca_get_canvas_height(self); `}
end

extern class CacaDisplay `{ caca_display_t* `}
	new `{ return caca_create_display(NULL); `}

	fun delete `{ 
	caca_event_t ev;
	caca_get_event(self, CACA_EVENT_KEY_PRESS, &ev, -1);
	caca_free_display(self); `}

	fun canvas: CacaCanvas `{ return caca_get_canvas(self); `}

	fun refresh `{ caca_refresh_display(self); `}
end

extern class CacaEvent `{ caca_event_t `}
end

var d = new CacaDisplay
var c = d.canvas
c.put("Hello", 0, 0)
d.refresh
d.delete
