import {EditorState, basicSetup} from "@codemirror/basic-setup";
import {EditorView, keymap} from "@codemirror/view";
import {indentWithTab} from "@codemirror/commands";

// Themes.
import {oneDark} from "@codemirror/theme-one-dark";

// Languages.
import {javascript} from "@codemirror/lang-javascript";

const MAX_LENGTH = 56000;

export default function createEditor(el){
  const editor = new EditorView({
    state: EditorState.create({
      extensions: [
        basicSetup,
        oneDark,
        keymap.of([indentWithTab]),
        javascript(),
      ]
    }),
    parent: el,
  });
}
