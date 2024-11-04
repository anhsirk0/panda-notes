module Icon = {
  type props = {className: string}
  type t = React.component<props>

  @module("@phosphor-icons/react")
  external palette: t = "Palette"
}
