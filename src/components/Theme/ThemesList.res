open Themes
open SettingStore
open Utils

@react.component
let make = () => {
  let {settings} = SettingStore.use()

  React.useEffect(() => {
    settings.theme->Utils.setTheme
    None
  }, [])

  let themeCards = Array.map(themes, theme =>
    <ThemeCard theme key=theme>
      <div className="flex flex-row gap-1 rounded-btn [&>div]:h-6 [&>div]:w-2 [&>div]:rounded-box">
        <div className="bg-primary" />
        <div className="bg-accent" />
        <div className="bg-secondary" />
        <div className="bg-neutral" />
      </div>
    </ThemeCard>
  )

  <ul
    id="theme-container"
    tabIndex=0
    className="flex flex-col gap-2 w-[12rem] p-2 min-h-0 overflow-y-auto bg-secondary">
    {React.array(themeCards)}
  </ul>
}
