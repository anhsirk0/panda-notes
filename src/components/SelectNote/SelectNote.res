module NoteItem = {
  @react.component
  let make = (~note: Shape.Note.t, ~onClick, ~isSelected, ~showDivider) => {
    let bg = isSelected ? "bg-base-200" : ""
    let className = `card card-compact ${bg} w-full relative overflow-hidden shrink-0 cursor-pointer animate-slide`
    <li className onClick>
      {isSelected ? <div className="absolute inset-0 h-full w-1.5 bg-primary" /> : React.null}
      {showDivider
        ? <div className="absolute top-0 left-[7%] h-[1px] w-[86%] bg-base-content/10" />
        : React.null}
      <div className="card-body !py-2 group">
        <DeleteNoteButton note />
        <h2 className="card-title resp-title"> {note.title->React.string} </h2>
        <pre className="line-clamp-2 xxl:line-clamp-3 grow -mt-2 text-base-content/80">
          {note.content->String.substring(~start=0, ~end=88)->React.string}
        </pre>
        <div className="card-actions text-sm text-base-content/60">
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
