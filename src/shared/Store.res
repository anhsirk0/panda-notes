module Zustand = {
  module type StoreConfig = {
    type state
  }

  module MakeStore = (Config: StoreConfig) => {
    type set = (. Config.state => Config.state) => unit
    type selector<'a> = Config.state => 'a

    type store

    external unsafeStoreToAny: store => 'a = "%identity"

    let use = (store: store, selector: selector<'a>): 'a => unsafeStoreToAny(store)(. selector)

    type createFnParam = set => Config.state
    type persistOptions = {name: string}

    @module("zustand")
    external create: createFnParam => store = "create"
    @module("zustand/middleware")
    external persist: (createFnParam, persistOptions) => createFnParam = "persist"
  }
}

module Settings = {
  module StoreData = {
    type settings = {theme: string, title: string, sidebar: bool}
    type state = {
      settings: settings,
      update: settings => unit,
      toggleSidebar: unit => unit,
    }

    let defaultSettings = {
      theme: "corporate",
      title: "Panda Notes",
      sidebar: true,
    }
  }

  module AppStore = Zustand.MakeStore(StoreData)
  let store = AppStore.create(AppStore.persist(set => {
      settings: StoreData.defaultSettings,
      update: settings => set(.state => {...state, settings}),
      toggleSidebar: () =>
        set(.state => {...state, settings: {...state.settings, sidebar: !state.settings.sidebar}}),
    }, {name: "panda-notes-settings"}))

  let use = () => store->AppStore.use(state => state)
}

module Notes = {
  module StoreData = {
    type state = {
      library: Shape.Library.t,
      favorites: array<int>,
      updateNote: Shape.Note.t => unit,
      addNote: Shape.Note.t => unit,
      deleteNote: int => unit,
    }
  }
  module AppStore = Zustand.MakeStore(StoreData)
  let store = AppStore.create(AppStore.persist(set => {
      library: Shape.Library.defaultNotes,
      favorites: [],
      addNote: note => set(.state => {...state, library: [note]->Array.concat(state.library)}),
      deleteNote: id =>
        set(.state => {...state, library: state.library->Array.filter(n => n.id != id)}),
      updateNote: note =>
        set(.state => {
          ...state,
          library: state.library->Array.map(n => n.id == note.id ? note : n),
        }),
    }, {name: "panda-notes-library"}))

  let use = _ => store->AppStore.use(state => state)
}
