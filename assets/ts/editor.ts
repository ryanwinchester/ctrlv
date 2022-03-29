import {EditorState, basicSetup} from "@codemirror/basic-setup";
import {indentWithTab} from "@codemirror/commands";
import {LanguageSupport} from "@codemirror/language";
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

// Variables for everyone in this dang file...
const languageConf = new Compartment();

const supportedLangs = [
  cpp, css, html, java, javascript, json, markdown, php, python, rust,
];

/**
 * Create a CodeMirror 6 editor in an HTML element.
 * @param el - The element to add the editor to.
 * @returns The editor view.
 */
export function createEditorView(el: HTMLElement): EditorView {
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
 * @param view - The editor view.
 * @param langName - The name of the language.
 */
export function setLanguage(view: EditorView, langName: string): void {
  view.dispatch({
    effects: languageConf.reconfigure(langFromName(langName))
  })
}

/**
 * Change filter function for the editor state.
 * @param tr - The transaction for the filter.
 * @returns Whether or not this transaction should apply.
 */
 function lengthLimit(tr: Transaction): boolean {
  // TODO: I don't like this. Do something about it later.
  return (tr.startState?.doc?.length + tr.changes?.inserted?.length) < MAX_LENGTH;
}

/**
 * Get the CM language support from the name.
 * @param name - The name of the language.
 * @returns The language support.
 */
function langFromName(name: string): LanguageSupport {
  const language = supportedLangs.find((lang) => lang.name == name);
  if (language === undefined) { throw `unsupported language ${name}`; }
  console.info("[ctrlv.io] Switching language:", name);
  return language();
}
