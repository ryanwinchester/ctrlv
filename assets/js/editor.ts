import {EditorState, basicSetup} from "@codemirror/basic-setup";
import {indentWithTab} from "@codemirror/commands";
import {LanguageSupport} from "@codemirror/language";
import {EditorView, keymap} from "@codemirror/view";
import {Compartment, Transaction, Text} from "@codemirror/state";
import {StreamLanguage} from "@codemirror/stream-parser"

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

// CM5 languages.
import {elixir} from "./modes/elixir";
import * as legacyModes from "./modes/legacy";

// Symbolic constants.
const MAX_LENGTH = 56e3;

// Variables for everyone in this dang file...
const languageConf = new Compartment();

const supportedLangs = [
  cpp, css, html, java, javascript, json, markdown, php, python, rust,
];

const legacyLanguages = Object.assign(legacyModes, {elixir});

/**
 * Create a CodeMirror 6 editor in an HTML element.
 * @param el - The element to add the editor to.
 * @returns The editor view.
 */
export function createEditorView(el: HTMLElement, config: any): EditorView {
  return new EditorView({
    state: EditorState.create({
      extensions: [
        EditorState.readOnly.of(config.readOnly),
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
 * Set the editor view text content.
 * @param view - The editor view.
 * @param doc - The editor text content as a list of lines.
 */
export function setDoc(view: EditorView, doc: Array<string>): void {
  view.dispatch({
    changes: {from: 0, insert: Text.of(doc)}
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
  return tr.newDoc.length < MAX_LENGTH;
}

/**
 * Get the CM language support from the name.
 * @param name - The name of the language.
 * @returns The language support.
 */
function langFromName(name: string): LanguageSupport | StreamLanguage<unknown> {
  const language = supportedLangs.find((lang) => lang.name == name);
  console.info("[ctrlv.io] Switching language:", name);

  if (language === undefined) {
    const legacy = legacyLanguages[name];
    if (legacy === undefined) { throw `unsupported language ${name}`; }
    return StreamLanguage.define(legacy);
   }

  return language();
}
