open SettingStore
open Utils

module MyOverrides = {
  module Elements = {
    type props = {
      ...JsxDOM.domProps,
      @as("data-theme") dataTheme?: string,
    }

    @module("react/jsx-runtime")
    external jsx: (string, props) => Jsx.element = "jsx"

    @module("react/jsx-runtime")
    external jsxs: (string, props) => Jsx.element = "jsx"
    external someElement: Jsx.element => option<Jsx.element> = "%identity"
  }
  @module("react/jsx-runtime")
  external jsx: (React.component<'props>, 'props) => React.element = "jsx"
  external array: array<Jsx.element> => Jsx.element = "%identity"
}

@@jsxConfig({module_: "MyOverrides", mode: "automatic"})

@react.component
let make = (~theme, ~children) => {
  let store = SettingStore.use()

  let onClick = _ => {
    theme->Utils.setTheme
    store.update({theme, name: "Your"})
  }

  let ring = theme == store.settings.theme ? "ring-2 ring-primary" : ""

  <li className={`btn h-10 w-full justify-between ${ring}`} onClick tabIndex=0 dataTheme=theme>
    {theme->React.string}
    <div className="grow" />
    {children}
  </li>
}
