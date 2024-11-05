open Tag

module Note = {
  type t = {
    id: int,
    title: string,
    content: string,
    createdAd: int,
    updatedAd: int,
    tags: array<Tag.t>,
  }
}
