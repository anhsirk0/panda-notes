module MDEditor = {
  type props = {
    value: string,
    onChange: (string => string) => unit,
    height: string,
    preview: string,
  }
  type t = React.component<props>

  @module("@uiw/react-md-editor") external editor: t = "default"
}
