open Note
open MDEditor

@react.component
let make = (~note: Note.t) => {
  let (value, setValue) = React.useState(_ => note.content)

  <div className="flex flex-col gap-2 grow p-4">
    <div className="text-primary text-4xl font-bold"> {note.title->React.string} </div>
    <div className="border-t border-base-content/20 size-full min-h-0 grow">
      <MDEditor.editor onChange={setValue} value height="100%" preview="preview" />
    </div>
  </div>
}
