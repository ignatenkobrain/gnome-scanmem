public class ScanMem : Gtk.Application
{
  /* Main window */
  private Gsm.Window window;

  private const OptionEntry[] option_entries = {
    { "version", 'v', 0, OptionArg.NONE, null, "Print release version and exit", null },
    { null }
  };

  private const GLib.ActionEntry[] action_entries = {
    { "quit",               quit_cb                                     },
    { "help",               help_cb                                     },
    { "about",              about_cb                                    }
  };

  public ScanMem ()
  {
    Object (application_id: "org.gnome.scanmem", flags: ApplicationFlags.FLAGS_NONE);
    add_main_option_entries (option_entries);
  }

  protected override void startup ()
  {
    base.startup ();

    Environment.set_application_name ("Memory Scanner");

    add_action_entries (action_entries, this);
    window = new Gsm.Window ();
    add_window (window);

    var menu = new Menu ();
    var section = new Menu ();
    menu.append_section (null, section);
    section.append ("_Help", "app.help");
    section.append ("_About", "app.about");
    section.append ("_Quit", "app.quit");
    set_app_menu (menu);

    set_accels_for_action ("app.help", {"F1"});
    set_accels_for_action ("app.quit", {"<Primary>q", "<Primary>w"});
  }

  public void start ()
  {
    window.show ();
  }

  protected override void shutdown ()
  {
    base.shutdown ();
  }

  protected override void activate ()
  {
    window.present ();
  }

  private void quit_cb ()
  {
    window.destroy ();
  }

  private void about_cb ()
  {
    string[] authors = {
      "Igor Gnatenko",
      null
    };

    Gtk.show_about_dialog (window,
                           "name", "Memory Scanner",
                           "version", VERSION,
                           "copyright", "Copyright © 2015 Igor Gnatenko",
                           "license-type", Gtk.License.GPL_3_0,
                           "authors", authors,
                           null);
  }

  private void help_cb ()
  {
    try {
      Gtk.show_uri (window.get_screen (), "help:gnome-scanmem", Gtk.get_current_event_time ());
    } catch (Error e) {
      warning ("Failed to show help: %s", e.message);
    }
  }

  public static int main (string[] args)
  {
    /*
    Intl.setlocale (LocaleCategory.ALL, "");
    Intl.bindtextdomain (GETTEXT_PACKAGE, LOCALEDIR);
    Intl.bind_textdomain_codeset (GETTEXT_PACKAGE, "UTF-8");
    Intl.textdomain (GETTEXT_PACKAGE);
    */
    //GLib.Resource resource = GLib.Resource.load ("/home/brain/Documents/gnome-scanmem/data/gnome-scanmem.gresource");
    //GLib.resources_register (resource);
    var app = new ScanMem ();
    return app.run (args);
  }
}
