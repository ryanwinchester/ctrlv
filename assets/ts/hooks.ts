import {createEditor} from "./editor";

export const Editor = {
  mounted() {
    this.editor = createEditor(this.el);
  }
};
