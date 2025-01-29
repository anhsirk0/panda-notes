@react.component
let make = (~tag: option<Shape.Tag.t>, ~query, ~setQuery) => {
  let {addNote} = Store.Notes.use()
  let {settings, update} = Store.Settings.use()

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
    let note: Shape.Note.t = {
      id: now,
      title: "New note",
      content: "",
      createdAt: now,
      updatedAt: now,
      tags: tag->Option.map(t => [t])->Option.getOr([]),
    }
    addNote(note)
    RescriptReactRouter.push(`?note-id=${now->Float.toString}`)
  }

  let toggleSort = _ => {
    update({
      ...settings,
      sort: switch settings.sort {
      | DateAsc => DateDesc
      | DateDesc => DateAsc
      },
    })
  }

  isSearching
    ? <label
        className="input input-sm xxl:input-md input-bordered flex items-center gap-2 my-2 outline-none">
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
    : <div className="flex flex-row my-2 items-center">
        {settings.sidebar ? React.null : <ToggleSidebarButton />}
        <p className="card-title line-clamp-1">
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
        <button
          onClick=toggleSort ariaLabel="toggle-sort" className="btn btn-ghost btn-square resp-btn">
          {switch settings.sort {
          | DateAsc => <Icon.sortDescending className="resp-icon text-base-content/80" />
          | DateDesc => <Icon.sortAscending className="resp-icon text-base-content/80" />
          }}
        </button>
      </div>
}
