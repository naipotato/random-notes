/*
 * Copyright 2021 https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: MIT
 */

[GtkTemplate (ui = "/ar/com/nahuelgomez/RandomNotes/rn-note-list-view.ui")]
sealed class Rn.NoteListView : View {
  [GtkChild]
  unowned Gtk.SingleSelection selection_model;

  public ObservableList<Note>? notes { get; set; }
  public Note? selected_note { get; set; }

  construct {
    selection_model.bind_property (
        "selected", this, "selected-note", DEFAULT, (_, from, ref to) => {
      var position = (uint) from;

      if (position != Gtk.INVALID_LIST_POSITION)
        to.set_object (selection_model.model.get_item (position));

      return true;
    });
  }

  public signal void new_note_requested ();

  [GtkCallback]
  void on_add_button_clicked () {
    new_note_requested ();
  }
}
