open Note

module Library = {
  type t = array<Note.t>

  let defaultNotes: t = [
    {
      id: 20,
      title: "First Note",
      content: "# content of the 1st note\n## h2\n - [ ] First\n - [X] Second\n - [ ] Third\n",
      createdAt: 0.0,
      updatedAt: 0.0,
      tags: [],
    },
    {
      id: 21,
      title: "Second Note",
      content: "content of the 2nd note",
      createdAt: 0.0,
      updatedAt: 0.0,
      tags: [{id: 1, title: "Second"}, {id: 3, title: "Third"}],
    },
    {
      id: 22,
      title: "Third Note",
      content: "content of the 3rd note",
      createdAt: 0.0,
      updatedAt: 0.0,
      tags: [{id: 3, title: "Third"}],
    },
    {
      id: 23,
      title: "Fourth Note",
      content: "content of the 4th note",
      createdAt: 0.0,
      updatedAt: 0.0,
      tags: [{id: 1, title: "Second"}],
    },
  ]
}
