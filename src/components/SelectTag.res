module Item = {
  @react.component
  let make = (~title, ~isSelected, ~onClick, ~isTag=false, ~icon=Icon.hash) => {
    let bg = isSelected ? "bg-neutral-content/20 text-neutral-content font-medium" : ""
    let className = `flex flex-row p-1 xxl:p-2 px-4 gap-2 ${bg} rounded-box relative isolate overflow-hidden items-center cursor-pointer hover:bg-neutral-content/25`
    <div role="button" className onClick>
      {React.createElement(icon, {className: "resp-icon text-neutral-content/80"})}
      <span className="truncate grow"> {title->React.string} </span>
      // <button className="btn btn-sm"> {"Empty"->React.string} </button> // TODO
    </div>
  }
}

@react.component
let make = (~tag: Shape.Tag.kind, ~setTag, ~tags, ~showTrash) => {
  let {settings} = Store.Settings.use()

  let tagItems = tags->Array.map((item: Shape.Tag.t) => {
    let onClick = _ => {
      setTag(_ => Shape.Tag.Tag(item))
      RescriptReactRouter.push("/")
    }
    let isSelected = switch tag {
    | Home => false
    | Trash => false
    | Tag(t) => Shape.Tag.eq(t, item)
    }

    <Item key=item.title title=item.title onClick isSelected isTag=true />
  })

  <React.Fragment>
    <Item
      title="Notes"
      isSelected={tag == Home}
      onClick={_ => {
        setTag(_ => Home)
        Utils.setDocTitle(None, settings.title)
      }}
      icon={Icon.notepad}
    />
    {showTrash
      ? <Item
          title="Trash"
          isSelected={tag == Trash}
          onClick={_ => {
            setTag(_ => Trash)
            Utils.setDocTitle(None, settings.title)
          }}
          icon={Icon.trash}
        />
      : React.null}
    {React.array(tagItems)}
  </React.Fragment>
}
