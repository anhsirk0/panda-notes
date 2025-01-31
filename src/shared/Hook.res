let useDocTitle = title => {
  let {settings} = Store.Settings.use()

  React.useEffectOnEveryRender(() => {
    Utils.setDocTitle(title, settings.title)
    None
  })
}

let useToggle = (~init: bool=false) => {
  let (isOpen, setIsOpen) = React.useState(_ => init)
  let toggleOpen = () => setIsOpen(val => !val)
  (isOpen, toggleOpen, setIsOpen)
}
