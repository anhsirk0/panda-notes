@react.component
let make = (~note: Shape.Note.t, ~afterDelete, ~trash=false) => {
  let (isOpen, toggleOpen, _) = Hook.useToggle()

  let onClick = evt => {
    evt->ReactEvent.Mouse.stopPropagation
    toggleOpen()
  }

  let {deleteNote, updateNote} = Store.Notes.use()

  let onDelete = _ => {
    if note.isDeleted {
      deleteNote(note.id)
    } else {
      updateNote({...note, isDeleted: true})
    }
    afterDelete()
    Toast.success(`Note ${trash ? "trash" : "delet"}ed successfully`)
  }

  let className = trash ? "" : "hover:!bg-error/80 hover:text-error-content"
  <React.Fragment>
    <button onClick className>
      {trash ? <Icon.trashSimple className="text-xl" /> : <Icon.trash className="text-xl" />}
      {(trash ? "Trash" : "Delete")->React.string}
    </button>
    {isOpen
      ? <Modal title={trash ? "Trash note" : "Delete note"} onClose=toggleOpen>
          <div className="flex flex-col gap-4">
            <h2 className="card-title resp-title"> {note.title->React.string} </h2>
            <pre className="line-clamp-4 text-wrap grow -mt-2">
              {note.content->String.substring(~start=0, ~end=88)->React.string}
            </pre>
            <p className="text-sm text-base-content/80">
              {note.updatedAt->Utils.toDateStr->React.string}
            </p>
          </div>
          <div className="flex flex-row gap-4 mt-4 justify-end">
            <button onClick=onDelete className="btn resp-btn btn-error">
              {(trash ? "Yes, Trash" : "Yes, Delete")->React.string}
            </button>
            <button onClick className="btn resp-btn"> {React.string("Cancel")} </button>
          </div>
        </Modal>
      : React.null}
  </React.Fragment>
}
