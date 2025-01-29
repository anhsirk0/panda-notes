let useParams: unit => URLParams.t = () => {
  let url = RescriptReactRouter.useUrl()
  url.search->URLParams.new
}

module Link = {
  @react.component
  let make = (~to, ~className, ~children) => {
    let onClick = evt => {
      evt->ReactEvent.Mouse.preventDefault
      RescriptReactRouter.push(to)
    }
    <a href=to className onClick> {children} </a>
  }
}
