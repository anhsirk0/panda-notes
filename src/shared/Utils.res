@send external focus: Dom.element => unit = "focus"
@send external click: Dom.element => unit = "click"
@send external blur: Dom.element => unit = "blur"
@send external setAttribute: (Dom.element, string, string) => unit = "setAttribute"

let querySelectAndThen = (selector, action) => {
  switch ReactDOM.querySelector(selector) {
  | Some(el) => el->action
  | None => ()
  }
}
let setTheme = theme => "html"->querySelectAndThen(setAttribute(_, "data-theme", theme))
let strContains = (s1, s2) => s1->String.toLowerCase->String.includes(s2->String.toLowerCase)

let toDateStr = date => {
  let fmt = if date->DateFns.isToday {
    "hh:mm aa"
  } else if date->DateFns.isYesterday {
    "hh:mm aa 'Yesterday'"
  } else if date->DateFns.isThisWeek {
    "hh:mm aa EEEE"
  } else {
    "hh:mm aa, dd-MM-yyyy"
  }
  date->DateFns.format(fmt)
}
