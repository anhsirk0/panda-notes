open SettingStore
open Icon

module NoteItem = {
  @react.component
  let make = (~isSelected=false) => {
    let bg = isSelected ? "bg-base-200/60" : ""
    <div className={`card card-compact ${bg} w-full relative overflow-hidden shrink-0`}>
      {isSelected
        ? <div className="absolute inset-0 h-full w-2 bg-primary" />
        : <div className="absolute bottom-0 left-[5%] h-[1px] w-[90%] bg-base-content/10" />}
      <div className="card-body">
        <h2 className="card-title"> {"Card title"->React.string} </h2>
        <p> {"If a dog chews shoes whose shoes does he choose?"->React.string} </p>
        <div className="card-actions justify-end">
          <button className="btn"> {"Buy Now"->React.string} </button>
        </div>
      </div>
    </div>
  }
}

@react.component
let make = () => {
  let {settings, toggleSidebar} = SettingStore.use()
  let onClick = _ => toggleSidebar()

  <div className="flex flex-col gap-2 px-4 pt-0 border-r border-base-content/20 h-full">
    <div className="flex flex-row gap-1 my-2 items-center">
      {settings.sidebar
        ? React.null
        : <button
            onClick
            ariaLabel="open-sidebar"
            className="btn btn-ghost btn-square resp-btn animate-grow">
            <Icon.menu className="resp-icon" />
          </button>}
      <p className="card-title"> {"Notes"->React.string} </p>
      <div className="grow" />
      <button ariaLabel="add-note" className="btn btn-ghost btn-square resp-btn">
        <Icon.notePencil className="resp-icon" />
      </button>
      <button ariaLabel="search-note" className="btn btn-ghost btn-square resp-btn">
        <Icon.magnifyingGlass className="resp-icon" />
      </button>
    </div>
    <div className="flex flex-col gap-2 min-h-0 overflow-y-auto w-96">
      <NoteItem isSelected=true />
      <NoteItem />
      <NoteItem />
      <NoteItem />
      <NoteItem />
      <NoteItem />
      <NoteItem />
    </div>
  </div>
}
