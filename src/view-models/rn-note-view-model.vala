/*
 * Copyright 2021 https://nahuelwexd.com
 *
 * SPDX-License-Identifier: MIT
 */

sealed class Rn.NoteViewModel : Object {
  uint timeout_id = 0;

  public ObservableList<Note> notes { get; default = new ObservableList<Note> (); }
  public NoteRepository? repository { private get; construct; }

  public NoteViewModel (NoteRepository repository) {
    Object (repository: repository);
  }

  construct {
    populate_notes.begin ();
  }

  public void create_new_note () {
    var note = new Note () {
      title = "New note",
      content = "This is a note"
    };

    notes.add (note);

    repository.insert_note (note);
    save_notes ();
  }

  public void update_note (Note note) {
    repository.update_note (note);
    save_notes ();
  }

  public void delete_note (Note note) {
    notes.remove (note);

    repository.delete_note (note.id);
    save_notes ();
  }

  async void populate_notes () {
    var notes = yield repository.get_notes ();
    this.notes.add_all (notes);
  }

  void save_notes () {
    if (timeout_id != 0)
      Source.remove (timeout_id);

    timeout_id = Timeout.add (500, () => {
      timeout_id = 0;

      repository.save.begin ();

      return Source.REMOVE;
    });
  }
}
