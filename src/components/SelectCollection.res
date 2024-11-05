open NoteStore
open Collection
open Icon

module Item = {
  @react.component
  let make = (~item: Collection.t, ~isSelected=false, ~isCollapsed=false) => {
    let bg = isSelected ? "bg-neutral text-neutral-content" : ""
    let className = `flex flex-row p-2 gap-2 ${bg} rounded-box relative isolate overflow-hidden items-center`
    <div className>
      {isSelected ? <div className="absolute inset-0 bg-neutral-content/20 -z-[1]" /> : React.null}
      <Icon.caretRight className={`size-4 stroke-2 ${isCollapsed ? "" : "rotate-90"}`} />
      {item.title->React.string}
    </div>
  }
}

@react.component
let make = () => {
  let {library} = NoteStore.use()
  let collections = library->Array.map(item => <Item key=item.title item isSelected=true />)
  React.array(collections)
}
