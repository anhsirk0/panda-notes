open SettingStore
open Icon

@react.component
let make = (~count, ~children) => {
  let {settings} = SettingStore.use()

  let left = settings.sidebar ? "-left-[12rem]" : "-left-[28rem] xxl:-left-[32rem]"
  let pos = `${left} has-[#theme-btn:focus]:left-0 has-[#theme-container>*:focus]:left-0`
  let countLabel = count->Int.toString ++ " Note" ++ (count == 1 ? "" : "s")

  <React.Fragment>
    <div className={`fixed top-0 ${pos} z-10 w-fit h-full flex flex-row transitional`}>
      <ThemesList />
      <div
        className="w-[12rem] xxl:w-[16rem] p-2 xxl:p-2 flex flex-col gap-1 xxl:gap-2 h-full bg-neutral text-neutral-content">
        <div className="flex flex-row gap-1 items-center justify-between">
          <p className="card-title"> {settings.title->React.string} </p>
          // <button ariaLabel="settings-btn" className="btn btn-neutral btn-square resp-btn">
          //   <Icon.sliders className="resp-icon rotate-90" />
          // </button>
        </div>
        {children}
        <div className="grow" />
        <div className="flex flex-row items-center">
          <p className="text-neutral-content"> {countLabel->React.string} </p>
          <div className="grow" />
          <button
            ariaLabel="select-theme-btn"
            id="theme-btn"
            className="btn btn-neutral btn-square resp-btn">
            <Icon.palette className="resp-icon" />
          </button>
          <ToggleSidebarButton />
        </div>
      </div>
    </div>
  </React.Fragment>
}
