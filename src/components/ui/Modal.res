@react.component
let make = (~title, ~onClose, ~children, ~classes=?) => {
  let className = "modal-box flex flex-col max-h-[94vh] min-w-[36vw] " ++ classes->Option.getOr("")

  let onClick = evt => {
    evt->ReactEvent.Mouse.stopPropagation
    onClose()
  }
  let onKeyDown = evt => {
    // evt->Keyboard.stopPropagation
    if ReactEvent.Keyboard.key(evt) == "Escape" {
      onClose()
    }
  }

  React.useEffect0(() => {
    ".modal-open form"->Utils.querySelectAndThen(Utils.focus)
    None
  })

  switch ReactDOM.querySelector("#root") {
  | Some(domElement) =>
    ReactDOM.createPortal(
      <div onClick onKeyDown className="modal modal-open modal-bottom sm:modal-middle">
        <div className onClick=ReactEvent.Mouse.stopPropagation>
          <div className="flex flex-row items-center justify-between mb-4 -mt-1">
            <p className="font-bold text-lg"> {React.string(title)} </p>
            <button id="close-btn" onClick className="btn resp-btn btn-circle btn-ghost -mt-2">
              <Icon.x className="size-6" />
            </button>
          </div>
          {children}
        </div>
      </div>,
      domElement,
    )
  | None => React.null
  }
}
