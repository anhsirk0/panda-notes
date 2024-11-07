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
      title: "My Notes",
      notes: [
        {
          id: 10,
          title: "First Note",
          content: "content of the 1st note",
          createdAd: 0,
          updatedAd: 0,
          tags: [],
        },
        {
          id: 11,
          title: "Second Note",
          content: "content of the 2nd note",
          createdAd: 0,
          updatedAd: 0,
          tags: [{id: 1, title: "second"}],
        },
        {
          id: 12,
          title: "Third Note",
          content: "content of the 3rd note",
          createdAd: 0,
          updatedAd: 0,
          tags: [{id: 1, title: "second"}],
        },
      ],
    },
    {
      id: 1,
      title: "Other Notes",
      notes: [
        {
          id: 20,
          title: "First Note",
          content: "content of the 1st note",
          createdAd: 0,
          updatedAd: 0,
          tags: [],
        },
        {
          id: 21,
          title: "Second Note",
          content: "content of the 2nd note",
          createdAd: 0,
          updatedAd: 0,
          tags: [{id: 1, title: "second"}],
        },
        {
          id: 22,
          title: "Third Note",
          content: "content of the 3rd note",
          createdAd: 0,
          updatedAd: 0,
          tags: [{id: 1, title: "second"}],
        },
        {
          id: 23,
          title: "Third Note",
          content: "content of the 4th note",
          createdAd: 0,
          updatedAd: 0,
          tags: [{id: 1, title: "second"}],
        },
      ],
    },
  ]
}
