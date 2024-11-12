open Note
open Utils
open Tag
open MDEditor
open NoteStore

@react.component
let make = (~note: Note.t, ~tags: array<Tag.t>) => {
  let {updateNote} = NoteStore.use()
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
      tags: note.tags->Array.filter(t => !Tag.eq(t, tag)),
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

  <div className="flex flex-col grow px-4 py-2">
    <NoteTitle title=note.title onSaveTitle />
    <NoteTags noteTags=note.tags onAddTag onDeleteTag />
    <div className="border-t border-base-content/20 size-full min-h-0 grow">
      <MDEditor.editor onChange value height="100%" preview="preview" />
    </div>
  </div>
}
