@react.component
let make = (~note: Shape.Note.t, ~tags: array<Shape.Tag.t>) => {
  let {settings} = Store.Settings.use()
  let {updateNote} = Store.Notes.use()

  Hook.useDocTitle(settings.showNoteTitle ? Some(note.title) : None)

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
      ->Option.getOr({id: Date.now(), title: tagTitle})

    let newTags =
      note.tags->Array.some(Shape.Tag.eq(tag, _)) ? note.tags : note.tags->Array.concat([tag])
    updateNote({...note, tags: newTags, updatedAt: Date.now()})
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
    <NoteOptions note />
    <NoteTitle title=note.title onSaveTitle />
    <NoteTags noteTags=note.tags onAddTag onDeleteTag />
    <div className="border-t border-base-content/20 size-full min-h-0 grow">
      <MDEditor.editor onChange value height="100%" preview="preview" />
    </div>
  </div>
}
