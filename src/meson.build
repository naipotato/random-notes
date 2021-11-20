random_notes_sources = [
  'models/rn-note.vala',

  'repositories/rn-note-repository.vala',

  'utils/rn-file-utils.vala',
  'utils/rn-note-sorter.vala',
  'utils/rn-observable-list.vala',
  'utils/rn-thread-utils.vala',

  'view-models/rn-note-view-model.vala',

  'views/rn-note-list-view.vala',
  'views/rn-note-view.vala',
  'views/rn-view.vala',

  'windows/rn-app-window.vala',

  'random-notes.vala',
  'rn-app.vala',
]

random_notes_deps = [
  dependency('gio-2.0', version: '>=2.70'),
  dependency('gtk4', version: '>=4.4'),
  dependency('libadwaita-1', version: '>=1.0'),
  dependency('json-glib-1.0', version: '>=1.0'),
]

gnome = import('gnome')

random_notes_sources += gnome.compile_resources(
  'ui-resources',
  'ui-resources.xml',
)

random_notes_sources += icon_resources

executable(
  meson.project_name(),
  random_notes_sources,
  dependencies: random_notes_deps,
  install: true,
)
