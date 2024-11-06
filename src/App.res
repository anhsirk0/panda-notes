open SettingStore

@react.component
let make = () => {
  let {settings} = SettingStore.use()
  let (collectionId, setCollectionId) = React.useState(_ => None)
  let (noteId, setNoteId) = React.useState(_ => None)
  let leftP = settings.sidebar ? "pl-[18rem]" : "pl-0"

  <React.Fragment>
    <Sidebar collectionId setCollectionId />
    <div className={`flex flex-row transitional ${leftP} h-full`}>
      <SelectNote collectionId noteId setNoteId />
      <div className="text-7xl p-8">
        {"Praesent tristique magna sit amet purus gravida quis blandit turpis cursus in hac habitasse platea dictumst quisque sagittis, purus sit amet volutpat consequat. Sapien nec sagittis aliquam malesuada bibendum arcu."->React.string}
      </div>
    </div>
  </React.Fragment>
}
