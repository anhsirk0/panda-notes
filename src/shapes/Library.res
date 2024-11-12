open Note

module Library = {
  type t = array<Note.t>

  let defaultNotes: t = [
    {
      id: 0,
      title: "Welcome",
      content: "# Welcome to Panda notes
markdown notes with tag support

# Markdown Cheatsheet

## **Index**

1. [Headings](#1-headings)
2. [Text Styling](#2-text-styling)
   - [Bold](#bold)
   - [Italics](#italics)
   - [Strikethrough](#strikethrough)
   - [Code (Inline)](#code-inline)
   - [Code Block](#code-block)
3. [Lists](#3-lists)
   - [Unordered List](#unordered-list)
   - [Ordered List](#ordered-list)
4. [Links & Images](#4-links--images)
   - [Link](#link)
   - [Image](#image)
   - [Image with Attributes](#image-with-attributes)
5. [Blockquotes](#5-blockquotes)
6. [Horizontal Rule](#6-horizontal-rule)
7. [Tables](#7-tables)
   - [Table Alignment](#table-alignment)
8. [Task Lists](#8-task-lists)
9. [Footnotes](#9-footnotes)
10. [Emoji](#10-emoji)
11. [Escaping Characters](#11-escaping-characters)
12. [To Add an Index (Table of Contents)](#12-to-add-an-index-table-of-contents)

---

## 1. **Headings**

Create headings with hash (`#`) symbols. The number of `#` corresponds to the heading level.

```markdown
# Heading 1

## Heading 2

### Heading 3

#### Heading 4

##### Heading 5

###### Heading 6
```

### Rendered Example:

# Heading 1

## Heading 2

### Heading 3

#### Heading 4

##### Heading 5

###### Heading 6

---

## 2. **Text Styling**

### **Bold**

```markdown
**Bold Text**
```

### Rendered Example:

**Bold Text**

---

### **Italics**

```markdown
_Italic Text_
```

### Rendered Example:

_Italic Text_

---

### **Strikethrough**

```markdown
~~Strikethrough~~
```

### Rendered Example:

~~Strikethrough~~

---

### **Code (Inline)**

Use backticks (\`) for inline code.

```markdown
`inline code`
```

### Rendered Example:

`inline code`

---

### **Code Block**

Use three backticks (\`\`\`) for code blocks. Optionally, specify the language for syntax highlighting.

````markdown
```python
def hello_world():
    print(\"Hello, World!\")
```
````

### Rendered Example:

```python
def hello_world():
    print(\"Hello, World!\")
```

---

## 3. **Lists**

### **Unordered List**

Use asterisks (`*`), plus signs (`+`), or hyphens (`-`).

```markdown
- Item 1
- Item 2
  - Sub-item 1
  - Sub-item 2
```

### Rendered Example:

- Item 1
- Item 2
  - Sub-item 1
  - Sub-item 2

---

### **Ordered List**

Number items with numbers followed by a period.

```markdown
1. First item
2. Second item
3. Third item
```

### Rendered Example:

1. First item
2. Second item
3. Third item

---

## 4. **Links & Images**

### **Link**

```markdown
[Link Text](http://example.com)
```

### Rendered Example:

[Link Text](http://example.com)

---

### **Image**

```markdown
![Alt Text](http://example.com/image.jpg)
```

### Rendered Example:

![Alt Text](http://example.com/image.jpg)

---

### **Image with Attributes (Advanced)**

You can add attributes like height, width, and others by embedding HTML inside Markdown. Markdown itself doesn't support attributes, but HTML can be used for fine-tuned control over image properties.

```markdown
<img src=\"http://example.com/image.jpg\" alt=\"Image Description\" width=\"300\" height=\"200\"/>
```

### Rendered Example:

<img src=\"http://example.com/image.jpg\" alt=\"Image Description\" width=\"300\" height=\"200\"/>

---

### **Link with Title**

```markdown
[Link Text](http://example.com \"Optional Title Here\")
```

### Rendered Example:

[Link Text](http://example.com \"Optional Title Here\")

---

## 5. **Blockquotes**

Create blockquotes using the greater-than symbol (`>`).

```markdown
> This is a blockquote.
>
> It can span multiple lines.
```

### Rendered Example:

> This is a blockquote.
>
> It can span multiple lines.

---

## 6. **Horizontal Rule**

Create a horizontal line with three hyphens (`---`), asterisks (`***`), or underscores (`___`).

```markdown
---
```

### Rendered Example:

---

---

## 7. **Tables**

Tables are created with pipes (`|`) and hyphens (`-`).

```markdown
| Header 1 | Header 2 | Header 3 |
| -------- | -------- | -------- |
| Row 1    | Data 1   | Data 2   |
| Row 2    | Data 3   | Data 4   |
```

### Rendered Example:

| Header 1 | Header 2 | Header 3 |
| -------- | -------- | -------- |
| Row 1    | Data 1   | Data 2   |
| Row 2    | Data 3   | Data 4   |

---

### **Table Alignment**

Align columns with colons (`:`).

```markdown
| Left Aligned | Center Aligned | Right Aligned |
| :----------- | :------------: | ------------: |
| Data         |      Data      |          Data |
| More Data    |   More Data    |     More Data |
```

### Rendered Example:

| Left Aligned | Center Aligned | Right Aligned |
| :----------- | :------------: | ------------: |
| Data         |      Data      |          Data |
| More Data    |   More Data    |     More Data |

---

## 8. **Task Lists**

Use a combination of `- [ ]` for incomplete tasks and `- [x]` for completed tasks.

```markdown
- [ ] Task 1
- [x] Task 2 (completed)
- [ ] Task 3
```

### Rendered Example:

- [ ] Task 1
- [x] Task 2 (completed)
- [ ] Task 3

---

## 9. **Footnotes**

Create footnotes with a caret (`^`).

```markdown
This is a sentence with a footnote[^1].

[^1]: This is the footnote.
```

### Rendered Example:

This is a sentence with a footnote[^1].

[^1]: This is the footnote.

---

## 10. **Emoji**

Use colons to add emojis.

```markdown
:smile: :heart: :rocket:
```

### Rendered Example:

:smile: :heart: :rocket:

---

## 11. **Escaping Characters**

If you need to display characters that would otherwise be interpreted as Markdown syntax, escape them with a backslash (`\`).

```markdown
\*This is not italicized\*
```

### Rendered Example:

\*This is not italicized\*

---

## 12. **To Add an Index (Table of Contents)**

To create an index, manually link to sections using anchor links. Each header in the document can be linked with a hash (`#`) followed by the header text in lowercase, with spaces replaced by hyphens.

### Example:

```markdown
## **Index (Table of Contents)**

1. [Headings](#1-headings)
2. [Text Styling](#2-text-styling)
   - [Bold](#bold)
   - [Italics](#italics)
3. [Lists](#3-lists)
4. [Links & Images](#4-links--images)
```

### Rendered Example:

## **Index (Table of Contents)**

1. [Headings](#1-headings)
2. [Text Styling](#2-text-styling)
   - [Bold](#bold)
   - [Italics](#italics)
3. [Lists](#3-lists)
4. [Links & Images](#4-links--images)
",
      createdAt: Date.now(),
      updatedAt: Date.now(),
      tags: [],
    },
  ]
}
