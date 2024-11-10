open SettingStore
open Icon

@react.component
let make = () => {
  let {settings, toggleSidebar} = SettingStore.use()
  let onClick = _ => toggleSidebar()

  settings.sidebar
    ? <button onClick ariaLabel="close-sidebar" className="btn btn-neutral btn-square resp-btn">
        <Icon.arrowLineLeft className="resp-icon" />
      </button>
    : <button
        onClick ariaLabel="open-sidebar" className="btn btn-ghost btn-square resp-btn animate-grow">
        <Icon.menu className="resp-icon" />
      </button>
}
