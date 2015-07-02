[GtkTemplate (ui = "/org/gnome/scanmem/gsm-window.ui")]
public class Gsm.Window : Gtk.ApplicationWindow
{
  public Window ()
  {

  }

  [GtkCallback]
  private void on_select_process_button_clicked (Gtk.Button button)
  {
    Gsm.SelectProcessDialog select_process_dialog = new Gsm.SelectProcessDialog (this);
    select_process_dialog.show_all ();
  }
}
