open Zustand
open Collection

module StoreData = {
  type library = array<Collection.t>
  type state = {
    library: library,
    update: library => unit,
  }

  let defaultState = Collection.defaultCollections
}

module AppStore = Zustand.MakeStore(StoreData)

module NoteStore = {
  let store = AppStore.create(AppStore.persist(set => {
      library: StoreData.defaultState,
      update: library => set(.state => {...state, library}),
    }, {name: "panda-notes-library"}))

  let use = _ => store->AppStore.use(state => state)
}
