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
    ->Option.map((tag: Tag.t) =>
      library->Array.filter(note => note.tags->Array.some(t => t.id == tag.id))
    )
    ->Option.getOr(library)

  let key = tag->Option.map(tag => tag.id->Int.toString)->Option.getOr("None")
  let leftP = settings.sidebar ? "pl-[14rem] xxl:pl-[18rem]" : "pl-0"

  <React.Fragment>
    <Sidebar>
      <SelectTag tag setTag setNoteId />
    </Sidebar>
    <div className={`flex flex-row transitional ${leftP} size-full`}>
      <SelectNote notes noteId setNoteId tag key />
      <ViewNote notes noteId />
    </div>
  </React.Fragment>
}
