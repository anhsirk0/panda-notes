open Tag

module Item = {
  @react.component
  let make = (~title, ~isSelected=false, ~onClick) => {
    let bg = isSelected ? "bg-neutral-content/20 text-neutral-content font-medium" : ""
    let className = `flex flex-row p-1 xxl:p-2 px-2 xxl:px-4 gap-2 ${bg} rounded-box relative isolate overflow-hidden items-center cursor-pointer hover:bg-neutral-content/25`
    <div role="button" className onClick> {title->React.string} </div>
  }
}

@react.component
let make = (~tag, ~setTag, ~tags, ~setNoteId) => {
  let tagItems = tags->Array.map(item => {
    let onClick = _ => {
      setTag(_ => Some(item))
      setNoteId(_ => None)
    }
    let isSelected = tag->Option.filter(Tag.eq(_, item))->Option.isSome
    <Item key=item.title title=item.title onClick isSelected />
  })

  <React.Fragment>
    <Item title="Notes" isSelected={tag->Option.isNone} onClick={_ => setTag(_ => None)} />
    {React.array(tagItems)}
  </React.Fragment>
}
