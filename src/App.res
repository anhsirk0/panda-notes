@react.component
let make = () => {
  let {settings} = Store.Settings.use()
  let {library} = Store.Notes.use()

  let (tag, setTag) = React.useState(_ => None)
  let (noteId, setNoteId) = React.useState(_ => None)
  let (query, setQuery) = React.useState(_ => "")

  let tags = library->Array.reduce([], (acc: array<Shape.Tag.t>, item) => {
    acc->Array.concat(item.tags->Array.filter(tg => !(acc->Array.some(t => t.id == tg.id))))
  })

  let notes =
    tag
    ->Option.map(t => library->Array.filter(n => n.tags->Array.some(Shape.Tag.eq(_, t))))
    ->Option.getOr(library)

  let filteredNotes = notes->Array.filter(n => {
    let hasQ = Utils.strContains(_, query)
    n.title->hasQ || n.content->hasQ || n.tags->Array.some(t => t.title->hasQ)
  })
  let note = noteId->Option.flatMap(id => notes->Array.find(n => n.id == id))

  let key = tag->Option.map(tag => tag.id->Int.toString)->Option.getOr("None")
  let leftP = settings.sidebar ? "pl-[12rem] xxl:pl-[16rem]" : "pl-0"

  <React.Fragment>
    <Sidebar count={notes->Array.length}>
      <SelectTag tag setTag tags setNoteId />
    </Sidebar>
    <div className={`flex flex-row transitional ${leftP} size-full`}>
      <SelectNote notes=filteredNotes noteId setNoteId key>
        <NotesToolbar setNoteId tag query setQuery />
      </SelectNote>
      {switch note {
      | Some(note) => <ViewNote note tags key={note.id->Int.toString} />
      | None => <div className="center size-full"> {"Select a note to view"->React.string} </div>
      }}
    </div>
  </React.Fragment>
}
