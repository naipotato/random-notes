application_id = 'ar.com.nahuelgomez.RandomNotes'

scalable_dir = 'scalable/apps'
install_data(
  scalable_dir / '@0@.svg'.format(application_id),
  install_dir: get_option('datadir') / 'icons/hicolor' / scalable_dir,
)

symbolic_dir = 'symbolic/apps'
install_data(
  symbolic_dir / '@0@-symbolic.svg'.format(application_id),
  install_dir: get_option('datadir') / 'icons/hicolor' / symbolic_dir,
)

gnome = import('gnome')

icon_resources = gnome.compile_resources(
  'icon-resources',
  'icon-resources.xml',
)
