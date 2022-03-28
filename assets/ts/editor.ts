import {EditorState, basicSetup} from "@codemirror/basic-setup";
import {indentWithTab} from "@codemirror/commands";
import {EditorView, keymap} from "@codemirror/view";
import {Transaction} from "@codemirror/state";

// Themes.
import {oneDark} from "@codemirror/theme-one-dark";

// Languages.
import {javascript} from "@codemirror/lang-javascript";

const MAX_LENGTH = 56e3;

/**
 * Change filter function for the editor state.
 * @param {Transaction} tr - The transaction for the filter.
 * @returns {boolean} - Whether or not this transaction should apply.
 */
function lengthLimit(tr: Transaction): boolean {
  return (tr.startState?.doc?.length + tr.changes?.inserted?.length) < MAX_LENGTH;
}

/**
 * Create a CodeMirror 6 editor in an HTML element.
 * @param {HTMLElement} el - The element to add the editor to.
 * @returns {EditorView}
 */
export default function createEditor(el: HTMLElement): EditorView {
  let state = EditorState.create({
    extensions: [
      EditorState.changeFilter.of(lengthLimit),
      basicSetup,
      oneDark,
      keymap.of([indentWithTab]),
      javascript(),
    ]
  })

  return new EditorView({state, parent: el});
}
