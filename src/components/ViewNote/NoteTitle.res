@react.component
let make = (~title, ~onSaveTitle) => {
  let (value, setValue) = React.useState(_ => title)

  let onChange = evt => {
    let target = ReactEvent.Form.target(evt)
    let newValue: string = target["value"]
    setValue(_ => newValue)
  }

  let onSave = () => {
    if value != title && value->String.length > 0 {
      onSaveTitle(value)
    }
  }

  let onSubmit = evt => {
    evt->ReactEvent.Form.preventDefault
    onSave()
  }

  <form onSubmit className="flex flex-row w-fit -mt-2">
    <InputBase
      className="text-primary text-3xl xxl:text-4xl font-bold bg-transparent items-center h-14 outline-none"
      value
      onChange
      onBlur={_ => onSave()}
    />
  </form>
}
