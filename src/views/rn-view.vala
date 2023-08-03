/*
 * Copyright 2021 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: MIT
 */

abstract class Rn.View : Gtk.Widget, Gtk.Buildable {
  Adw.Bin? titlebar_bin = new Adw.Bin ();
  Adw.Bin? child_bin = new Adw.Bin () { vexpand = true };

  public Gtk.Widget? titlebar {
    get { return titlebar_bin.child; }
    set { titlebar_bin.child = value; }
  }

  public Gtk.Widget? child {
    get { return child_bin.child; }
    set { child_bin.child = value; }
  }

  construct {
    layout_manager = new Gtk.BoxLayout (VERTICAL);

    titlebar_bin?.set_parent (this);
    child_bin?.set_parent (this);
  }

  protected override void dispose () {
    titlebar_bin?.unparent ();
    titlebar_bin = null;

    child_bin?.unparent ();
    child_bin = null;

    base.dispose ();
  }

  void add_child (Gtk.Builder builder, Object child, string? type) {
    if (type == "titlebar" && child is Gtk.Widget) {
      titlebar = (Gtk.Widget) child;
      return;
    }

    if (child is Gtk.Widget) {
      this.child = (Gtk.Widget) child;
      return;
    }

    base.add_child (builder, child, type);
  }
}
