import {createEditorView, setDoc, setLanguage} from "./editor";

export const Editor = {
  mounted() {
    const config = {
      readOnly: this.el.dataset.isEditing != "true",
    };

    const editorView = createEditorView(this.el, config);

    this.pushEvent("editor-created", {}, ({doc, language}) => {
      if (doc != null) {
        setDoc(editorView, doc);
        setLanguage(editorView, language);
      }
    });

    this.handleEvent("switch-language", ({language}) => {
      setLanguage(editorView, language);
    });

    this.handleEvent("init-save-paste", () => {
      this.pushEvent("save-paste", {doc: editorView.state.doc.toJSON()});
    });
  },
};
