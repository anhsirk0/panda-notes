open Zustand

module StoreData = {
  type settings = {theme: string}
  type state = {
    settings: settings,
    update: settings => unit,
  }

  let defaultSettings = {
    theme: "cupcake",
  }
}

module AppStore = Zustand.MakeStore(StoreData)

module SettingStore = {
  let store = AppStore.create(AppStore.persist(set => {
      settings: StoreData.defaultSettings,
      update: settings => set(.state => {...state, settings}),
    }, {name: "panda-notes-settings"}))

  let use = _ => store->AppStore.use(state => state)
}
