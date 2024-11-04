open Icon

@react.component
let make = () => {
  let pos = "-left-56 has-[#theme-btn:focus]:left-0 has-[#theme-container>*:focus]:left-0"

  <div className={`fixed top-0 ${pos} z-10 w-fit h-full flex flex-row transitional`}>
    <ul
      onWheel=ReactEvent.Wheel.stopPropagation
      id="theme-container"
      tabIndex=0
      className="flex flex-col gap-4 w-56 p-4 min-h-0 overflow-y-auto bg-secondary">
      <ThemesList />
    </ul>
    <div id="sidebar" className="w-72 p-1 xxl:p-2 flex flex-col gap-1 xxl:gap-2 h-full bg-neutral">
      <div className="grow" />
      <div className="flex flex-row gap-2">
        <button
          ariaLabel="select-theme-btn" id="theme-btn" className="btn btn-ghost resp-btn w-full">
          <Icon.palette className="resp-icon text-accent" />
        </button>
      </div>
    </div>
  </div>
}
