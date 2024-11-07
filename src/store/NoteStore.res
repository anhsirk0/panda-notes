open Zustand
open Library

module StoreData = {
  type state = {
    library: Library.t,
    update: Library.t => unit,
  }

  let defaultState = Library.defaultNotes
}

module AppStore = Zustand.MakeStore(StoreData)

module NoteStore = {
  let store = AppStore.create(AppStore.persist(set => {
      library: StoreData.defaultState,
      update: library => set(.state => {...state, library}),
    }, {name: "panda-notes-library"}))

  let use = _ => store->AppStore.use(state => state)
}
