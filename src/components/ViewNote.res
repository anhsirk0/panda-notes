open Note

@react.component
let make = (~notes: array<Note.t>, ~noteId) => {
  let note = noteId->Option.flatMap(id => notes->Array.find(n => n.id == id))

  <div className="flex flex-col gap-2 grow">
    {switch note {
    | None => <div className="center"> {"No notes"->React.string} </div>
    | Some(note) => <div className="center"> {note.title->React.string} </div>
    }}
  </div>
}
