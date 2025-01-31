@react.component
let make = (~note: Shape.Note.t) => {
  let (isOpen, toggleOpen, _) = Hook.useToggle()

  let openInfo = _ => {
    "#open-note-info"->Utils.querySelectAndThen(Utils.blur)
    toggleOpen()
  }

  let copyNote = _ => {
    note.content->Utils.copyText
    "Note copied successfully"->Toast.success
    "#copy-note"->Utils.querySelectAndThen(Utils.blur)
  }

  let downloadNote = _ => {
    Utils.downloadText(note.content, note.title)
    "Note downloaded successfully"->Toast.success
  }

  <React.Fragment>
    <div className="dropdown dropdown-bottom dropdown-end z-10">
      <label
        id="note-options"
        ariaLabel={`info-${note.title}`}
        tabIndex=0
        className="btn btn-sm btn-circle btn-ghost absolute top-0 -right-2">
        <Icon.dotsThreeVertical className="resp-icon" />
      </label>
      <div
        tabIndex=0
        className="dropdown-content z-10 shadow mt-10 xxl:mt-12 bg-secondary text-secondary-content rounded-box menu [&>li>*:hover]:bg-base-100/20">
        <li>
          <button id="open-note-info" onClick=openInfo>
            <Icon.info className="resp-icon" />
            {"Info"->React.string}
          </button>
        </li>
        <li>
          <button id="copy-note" onClick=copyNote>
            <Icon.clipboard className="resp-icon" />
            {"Copy"->React.string}
          </button>
        </li>
        <li>
          <button onClick=downloadNote>
            <Icon.markdownLogo className="resp-icon" />
            {"Download"->React.string}
          </button>
        </li>
      </div>
    </div>
    {isOpen
      ? <Modal title=note.title onClose=toggleOpen>
          <div className="flex flex-col gap-4">
            <p>
              {"Updated At:"->React.string}
              <span className="font-medium ml-2">
                {note.updatedAt->Utils.toRelativeDateStr->React.string}
              </span>
            </p>
            <p>
              {"Created At:"->React.string}
              <span className="font-medium ml-2">
                {note.createdAt->Utils.toDateStr->React.string}
              </span>
            </p>
          </div>
        </Modal>
      : React.null}
  </React.Fragment>
}
