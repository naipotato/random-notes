/*
 * Copyright 2021 https://nahuelwexd.com
 *
 * SPDX-License-Identifier: MIT
 */

sealed class Rn.Note : Object, Json.Serializable {
  public string id { get; set; default = Uuid.string_random (); }
  public DateTime created_at { get; set; default = new DateTime.now_utc (); }
  public DateTime updated_at { get; set; default = new DateTime.now_utc (); }
  public string title { get; set; default = ""; }
  public string content { get; set; default = ""; }

  public static Note from_json (
      Json.Node node) requires (node.get_node_type () == OBJECT) {
    return (Note) Json.gobject_deserialize (typeof (Note), node);
  }

  public static List<Note> list_from_json (
      Json.Node node) requires (node.get_node_type () == ARRAY) {
    var result = new List<Note> ();

    var json_array = node.get_array ();
    json_array.foreach_element ((_, __, element_node) => {
      result.append (Note.from_json (element_node));
    });

    return (owned) result;
  }

  public Json.Node to_json () {
    return Json.gobject_serialize (this);
  }

  bool deserialize_property (string property_name,
      out Value @value, ParamSpec pspec, Json.Node property_node) {
    if (pspec.value_type != typeof (DateTime)) {
      return default_deserialize_property (
          property_name, out @value, pspec, property_node);
    }

    if (property_node.get_node_type () != VALUE) {
      @value = Value (Type.INVALID);
      return false;
    }

    var str = property_node.get_string ();

    if (str == null) {
      @value = Value (Type.INVALID);
      return false;
    }

    var datetime = new DateTime.from_iso8601 (str, new TimeZone.utc ());

    if (datetime == null) {
      @value = Value (Type.INVALID);
      return false;
    }

    @value = datetime;

    return true;
  }

  Json.Node serialize_property (
      string property_name, Value @value, ParamSpec pspec) {
    if (pspec.value_type != typeof (DateTime))
      return default_serialize_property (property_name, @value, pspec);

    if (@value.type () != typeof (DateTime))
      return new Json.Node (NULL);

    var datetime = (DateTime) @value;
    var str = datetime.format_iso8601 ();

    if (str == null)
      return new Json.Node (NULL);

    var node = new Json.Node (VALUE);
    node.set_string (str);

    return node;
  }
}
