open SettingStore
open NoteStore
open Tag

@react.component
let make = () => {
  let {settings} = SettingStore.use()
  let {library} = NoteStore.use()

  let (tag, setTag) = React.useState(_ => None)
  let (noteId, setNoteId) = React.useState(_ => None)

  let notes =
    tag
    ->Option.map(t => library->Array.filter(n => n.tags->Array.some(Tag.eq(_, t))))
    ->Option.getOr(library)
  let note = noteId->Option.flatMap(id => notes->Array.find(n => n.id == id))

  let key = tag->Option.map(tag => tag.id->Int.toString)->Option.getOr("None")
  let leftP = settings.sidebar ? "pl-[12rem] xxl:pl-[16rem]" : "pl-0"

  <React.Fragment>
    <Sidebar>
      <SelectTag tag setTag setNoteId />
    </Sidebar>
    <div className={`flex flex-row transitional ${leftP} size-full`}>
      <SelectNote notes noteId setNoteId tag key />
      {switch note {
      | Some(note) => <ViewNote note key={note.id->Int.toString} />
      | None => <div className="center size-full"> {"Select a note to view"->React.string} </div>
      }}
    </div>
  </React.Fragment>
}
