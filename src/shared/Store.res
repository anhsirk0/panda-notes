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

module Notes = {
  module StoreData = {
    type state = {
      library: Shape.Library.t,
      pinned: array<Shape.Note.id>,
      updateNote: Shape.Note.t => unit,
      addNote: Shape.Note.t => unit,
      deleteNote: Shape.Note.id => unit,
      toggleNotePin: (Shape.Note.id, bool) => unit,
    }
  }
  module AppStore = Zustand.MakeStore(StoreData)
  let store = AppStore.create(AppStore.persist(set => {
      library: Shape.Library.defaultNotes,
      pinned: [],
      addNote: note => set(.state => {...state, library: [note]->Array.concat(state.library)}),
      deleteNote: id =>
        set(.state => {...state, library: state.library->Array.filter(n => n.id != id)}),
      updateNote: note =>
        set(.state => {
          ...state,
          library: state.library->Array.map(n => n.id == note.id ? note : n),
        }),
      toggleNotePin: (id, isPinned) =>
        set(.state => {
          ...state,
          pinned: isPinned
            ? state.pinned->Array.filter(i => i != id)
            : state.pinned->Array.concat([id]),
        }),
    }, {name: "panda-notes-library"}))

  let use = _ => store->AppStore.use(state => state)
}

module Settings = {
  type t = {
    theme: string,
    title: string,
    sidebar: bool,
    showNoteTitle: bool,
    showTagTitle: bool,
    showNotesCount: bool,
    showCloseSidebar: bool,
    sort: Shape.Sort.t,
  }
  let defaultSettings = {
    sort: DateDesc,
    theme: "corporate",
    title: "Panda Notes",
    sidebar: true,
    showNoteTitle: true,
    showTagTitle: true,
    showNotesCount: true,
    showCloseSidebar: true,
  }

  module StoreData = {
    type state = {
      settings: t,
      update: t => unit,
      toggleSidebar: unit => unit,
    }
  }

  module AppStore = Zustand.MakeStore(StoreData)
  let store = AppStore.create(AppStore.persist(set => {
      settings: defaultSettings,
      update: settings => set(.state => {...state, settings}),
      toggleSidebar: () =>
        set(.state => {...state, settings: {...state.settings, sidebar: !state.settings.sidebar}}),
    }, {name: "panda-notes-settings"}))

  let use = () => store->AppStore.use(state => state)
}
