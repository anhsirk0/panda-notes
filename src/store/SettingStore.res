open Zustand

module StoreData = {
  type settings = {theme: string, name: string, sidebar: bool}
  type state = {
    settings: settings,
    update: settings => unit,
    toggleSidebar: unit => unit,
  }

  let defaultSettings = {
    theme: "cupcake",
    name: "Your",
    sidebar: true,
  }
}

module AppStore = Zustand.MakeStore(StoreData)

module SettingStore = {
  let store = AppStore.create(AppStore.persist(set => {
      settings: StoreData.defaultSettings,
      update: settings => set(.state => {...state, settings}),
      toggleSidebar: () =>
        set(.state => {...state, settings: {...state.settings, sidebar: !state.settings.sidebar}}),
    }, {name: "panda-notes-settings"}))

  let use = _ => store->AppStore.use(state => state)
}
