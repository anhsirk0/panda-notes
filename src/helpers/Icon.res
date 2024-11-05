module Icon = {
  type props = {className: string}
  type t = React.component<props>

  @module("@phosphor-icons/react") external palette: t = "Palette"
  @module("@phosphor-icons/react") external arrowLineLeft: t = "ArrowLineLeft"
  // @module("@phosphor-icons/react") external arrowLineRight: t = "ArrowLineRight"
  @module("@phosphor-icons/react") external notePencil: t = "NotePencil"
  @module("@phosphor-icons/react") external magnifyingGlass: t = "MagnifyingGlass"
  @module("@phosphor-icons/react") external sliders: t = "Sliders"
  @module("@phosphor-icons/react") external menu: t = "List"
  @module("@phosphor-icons/react") external listPlus: t = "ListPlus"
  @module("@phosphor-icons/react") external caretLeft: t = "CaretLeft"
  @module("@phosphor-icons/react") external caretRight: t = "CaretRight"
}
