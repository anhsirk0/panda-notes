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

let setDocTitle = (title, mainTitle) => {
  let docTitle = switch title {
  | Some(title) => `${title} • ${mainTitle}`
  | None => mainTitle
  }
  Document.document->Document.setTitle(docTitle)
}

let setTheme = theme => "html"->querySelectAndThen(setAttribute(_, "data-theme", theme))
let strContains = (s1, s2) => s1->String.toLowerCase->String.includes(s2->String.toLowerCase)

let toRelativeDateStr = date => {
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

let toDateStr = date => date->DateFns.format("hh:mm aa, dd-MM-yyyy")

let copyText: string => unit = %raw(`function (text) {
 navigator.clipboard.writeText(text)
 }`)

let newFileUrl: string => string = %raw(`function (text) {
 return URL.createObjectURL(new Blob([text], {type: "text/plain"}))
 }`)

let revokeObjectURL = %raw(`function (url) {
 window.URL.revokeObjectURL(url)
 }`)

let downloadText = (text, title) => {
  let url = text->newFileUrl
  let a = "a"->Document.createElement
  a->setAttribute("href", url)
  a->setAttribute("download", `${title}.md`)
  let _ = Document.body->Document.appendChild(a)
  a->click
  let _ = setTimeout(() => {
    Document.body->Document.removeChild(a)
    url->revokeObjectURL
  }, 1)
}
