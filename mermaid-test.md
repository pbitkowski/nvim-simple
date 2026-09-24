# Mermaid preview test

Press `Space m p` to preview this file, then `q` or `Esc` to close.
For a live preview beside the source, run `:vert MdRender split`.
Try changing a label below while the split is open.

## Flowchart

You should see a decision diamond, two branches, and colored end states.

```mermaid
flowchart TD
    A[Open Markdown in Neovim] --> B[Press Space m p]
    B --> C{Can you see this diagram?}
    C -->|Yes| D[Enjoy terminal previews]
    C -->|No| E[Check Ghostty and Mermaid CLI]
    E --> B
    style D fill:#14532d,stroke:#4ade80,color:#ffffff
    style E fill:#7c2d12,stroke:#fb923c,color:#ffffff
```

## Sequence diagram

You should see three participants, arrows, and a highlighted note.

```mermaid
sequenceDiagram
    actor You
    participant Nvim as Neovim
    participant CLI as Mermaid CLI
    You->>Nvim: Open the preview
    Nvim->>CLI: Render diagram
    CLI-->>Nvim: PNG image
    Nvim-->>You: Show image in Ghostty
    Note over You,Nvim: Everything stays in the terminal
```

## State diagram

You should see an edit-and-preview cycle with start and end markers.

```mermaid
stateDiagram-v2
    [*] --> Editing
    Editing --> Previewing: Open preview
    Previewing --> Editing: Close preview
    Editing --> Saved: Save file
    Saved --> Editing: Make changes
    Saved --> [*]: Done
```

## Left-to-right layout

This wider diagram checks labels and layout in a narrow split.

```mermaid
flowchart LR
    A[Write Markdown] --> B[Parse Mermaid]
    B --> C[Render image]
    C --> D[Display in terminal]
```
