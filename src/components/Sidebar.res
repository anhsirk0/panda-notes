open SettingStore
open Icon

@react.component
let make = () => {
  let {settings, toggleSidebar} = SettingStore.use()
  let onClick = _ => toggleSidebar()

  let left = settings.sidebar ? "-left-[12rem]" : "-left-[30rem] xxl:-left-[34rem]"
  let pos = `${left} has-[#theme-btn:focus]:left-0 has-[#theme-container>*:focus]:left-0`

  <React.Fragment>
    <div className={`fixed top-0 ${pos} z-10 w-fit h-full flex flex-row transitional`}>
      <ThemesList />
      <div
        id="sidebar"
        className="w-[14rem] xxl:w-[18rem] p-1 xxl:p-2 flex flex-col gap-1 xxl:gap-2 h-full bg-neutral text-neutral-content">
        <div className="flex flex-row gap-2 items-center justify-between">
          <p className="card-title"> {settings.title->React.string} </p>
          <button ariaLabel="settings-btn" className="btn btn-neutral btn-square resp-btn">
            <Icon.sliders className="resp-icon rotate-90" />
          </button>
        </div>
        <SelectCollection />
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
            className="btn btn-neutral btn-square resp-btn">
            <Icon.palette className="resp-icon" />
          </button>
          <button onClick ariaLabel="close-sidebar" className="btn btn-neutral btn-square resp-btn">
            <Icon.arrowLineLeft className="resp-icon" />
          </button>
        </div>
      </div>
    </div>
  </React.Fragment>
}
