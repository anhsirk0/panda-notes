open SettingStore
open NoteStore
open Icon

@react.component
let make = () => {
  let {settings, toggleSidebar} = SettingStore.use()
  let {library} = NoteStore.use()
  let onClick = _ => toggleSidebar()

  let left = settings.sidebar ? "-left-56" : "-left-[34rem]"
  let pos = `${left} has-[#theme-btn:focus]:left-0 has-[#theme-container>*:focus]:left-0`

  let collections = library->Array.map(col => {
    <div key=col.title className="flex flex-row"> {col.title->React.string} </div>
  })

  <React.Fragment>
    <div className={`fixed top-0 ${pos} z-10 w-fit h-full flex flex-row transitional`}>
      <ul
        onWheel=ReactEvent.Wheel.stopPropagation
        id="theme-container"
        tabIndex=0
        className="flex flex-col gap-4 w-56 p-4 min-h-0 overflow-y-auto bg-secondary">
        <ThemesList />
      </ul>
      <div
        id="sidebar"
        className="w-72 p-1 xxl:p-2 flex flex-col gap-1 xxl:gap-2 h-full bg-neutral text-neutral-content">
        <div className="flex flex-row gap-2 items-center justify-between">
          <p className="card-title"> {settings.title->React.string} </p>
          <button ariaLabel="settings-btn" className="btn btn-ghost btn-square resp-btn">
            <Icon.sliders className="resp-icon rotate-90" />
          </button>
        </div>
        {React.array(collections)}
        <div className="grow" />
        <div className="flex flex-row items-center">
          <button ariaLabel="add-collection-btn" className="btn btn-neutral resp-btn">
            <Icon.listPlus className="resp-icon" />
            {"New collection"->React.string}
          </button>
          <div className="grow" />
          <button
            ariaLabel="select-theme-btn"
            id="theme-btn"
            className="btn btn-ghost btn-square resp-btn">
            <Icon.palette className="resp-icon" />
          </button>
          <button onClick ariaLabel="close-sidebar" className="btn btn-ghost btn-square resp-btn">
            <Icon.arrowLineLeft className="resp-icon" />
          </button>
        </div>
      </div>
    </div>
  </React.Fragment>
}
