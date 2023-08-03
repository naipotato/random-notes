/*
 * Copyright 2021 https://nahuelwexd.com
 *
 * SPDX-License-Identifier: MIT
 */

[GtkTemplate (ui = "/com/nahuelwexd/RandomNotes/ui/rn-app-window.ui")]
sealed class Rn.AppWindow : Adw.ApplicationWindow {
  public NoteViewModel view_model { get; construct; }

  public AppWindow (App app, NoteViewModel view_model) {
    Object (application: app, view_model: view_model);
  }

  [GtkCallback]
  void on_new_note_requested () {
    view_model.create_new_note ();
  }

  [GtkCallback]
  void on_note_update_requested (Note note) {
    view_model.update_note (note);
  }

  [GtkCallback]
  void on_note_removal_requested (Note note) {
    view_model.delete_note (note);
  }
}
