open Note

module Collection = {
  type t = {
    id: int,
    title: string,
    notes: array<Note.t>,
  }

  let defaultCollections: array<t> = [
    {
      id: 0,
      title: "Notes",
      notes: [
        {
          id: 0,
          title: "First Note",
          content: "content of the 1st note",
          createdAd: 0,
          updatedAd: 0,
          tags: [],
        },
        {
          id: 1,
          title: "Second Note",
          content: "content of the 2nd note",
          createdAd: 0,
          updatedAd: 0,
          tags: [{id: 1, title: "second"}],
        },
      ],
    },
  ]
}
