rn_sources = files('random-notes.vala', 'rn-app.vala')
rn_blueprints = files()

subdir('models')
subdir('repositories')
subdir('utils')
subdir('view-models')
subdir('views')
subdir('widgets')
subdir('windows')

blueprint_compiler = find_program('blueprint-compiler')

rn_resources = gnome.compile_resources(
  'rn-resources',
  'rn-resources.xml',

  c_name       : 'random_notes',
  dependencies : custom_target(
    build_always_stale : true,
    command            : [
      blueprint_compiler,
      'batch-compile',
      '@OUTPUT@',
      '@CURRENT_SOURCE_DIR@',
      '@INPUT@',
    ],
    input              : rn_blueprints,
    output             : '.',
  ),
)

rn_deps = [
  dependency('gio-2.0',       version : '>=2.70', method : 'pkg-config'),
  dependency('gtk4',          version : '>=4.4',  method : 'pkg-config'),
  dependency('libadwaita-1',  version : '>=1.0',  method : 'pkg-config'),
  dependency('json-glib-1.0', version : '>=1.0',  method : 'pkg-config'),
]

executable(
  meson.project_name(),
  rn_resources, rn_sources,

  c_args        : [
    '-DG_LOG_DOMAIN="RandomNotes"',
    f'-DGETTEXT_PACKAGE="random-notes"',
  ],
  dependencies  : rn_deps,
  install       : true,
  vala_args     : [
    '--enable-checking',
    '--gresourcesdir=src/',
    '--nostdpkg',
  ],
  win_subsystem : 'windows',
)
