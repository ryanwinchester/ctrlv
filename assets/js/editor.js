import {EditorState, basicSetup} from "@codemirror/basic-setup";
import {EditorView, keymap} from "@codemirror/view";
import {indentWithTab} from "@codemirror/commands";

// Themes
import {oneDark} from "@codemirror/theme-one-dark";

// Languages
import {javascript} from "@codemirror/lang-javascript";

export default new EditorView({
  state: EditorState.create({
    extensions: [
      basicSetup,
      oneDark,
      keymap.of([indentWithTab]),
      javascript(),
    ]
  }),
  parent: document.querySelector("#editor"),
});
