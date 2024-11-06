open NoteStore

module Item = {
  @react.component
  let make = (~title, ~isSelected=false, ~onClick) => {
    let bg = isSelected ? "bg-neutral-content/20 text-neutral-content font-medium" : ""
    let className = `flex flex-row p-2 px-4 gap-2 ${bg} rounded-box relative isolate overflow-hidden items-center cursor-pointer hover:bg-neutral-content/25`
    <div role="button" className onClick> {title->React.string} </div>
  }
}

@react.component
let make = (~collectionId, ~setCollectionId) => {
  let {library} = NoteStore.use()
  let collections = library->Array.map(item => {
    let onClick = _ => setCollectionId(_ => Some(item.id))
    <Item
      key=item.title
      title=item.title
      onClick
      isSelected={collectionId->Option.filter(id => id == item.id)->Option.isSome}
    />
  })

  <React.Fragment>
    <Item
      title="Notes"
      isSelected={collectionId->Option.isNone}
      onClick={_ => setCollectionId(_ => None)}
    />
    {React.array(collections)}
  </React.Fragment>
}
