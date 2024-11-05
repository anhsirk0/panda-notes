open Note

module Collection = {
  type t = {
    id: int,
    title: string,
    notes: array<Note.t>,
  }
}
