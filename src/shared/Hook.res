let useDocTitle = (title: string) => {
  React.useEffect0(() => {
    Document.document->Document.setTitle(`${title} • Panda Notes`)
    None
  })
}
