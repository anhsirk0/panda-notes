@react.component
let make = (~tags: array<Shape.Tag.t>, ~noteTags: array<Shape.Tag.t>, ~onAddTag, ~onDeleteTag) => {
  let (value, setValue) = React.useState(_ => "")

  let tagItems = noteTags->Array.map(tag => {
    let onClick = _ => onDeleteTag(tag)

    <div key={tag.id->Float.toString} className="badge badge-neutral badge-lg">
      {tag.title->React.string}
      <button type_="button" onClick className="btn btn-xs btn-ghost btn-circle ml-1 -mr-2.5">
        <Icon.x className="text-base text-neutral-content/80" />
      </button>
    </div>
  })

  let onChange = evt => {
    let target = ReactEvent.Form.target(evt)
    let newValue: string = target["value"]
    setValue(_ => newValue)
  }

  let onSave = () => {
    if value->String.length > 0 {
      if tags->Array.some(t => t.title == value) {
        Toast.error("Tag with same name already exists")
      } else {
        onAddTag(value)
        setValue(_ => "")
      }
    }
  }

  let onSubmit = evt => {
    evt->ReactEvent.Form.preventDefault
    onSave()
  }

  <form onSubmit className="flex flex-row gap-2 w-full items-center mb-2">
    {React.array(tagItems)}
    <InputBase
      className="input input-ghost input-xs focus:outline-none" placeholder="+ tag" value onChange
    />
  </form>
}
