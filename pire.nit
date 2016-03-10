module pire
fun ctator: String do return "The Emperor says"
redef fun print(value) do super "{ctator} ``{value}''"
