@react.component
let make = () => {
  let {settings} = Store.Settings.use()

  <React.Fragment>
    <Input
      name="title"
      label="Document title"
      required=true
      defaultValue=settings.title
      autoComplete="off"
    />
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
    <Checkbox
      name="note-count-in-sidebar"
      defaultChecked=settings.showNotesCount
      label="Show notes counts in the sidebar"
    />
    <Checkbox
      name="close-sidebar-btn"
      defaultChecked=settings.showCloseSidebar
      label="Show close sidebar button in the sidebar"
    />
    <div className="grow" />
    <div className="flex flex-row gap-4 mt-4 justify-end">
      <button className="btn resp-btn btn-primary"> {React.string("Save")} </button>
    </div>
  </React.Fragment>
}
