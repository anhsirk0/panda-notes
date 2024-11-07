open SettingStore
open Note
open Tag
open Icon

module NoteItem = {
  @react.component
  let make = (~note: Note.t, ~onClick, ~isSelected=false) => {
    let bg = isSelected ? "bg-base-200/70" : ""
    let className = `card card-compact ${bg} w-full relative overflow-hidden shrink-0 cursor-pointer hover:bg-base-200/60 animate-slide`
    <div className onClick>
      {isSelected
        ? <div className="absolute inset-0 h-full w-2 bg-primary" />
        : <div className="absolute bottom-0 left-[5%] h-[1px] w-[90%] bg-base-content/10" />}
      <div className="card-body">
        <h2 className="card-title"> {note.title->React.string} </h2>
        <p> {note.content->String.substring(~start=0, ~end=100)->React.string} </p>
        <div className="card-actions justify-end">
          <button className="btn"> {"Buy Now"->React.string} </button>
        </div>
      </div>
    </div>
  }
}

@react.component
let make = (~notes: array<Note.t>, ~noteId, ~setNoteId, ~tag: option<Tag.t>) => {
  let {settings, toggleSidebar} = SettingStore.use()
  let onClick = _ => toggleSidebar()

  let noteItems = notes->Array.mapWithIndex((note, idx) => {
    let onClick = _ => setNoteId(_ => Some(note.id))
    <Delay key={note.id->Int.toString} timeout={idx * 80}>
      <NoteItem
        isSelected={noteId->Option.filter(id => id == note.id)->Option.isSome} note onClick
      />
    </Delay>
  })

  <div className="flex flex-col gap-2 px-4 pt-0 border-r border-base-content/20 h-full">
    <div className="flex flex-row gap-1 my-2 items-center">
      {settings.sidebar
        ? React.null
        : <button
            onClick
            ariaLabel="open-sidebar"
            className="btn btn-ghost btn-square resp-btn animate-grow">
            <Icon.menu className="resp-icon" />
          </button>}
      <p className="card-title">
        {tag->Option.map(t => "#" ++ t.title)->Option.getOr("Notes")->React.string}
      </p>
      <div className="grow" />
      <button ariaLabel="add-note" className="btn btn-ghost btn-square resp-btn">
        <Icon.notePencil className="resp-icon" />
      </button>
      <button ariaLabel="search-note" className="btn btn-ghost btn-square resp-btn">
        <Icon.magnifyingGlass className="resp-icon" />
      </button>
    </div>
    <div className="flex flex-col gap-2 min-h-0 grow overflow-y-auto w-96">
      {React.array(noteItems)}
    </div>
    {notes->Array.length > 0
      ? React.null
      : <div className="center size-full"> {"No notes"->React.string} </div>}
  </div>
}
