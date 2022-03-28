import * as Monaco from 'monaco-editor/esm/vs/editor/editor.main';

export default function createEditor(el) {
  Monaco.editor.create(el, {
    value: ['function x() {', '    console.log("Hello world!");', '}'].join('\n'),
    language: 'javascript'
  })
};
