open Note

module Library = {
  type t = array<Note.t>

  let defaultNotes: t = [
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
      tags: [{id: 1, title: "Second"}],
    },
    {
      id: 22,
      title: "Third Note",
      content: "content of the 3rd note",
      createdAd: 0,
      updatedAd: 0,
      tags: [{id: 3, title: "Third"}],
    },
    {
      id: 23,
      title: "Fourth Note",
      content: "content of the 4th note",
      createdAd: 0,
      updatedAd: 0,
      tags: [{id: 1, title: "Second"}],
    },
  ]
}
