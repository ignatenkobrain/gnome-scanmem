[GtkTemplate (ui = "/org/gnome/scanmem/gsm-select-process-dialog.ui")]
public class Gsm.SelectProcessDialog : Gtk.Dialog
{
  [GtkChild]
  private Gtk.ListStore liststore;
  [GtkChild]
  private Gtk.TreeSelection selection;

  public SelectProcessDialog (Gtk.Window window)
  {
    set_transient_for (window);
    Gtk.TreeIter iter;
    try {
      string ps_out;
      Process.spawn_command_line_sync ("ps -weo pid,user,command --sort=-pid", out ps_out, null, null);
      string[] ps_entries = ps_out.split ("\n");
      unowned string[] ps_e = ps_entries[1:ps_entries.length-1];
      foreach (string s in ps_e) {
        string[] splitted = s.strip ().split (" ", 3);
        debug ("PID: %u", int.parse (splitted[0]));
        debug ("User: %s", splitted[1]);
        debug ("Command: %s", splitted[2].strip ());
        liststore.append (out iter);
        liststore.set (iter,
                       0, int.parse (splitted[0]),
                       1, splitted[1],
                       2, splitted[2].strip ());
      }
    } catch (SpawnError e) {
      warning (e.message);
    }
  }

  [GtkCallback]
  private void on_response (Gtk.Dialog dialog, int response_id)
  {
    switch (response_id) {
    case Gtk.ResponseType.OK:
      break;
    case Gtk.ResponseType.CANCEL:
    case Gtk.ResponseType.CLOSE:
      this.destroy ();
      break;
    }
  }

  [GtkCallback]
  private void on_select_button_clicked ()
  {
    Gtk.TreeIter iter;
    GLib.Value pid;
    selection.get_selected (null, out iter);
    liststore.get_value (iter, 0, out pid);
    warning ("%u", (uint) pid);
  }
}
