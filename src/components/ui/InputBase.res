@react.element
let make = props => {
  let el = React.useRef(Nullable.null)
  let onKeyDown = evt => {
    evt->ReactEvent.Keyboard.stopPropagation
    if ReactEvent.Keyboard.key(evt) == "Escape" {
      el.current->Nullable.forEach(input => input->Utils.blur)
    }
  }

  <input {...props} onKeyDown ref={ReactDOM.Ref.domRef(el)} />
}
