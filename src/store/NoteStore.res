open Zustand
open Library
open Note

module StoreData = {
  type state = {
    library: Library.t,
    favorites: array<int>,
    updateNote: Note.t => unit,
    addNote: Note.t => unit,
    deleteNote: int => unit,
  }
}

module AppStore = Zustand.MakeStore(StoreData)

module NoteStore = {
  let store = AppStore.create(AppStore.persist(set => {
      library: Library.defaultNotes,
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
