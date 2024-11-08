open Zustand
open Library
open Note

module StoreData = {
  type state = {
    library: Library.t,
    updateNote: Note.t => unit,
  }

  let defaultState = Library.defaultNotes
}

module AppStore = Zustand.MakeStore(StoreData)

module NoteStore = {
  let store = AppStore.create(AppStore.persist(set => {
      library: StoreData.defaultState,
      updateNote: note =>
        set(.state => {
          ...state,
          library: state.library->Array.map(n => n.id == note.id ? note : n),
        }),
    }, {name: "panda-notes-library"}))

  let use = _ => store->AppStore.use(state => state)
}
