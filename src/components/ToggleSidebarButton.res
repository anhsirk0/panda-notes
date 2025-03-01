@react.component
let make = () => {
  let {settings, toggleSidebar} = Store.Settings.use()
  let onClick = _ => toggleSidebar()

  settings.sidebar
    ? <button onClick ariaLabel="close-sidebar" className="btn btn-neutral btn-square resp-btn">
        <Icon.caretLineLeft className="resp-icon" />
      </button>
    : <button
        onClick ariaLabel="open-sidebar" className="btn btn-ghost btn-square resp-btn animate-grow">
        <Icon.menu className="resp-icon" />
      </button>
}
