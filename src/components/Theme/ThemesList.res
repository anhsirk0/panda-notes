@react.component
let make = () => {
  let {settings, update} = Store.Settings.use()

  let onChange = theme => {
    theme->Utils.setTheme
    update({...settings, theme})
  }

  React.useEffect0(() => {
    settings.theme->Utils.setTheme
    None
  })

  let themeCards = Array.map(Themes.themes, theme =>
    <ThemeCard theme onChange key=theme>
      {theme->React.string}
      <div className="flex flex-row gap-1 rounded-btn [&>div]:h-6 [&>div]:w-2 [&>div]:rounded-box">
        <div className="bg-primary" />
        <div className="bg-accent" />
        <div className="bg-secondary" />
        <div className="bg-neutral" />
      </div>
      {settings.theme == theme
        ? <Icon.sparkle className="size-4 absolute top-1 left-1 animate-grow" weight="fill" />
        : React.null}
    </ThemeCard>
  )

  <ul
    id="theme-container"
    tabIndex=0
    className="flex flex-col gap-2 w-[13rem] p-2 min-h-0 overflow-y-auto bg-secondary">
    {React.array(themeCards)}
  </ul>
}
