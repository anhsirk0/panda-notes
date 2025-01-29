%%raw("import 'react-toastify/dist/ReactToastify.css'")

@react.component
let make = () => {
  Js.log(Route.useParams())
  let {settings} = Store.Settings.use()
  let {library, pinned} = Store.Notes.use()

  let (tag, setTag) = React.useState(_ => None)
  let noteId = Route.useParams()->URLParams.get("note-id")->Float.fromString
  let (query, setQuery) = React.useState(_ => "")

  let tags = library->Array.reduce([], (acc: array<Shape.Tag.t>, item) => {
    acc->Array.concat(item.tags->Array.filter(tg => !(acc->Array.some(t => t.id == tg.id))))
  })

  let notes =
    tag
    ->Option.map(t => library->Array.filter(n => n.tags->Array.some(Shape.Tag.eq(_, t))))
    ->Option.getOr(library)
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

  let key = tag->Option.map(tag => tag.id->Float.toString)->Option.getOr("None")
  let leftP = settings.sidebar ? "pl-[12rem] xxl:pl-[16rem]" : "pl-0"

  <React.Fragment>
    <Toast.container pauseOnFocusLoss=false position="bottom-right" />
    <Sidebar count={notes->Array.length}>
      <SelectTag tag setTag tags />
    </Sidebar>
    <div className={`flex flex-row transitional ${leftP} size-full`}>
      <SelectNote notes=filteredNotes noteId key>
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
