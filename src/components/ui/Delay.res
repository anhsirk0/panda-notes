@react.component
let make = (~timeout, ~children) => {
  let (show, setShow) = React.useState(_ => false)

  React.useEffect0(() => {
    let id = setTimeout(_ => setShow(_ => true), timeout)
    Some(() => clearTimeout(id))
  })

  show ? children : React.null
}
