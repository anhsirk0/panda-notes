open Icon

@react.component
let make = (~note: Shape.Note.t) => {
  let (isOpen, setIsOpen) = React.useState(_ => false)
  let toggleOpen = () => setIsOpen(val => !val)

  let onClick = evt => {
    evt->ReactEvent.Mouse.stopPropagation
    toggleOpen()
  }

  let {deleteNote} = Store.Notes.use()

  <React.Fragment>
    <button
      onClick
      className="btn btn-sm btn-circle btn-ghost -mr-2 hidden group-hover:flex absolute top-1 right-3">
      <Icon.trash className="text-xl text-error animate-fade" />
    </button>
    {isOpen
      ? <Modal title="Delete note" onClose=toggleOpen>
          <div className="flex flex-col gap-4">
            <h2 className="card-title resp-title"> {note.title->React.string} </h2>
            <pre className="line-clamp-3 text-wrap grow -mt-2">
              {note.content->String.substring(~start=0, ~end=88)->React.string}
            </pre>
            <p className="text-sm text-base-content/80">
              {note.updatedAt->Js.Date.fromFloat->Date.toDateString->React.string}
            </p>
          </div>
          <div className="flex flex-row gap-4 mt-4 justify-end">
            <button onClick={_ => deleteNote(note.id)} className="btn resp-btn btn-error">
              {React.string("Yes, Delete")}
            </button>
            <button onClick className="btn resp-btn"> {React.string("Cancel")} </button>
          </div>
        </Modal>
      : React.null}
  </React.Fragment>
}
