@react.component
let make = (~count, ~children) => {
  let {settings} = Store.Settings.use()
  let (isOpen, toggleOpen, _) = Hook.useToggle() // preferences

  let countLabel = count->Int.toString ++ " Note" ++ (count == 1 ? "" : "s")
  let left = settings.sidebar ? "left-0" : "-left-[12rem] xxl:-left-[16rem]"
  <React.Fragment>
    <div className={`fixed top-0 ${left} z-10 w-fit h-full flex flex-row transitional`}>
      <div
        className="w-[12rem] xxl:w-[16rem] p-2 xxl:px-4 flex flex-col gap-1 xxl:gap-2 h-full bg-neutral text-neutral-content">
        <div className="flex flex-row gap-1 items-center justify-between h-9 xxl:h-12">
          <p className="card-title"> {settings.title->React.string} </p>
          <button
            ariaLabel="settings-btn"
            className="btn btn-neutral btn-square resp-btn"
            onClick={_ => toggleOpen()}>
            <Icon.sliders className="resp-icon rotate-90" />
          </button>
        </div>
        {children}
        <div className="grow" />
        <div className="flex flex-row items-center -mb-2">
          {settings.showNotesCount
            ? <p className="text-neutral-content/80 text-lg"> {countLabel->React.string} </p>
            : React.null}
          <div className="grow" />
          {settings.showCloseSidebar ? <ToggleSidebarButton /> : React.null}
        </div>
      </div>
    </div>
    {isOpen ? <Preferences onClose=toggleOpen /> : React.null}
  </React.Fragment>
}
