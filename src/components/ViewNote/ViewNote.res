@react.component
let make = (~note: Shape.Note.t, ~tags: array<Shape.Tag.t>) => {
  let {updateNote} = Store.Notes.use()
  let (value, setValue) = React.useState(_ => note.content)
  let (isDebounced, setIsDebounced) = React.useState(_ => true)

  let onChange = fn => {
    setValue(fn)
    if isDebounced {
      setIsDebounced(_ => false)
      let _ = setTimeout(_ => setIsDebounced(_ => true), 800)
    }
  }

  let onSaveTitle = title => updateNote({...note, title, updatedAt: Date.now()})
  let onAddTag = tagTitle => {
    let tag =
      tags
      ->Array.find(t => t.title->String.toLowerCase == tagTitle->String.toLowerCase)
      ->Option.getOr({id: Date.now()->Float.toInt, title: tagTitle})
    updateNote({...note, tags: note.tags->Array.concat([tag]), updatedAt: Date.now()})
  }
  let onDeleteTag = tag => {
    updateNote({
      ...note,
      tags: note.tags->Array.filter(t => !Shape.Tag.eq(t, tag)),
      updatedAt: Date.now(),
    })
  }

  React.useEffect(() => {
    if value != note.content && isDebounced {
      updateNote({...note, content: value, updatedAt: Date.now()})
    }
    None
  }, [isDebounced])

  React.useEffect0(() => {
    if value->String.length < 1 {
      "button[data-name=edit]"->Utils.querySelectAndThen(Utils.click)
    }
    None
  })

  <div className="flex flex-col grow px-4 py-2 relative">
    <div className="dropdown dropdown-bottom dropdown-end z-10">
      <label
        ariaLabel={`info-${note.title}`}
        tabIndex=0
        className="btn btn-sm btn-circle btn-ghost absolute top-2 right-2">
        <Icon.info className="resp-icon" />
      </label>
      <div
        tabIndex=0
        className="dropdown-content z-10 shadow mt-10 bg-secondary text-secondary-content rounded-box p-4 flex flex-col">
        <p className="text-secondary-content/80">
          {"Updated At:"->React.string}
          <span className="text-secondary-content font-medium ml-2">
            {note.updatedAt->Utils.toRelativeDateStr->React.string}
          </span>
        </p>
        <p className="text-secondary-content/80">
          {"Created At:"->React.string}
          <span className="text-secondary-content font-medium ml-2">
            {note.createdAt->Utils.toDateStr->React.string}
          </span>
        </p>
      </div>
    </div>
    <NoteTitle title=note.title onSaveTitle />
    <NoteTags noteTags=note.tags onAddTag onDeleteTag />
    <div className="border-t border-base-content/20 size-full min-h-0 grow">
      <MDEditor.editor onChange value height="100%" preview="preview" />
    </div>
  </div>
}
