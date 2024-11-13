open Note
open Icon
open Tag
open NoteStore
open SettingStore

@react.component
let make = (~tag: option<Tag.t>, ~setNoteId, ~query, ~setQuery) => {
  let {addNote} = NoteStore.use()
  let {settings} = SettingStore.use()

  let (isSearching, setIsSearching) = React.useState(_ => false)
  let toggleSearching = _ => {
    setIsSearching(val => !val)
    setQuery(_ => "")
  }
  let onChange = evt => {
    let target = ReactEvent.Form.target(evt)
    let newValue: string = target["value"]
    setQuery(_ => newValue)
  }

  let onAdd = _ => {
    let now = Date.now()
    let note: Note.t = {
      id: now->Float.toInt,
      title: "New note",
      content: "",
      createdAt: now,
      updatedAt: now,
      tags: tag->Option.map(t => [t])->Option.getOr([]),
    }
    addNote(note)
    setNoteId(_ => Some(note.id))
  }

  isSearching
    ? <label className="input input-sm input-bordered flex items-center gap-2 my-2 outline-none">
        <InputBase
          value=query
          onChange
          className="grow outline-none focus:outline-none"
          placeholder="Search"
          autoFocus=true
        />
        <button onClick=toggleSearching className="btn btn-sm btn-ghost btn-circle -mr-2">
          <Icon.x className="resp-icon text-base-content/80" />
        </button>
      </label>
    : <div className="flex flex-row gap-1 my-2 items-center">
        {settings.sidebar ? React.null : <ToggleSidebarButton />}
        <p className="card-title">
          {tag->Option.map(t => "#" ++ t.title)->Option.getOr("Notes")->React.string}
        </p>
        <div className="grow" />
        <button onClick=onAdd ariaLabel="add-note" className="btn btn-ghost btn-square resp-btn">
          <Icon.notePencil className="resp-icon text-base-content/80" />
        </button>
        <button
          onClick=toggleSearching
          ariaLabel="search-note"
          className="btn btn-ghost btn-square resp-btn">
          <Icon.magnifyingGlass className="resp-icon text-base-content/80" />
        </button>
      </div>
}
