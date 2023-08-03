project(
    'random-notes',
    'vala', 'c',

    license       : 'MIT',
    meson_version : '>=0.60.0',
    version       : '0.1.0',
)

gnome = import('gnome')
i18n  = import('i18n')

subdir('data')
subdir('src')
subdir('po')

gnome.post_install(
  gtk_update_icon_cache   : true,
  update_desktop_database : true,
)
