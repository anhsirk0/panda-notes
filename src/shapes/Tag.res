module Tag = {
  type t = {
    id: int,
    title: string,
  }

  let eq = (one: t, other: t) => one.id == other.id
}
