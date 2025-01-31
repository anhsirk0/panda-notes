@react.component
let make = () => {
  let {settings, update} = Store.Settings.use()

  let onChange = theme => {
    theme->Utils.setTheme
    update({...settings, theme})
  }

  let themeCards = Array.map(Themes.themes, theme =>
    <ThemeCard theme onChange key=theme>
      <div
        className="flex flex-row rounded-box bg-base-100 border-4 border-neutral relative cursor-pointer">
        <div className="w-8 min-h-[100%] bg-neutral" />
        <div className="flex flex-col grow p-4">
          <p className="title font-bold"> {theme->Utils.toCapitalize->React.string} </p>
          <div
            className="flex flex-row gap-1 rounded-btn [&>div]:h-6 [&>div]:w-2 [&>div]:rounded-box">
            <div className="bg-primary" />
            <div className="bg-accent" />
            <div className="bg-secondary" />
            <div className="bg-neutral" />
          </div>
          {settings.theme == theme
            ? <Icon.sparkle
                className="size-4 text-neutral-content absolute top-1 left-1 animate-grow"
                weight="fill"
              />
            : React.null}
        </div>
      </div>
    </ThemeCard>
  )

  <ul id="theme-container" tabIndex=0 className="grid grid-cols-12 gap-4 min-h-0 overflow-y-auto">
    {React.array(themeCards)}
  </ul>
}
