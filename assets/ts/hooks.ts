import {createEditorView, setLanguage} from "./editor";

export const Editor = {
  mounted() {
    const editorView = createEditorView(this.el);

    this.handleEvent("switch-language", ({language}) => {
      setLanguage(editorView, language)
    });
  },
};
