import {EditorState, basicSetup} from "@codemirror/basic-setup";
import {indentWithTab} from "@codemirror/commands";
import {EditorView, keymap} from "@codemirror/view";
import {Compartment, Transaction} from "@codemirror/state";

// Themes.
import {oneDark} from "@codemirror/theme-one-dark";

// CM6 languages.
import {cpp} from "@codemirror/lang-cpp";
import {css} from "@codemirror/lang-css";
import {html} from "@codemirror/lang-html";
import {java} from "@codemirror/lang-java";
import {javascript} from "@codemirror/lang-javascript";
import {json} from "@codemirror/lang-json";
import {markdown} from "@codemirror/lang-markdown";
import {php} from "@codemirror/lang-php";
import {python} from "@codemirror/lang-python";
import {rust} from "@codemirror/lang-rust";

// Symbolic constants.
const MAX_LENGTH = 56e3;

// Variable for everyone in this dang file...
const languageConf = new Compartment;

/**
 * Create a CodeMirror 6 editor in an HTML element.
 * @param {HTMLElement} el - The element to add the editor to.
 * @returns {EditorView}
 */
function createEditor(el: HTMLElement): EditorView {
  return new EditorView({
    state: EditorState.create({
      extensions: [
        EditorState.changeFilter.of(lengthLimit),
        basicSetup,
        oneDark,
        keymap.of([indentWithTab]),
        languageConf.of(javascript()),
      ]
    }),
    parent: el
  });
}

/**
 * Change the editor language.
 * @param {EditorView} view - The editor view.
 * @param {string} langName - The name of the language.
 */
function setLanguage(view: EditorView, langName: string): void {
  view.dispatch({
    effects: languageConf.reconfigure(langFromName(langName))
  })
}

/**
 * Get the CM language support from the name.
 * @param {string} name - The name of the language.
 * @returns {any}
 */
function langFromName(name: string): any {
  switch (name) {
    case "cpp":
      return cpp();
    case "css":
      return css();
    case "html":
      return html();
    case "java":
      return java();
    case "javascript":
      return javascript();
    case "json":
      return json();
    case "markdown":
      return markdown();
    case "php":
      return php();
    case "python":
      return python();
    case "rust":
      return rust();
  }
}

/**
 * Change filter function for the editor state.
 * @param {Transaction} tr - The transaction for the filter.
 * @returns {boolean} - Whether or not this transaction should apply.
 */
 function lengthLimit(tr: Transaction): boolean {
  // TODO: I don't like this. Do something about it later.
  return (tr.startState?.doc?.length + tr.changes?.inserted?.length) < MAX_LENGTH;
}

export {
  createEditor,
  setLanguage,
};
