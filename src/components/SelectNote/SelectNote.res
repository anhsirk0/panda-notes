module NoteItem = {
  @react.component
  let make = (~note: Shape.Note.t, ~onClick, ~isSelected, ~showDivider) => {
    let {pinned, toggleNotePin} = Store.Notes.use()
    let isPinned = pinned->Array.findIndex(i => i == note.id) > -1
    let togglePin = _ => toggleNotePin(note.id, isPinned)

    let bg = isSelected ? "bg-base-200" : ""
    let className = `card card-compact ${bg} w-full relative shrink-0 cursor-pointer animate-slide group`

    let afterDelete = () => isPinned ? togglePin() : ()

    <li className onClick key={String.make(isPinned)}>
      {showDivider
        ? <div className="absolute top-0 left-[7%] h-[1px] w-[86%] bg-base-content/10" />
        : React.null}
      <div
        onClick=ReactEvent.Mouse.stopPropagation
        className="dropdown dropdown-bottom dropdown-end z-10">
        <label
          ariaLabel={`delete-${note.title}`}
          tabIndex=0
          className="btn btn-sm btn-circle btn-ghost hidden group-hover:flex absolute top-2 right-3 -mr-2">
          <Icon.dotsThree className="resp-icon" />
        </label>
        <ul tabIndex=0 className="dropdown-content z-[1] menu shadow mt-10 bg-neutral rounded-box">
          <li className="text-error">
            <DeleteNoteButton note afterDelete />
          </li>
          <li>
            <button onClick=togglePin>
              <Icon.mapPin className="text-xl" />
              {(isPinned ? "Unpin" : "Pin")->React.string}
            </button>
          </li>
        </ul>
      </div>
      <div className="card-body relative rounded-box overflow-hidden !py-2">
        {isSelected ? <div className="absolute inset-0 h-full w-1.5 bg-primary" /> : React.null}
        <h2 className="card-title resp-title"> {note.title->React.string} </h2>
        <pre className="line-clamp-2 xxl:line-clamp-3 grow -mt-2 text-base-content/80">
          {note.content->String.substring(~start=0, ~end=88)->React.string}
        </pre>
        <div className="card-actions text-sm text-base-content/60 items-center">
          {isPinned
            ? <button onClick=togglePin className="btn btn-xs btn-circle btn-ghost">
                <Icon.mapPin className="size-4 text-primary" weight="fill" />
              </button>
            : React.null}
          {note.updatedAt->Js.Date.fromFloat->Date.toDateString->React.string}
        </div>
      </div>
    </li>
  }
}

@react.component
let make = (~notes: array<Shape.Note.t>, ~noteId, ~setNoteId, ~children) => {
  let noteIdx = noteId->Option.map(id => notes->Array.findIndex(n => n.id == id))

  let noteItems = notes->Array.mapWithIndex((note, idx) => {
    let onClick = _ => setNoteId(_ => Some(note.id))
    let isSelected = noteId->Option.filter(id => id == note.id)->Option.isSome
    let showDivider = !(
      isSelected || noteIdx->Option.filter(i => i + 1 == idx)->Option.isSome || idx == 0
    )

    <Delay key={note.id->Int.toString} timeout={idx * 80}>
      <NoteItem isSelected note onClick showDivider />
    </Delay>
  })

  <div className="flex flex-col px-4 pt-0 border-r border-base-content/20 h-full">
    {children}
    <ul id="notes-list" className="flex flex-col min-h-0 grow overflow-y-auto w-64 xxl:w-72">
      {React.array(noteItems)}
    </ul>
    {notes->Array.length > 0
      ? React.null
      : <div className="center size-full"> {"No notes"->React.string} </div>}
  </div>
}
