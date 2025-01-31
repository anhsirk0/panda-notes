open ReactEvent

@react.component
let make = (~onClose) => {
  let {settings, update} = Store.Settings.use()

  let onSubmit = evt => {
    evt->Form.preventDefault
    let title = Form.target(evt)["title"]["value"]
    let showNoteTitle = Form.target(evt)["note-title-in-document-title"]["checked"]
    let showTagTitle = Form.target(evt)["tag-title-in-document-title"]["checked"]
    update({
      ...settings,
      title,
      showTagTitle,
      showNoteTitle,
    })
    onClose()
  }

  <Modal title="Preferences" onClose classes="min-w-[50vw]">
    <form
      tabIndex=0
      className="flex flex-col gap-2 xl:gap-4 [&>div]:min-w-[100%] min-h-[60vh]"
      onSubmit>
      <Input name="title" label="Document title" required=true defaultValue=settings.title />
      <Checkbox
        name="note-title-in-document-title"
        defaultChecked=settings.showNoteTitle
        label="Show active note title in Document title"
      />
      <Checkbox
        name="tag-title-in-document-title"
        defaultChecked=settings.showTagTitle
        label="Show active tag title in Document title"
      />
      <div className="grow" />
      <div className="flex flex-row gap-4 mt-4 justify-end">
        <button className="btn resp-btn btn-primary"> {React.string("Save")} </button>
      </div>
    </form>
  </Modal>
}
