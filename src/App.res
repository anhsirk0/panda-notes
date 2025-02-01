%%raw("import 'react-toastify/dist/ReactToastify.css'")

@react.component
let make = () => {
  let {settings} = Store.Settings.use()
  let {library, pinned} = Store.Notes.use()

  let (tag, setTag) = React.useState(_ => Shape.Tag.Home)
  let noteId = Route.useParams()->URLParams.get("note-id")->Float.fromString
  let (query, setQuery) = React.useState(_ => "")

  let trashedNotes = library->Array.filter(n => n.isDeleted)
  let activeNotes = library->Array.filter(n => !n.isDeleted)
  let tags = activeNotes->Array.reduce([], (acc: array<Shape.Tag.t>, item) => {
    acc->Array.concat(item.tags->Array.filter(tg => !(acc->Array.some(t => t.id == tg.id))))
  })

  let notes =
    switch tag {
    | Home => activeNotes
    | Trash => trashedNotes
    | Tag(t) => activeNotes->Array.filter(n => n.tags->Array.some(Shape.Tag.eq(_, t)))
    }
    ->Array.toSorted((a, b) => {
      switch settings.sort {
      | DateAsc => a.updatedAt -. b.updatedAt
      | DateDesc => b.updatedAt -. a.updatedAt
      }
    })
    ->Array.toSorted((a, b) => {
      let aIdx = pinned->Array.findIndex(id => id == a.id)
      let bIdx = pinned->Array.findIndex(id => id == b.id)

      (bIdx - aIdx)->Int.toFloat
    })

  let filteredNotes = notes->Array.filter(n => {
    let hasQ = Utils.strContains(_, query)
    n.title->hasQ || n.content->hasQ || n.tags->Array.some(t => t.title->hasQ)
  })

  let note = noteId->Option.flatMap(id => notes->Array.find(n => n.id == id))

  // let key = tag->Option.map(tag => tag.id->Float.toString)->Option.getOr("None")
  let leftP = settings.sidebar ? "pl-[12rem] xxl:pl-[16rem]" : "pl-0"

  React.useEffect3(() => {
    let title = switch tag {
    | Home => None
    | Trash => None
    | Tag(t) => Some(t)->Option.filter(_ => settings.showTagTitle)->Option.map(t => `#${t.title}`)
    }

    Utils.setDocTitle(title, settings.title)
    None
  }, (tag, settings.showTagTitle, settings.title))

  React.useEffect0(() => {
    settings.theme->Utils.setTheme
    None
  })

  <React.Fragment>
    <Toast.container pauseOnFocusLoss=false position="bottom-right" />
    <Sidebar count={notes->Array.length}>
      <SelectTag tag setTag tags showTrash={trashedNotes->Array.length > 0} />
    </Sidebar>
    <div className={`flex flex-row transitional ${leftP} size-full`}>
      <SelectNote notes=filteredNotes noteId>
        <NotesToolbar tag query setQuery />
      </SelectNote>
      {switch note {
      | Some(note) => <ViewNote note tags key={note.id->Float.toString} />
      | None =>
        <div className="center flex-col size-full">
          <Icon.note className="size-24" />
          <p className="text-3xl font-bold"> {"Select a note to view"->React.string} </p>
        </div>
      }}
    </div>
  </React.Fragment>
}
