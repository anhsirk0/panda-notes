open Tag

module Note = {
  type t = {
    id: int,
    title: string,
    content: string,
    createdAt: float,
    updatedAt: float,
    tags: array<Tag.t>,
  }
}
