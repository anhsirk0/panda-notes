open ReactEvent

// module Tab = {
//   @react.component
//   let make = (~tab, ~setActiveTab, ~title) => {
//     let tabClasses = `tab ${activeTab == tab ? "tab-active" : ""}`

//     <a role="tab" className={makeTabClasses(General)} onClick={_ => setActiveTab(_ => General)}>
//       {title->React.string}
//     </a>
//   }
// }

@react.component
let make = (~onClose) => {
  let (activeTab, setActiveTab) = React.useState(_ => Shape.PrefTabs.General)

  let {settings, update} = Store.Settings.use()

  let onSubmit = evt => {
    evt->Form.preventDefault
    let title = Form.target(evt)["title"]["value"]
    let showNoteTitle = Form.target(evt)["note-title-in-document-title"]["checked"]
    let showTagTitle = Form.target(evt)["tag-title-in-document-title"]["checked"]
    let showNotesCount = Form.target(evt)["note-count-in-sidebar"]["checked"]
    let showCloseSidebar = Form.target(evt)["close-sidebar-btn"]["checked"]
    update({
      ...settings,
      title,
      showTagTitle,
      showNoteTitle,
      showNotesCount,
      showCloseSidebar,
    })
    onClose()
  }

  let makeTab = (tab, title) => {
    let className = `tab ${activeTab == tab ? "tab-active" : ""}`
    <a role="tab" className onClick={_ => setActiveTab(_ => tab)}> {title->React.string} </a>
  }

  <Modal title="Preferences" onClose classes="min-w-[50vw]">
    <div role="tablist" className="tabs tabs-bordered">
      {makeTab(General, "General")}
      {makeTab(Theme, "Theme")}
    </div>
    <form
      tabIndex=0
      className="flex flex-col gap-2 xl:gap-4 [&>div]:min-w-[100%] min-h-[60vh] max-h-[60vh] pt-4"
      onSubmit>
      {switch activeTab {
      | General => <GeneralSettings />
      | Theme => <ThemeSettings />
      }}
    </form>
  </Modal>
}
