srcs = [
  'config.vapi',
  'gsm-main.vala',
  'gsm-window.vala',
  'gsm-select-process-dialog.vala',
  resources,
]

executable(
  'gnome-scanmem',
  sources : srcs,
  dependencies : [
    glib,
    gobject,
    gtk,
  ],
  c_args : '-DVERSION="@0@"'.format(version),
  vala_args : '--gresources=../data/gnome-scanmem.gresource.xml',
  install : true
)
