module caca_client

import caca

var d = new CacaDisplay
var c = d.canvas
c.put("Hello, World!", 5, 1)
d.refresh
d.quit
