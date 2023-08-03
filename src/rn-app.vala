/*
 * Copyright 2021 https://nahuelwexd.com
 *
 * SPDX-License-Identifier: MIT
 */

sealed class Rn.App : Adw.Application {
  public App (string app_id) {
    Object (application_id: app_id);
  }

  protected override void startup() {
    base.startup ();

    typeof (NoteSorter).ensure ();
    typeof (NoteListView).ensure ();
    typeof (NoteView).ensure ();

    var repo = new NoteRepository ();
    var view_model = new NoteViewModel (repo);

    new AppWindow(this, view_model);
  }

  protected override void activate() {
    active_window?.present ();
  }
}
