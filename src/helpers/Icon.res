module Icon = {
  type props = {className: string}
  type t = React.component<props>

  @module("@phosphor-icons/react")
  external palette: t = "Palette"
  @module("@phosphor-icons/react")
  external check: t = "Check"
}
