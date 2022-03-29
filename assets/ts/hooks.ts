import {createEditor} from "./editor";

const Editor = {
  mounted() {
    this.editor = createEditor(this.el);
  }
};

export {
  Editor,
}
