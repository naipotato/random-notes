/*
 * Copyright 2021 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: MIT
 */

class Rn.NoteSorter : Gtk.Sorter {
  protected override Gtk.Ordering compare (Object? item1, Object? item2) {
    var note1 = item1 as Note;
    var note2 = item2 as Note;

    if (note1 == null || note2 == null)
      return EQUAL;

    return Gtk.Ordering.from_cmpfunc (
        note1.created_at.compare (note2.created_at));
  }

  protected override Gtk.SorterOrder get_order () {
    return TOTAL;
  }
}
