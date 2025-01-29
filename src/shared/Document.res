type t
@val external document: t = "document"
@set external setTitle: (t, string) => unit = "title"

@val @scope("document")
external createElement: string => Dom.element = "createElement"

@val @scope("document")
external body: Dom.element = "body"

@send external appendChild: (Dom.element, Dom.element) => Dom.element = "appendChild"
@send external removeChild: (Dom.element, Dom.element) => unit = "removeChild"
