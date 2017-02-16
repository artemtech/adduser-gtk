using GLib;
using Posix;
using Gtk;


/* Log for every process */
public class Logger : GLib.Object{
	public Logger(){
		//TODO constructor of Logger
	}
	public void writeLog(string string){
		//TODO write result of command to log file
	}
}
/* End Log declaration*/

/* The App */
public class AddUserApp : GLib.Object{
  const string pathImage = "/etc/skel/.face";
  const string pathUI = "input_user.ui"; // path for ui file
  const string pathCSS = "custom.css"; // path for css file
  int hasilAddUser;
  /* main ui declaration */
  public AddUserApp(){
  	try{  		
  		var builder = new Builder();
  		builder.add_from_file(pathUI);
  		builder.connect_signals(null);
  		var window = builder.get_object("window") as Window; // call window
  		window.title = "Add User Information for New Machine";
  		window.fullscreen();
  		window.show_all();
  		window.destroy.connect(()=>{
  			Gtk.main_quit();
  		});
  		/* call object from ui to vala */
  		var previewLabel = builder.get_object("viewName") as Label;
  		var hostEntry = builder.get_object("compName") as Entry;
  		var userEntry = builder.get_object("userName") as Entry;
  		var pswdEntry = builder.get_object("pswdName") as Entry;
  		var preview = builder.get_object("previewUser") as Button;
  		var submit = builder.get_object("submitUser") as Button;
  		var statusPerintah = builder.get_object("statusPerintah") as Label;
  		previewLabel.set_text("");
  		/* whenever preview button has "clicked" signal, its connect to updatePreview() */
  		preview.clicked.connect(()=>{
  			updatePreview(userEntry, hostEntry, previewLabel);
  		});
  		
  		submit.clicked.connect(()=>{
  			hasilAddUser = do_addUser(userEntry.get_text(), pswdEntry.get_text());
  			if(hasilAddUser == 0){
  				statusPerintah.set_text("Berhasil menambahkan user : %s".printf(userEntry.get_text()));
  				do_done();
  			}else{
  				statusPerintah.set_text("Terjadi kesalahan, exit status: %d".printf(hasilAddUser));
  			}
  		});
  		
  	}
  	/* catch error caused by file.ui not found for layout app */
  	catch(GLib.Error e){
  		GLib.stderr.printf("Could not load UI file: %s\n", e.message);
  	}
	  /* END main ui declaration */
  }
  
  /* update data when preview clicked*/
  public void updatePreview(Gtk.Entry userEntry, Gtk.Entry hostEntry, Gtk.Label preview){
  	string tmp="";
  	if(userEntry.get_text()!="" && hostEntry.get_text()!=""){
  		tmp = userEntry.get_text()+" @ "+hostEntry.get_text();
  	}
  	preview.set_text(tmp);
  }
  
  /* Add user spawn */
  private int do_addUser(string user_name, string password){
  	do_ubahParameterGroup();
  	string yangDieksekusi;
		string pesanError;
		int statusPerintah;
		int setPassword;
 		string argumen = @"--quiet --disabled-password --shell /bin/bash --home /home/$user_name --gecos "+ Shell.quote(@"$user_name") + @"--add_extra_groups $user_name";
 		string command = "/usr/sbin/adduser %s".printf(argumen);
		try{
  		Process.spawn_command_line_sync(command,out yangDieksekusi, out pesanError, out statusPerintah);
  	//output: hasil echo nya harusnya
			GLib.stdout.printf("stdout: \n");
		// output
			GLib.stdout.puts(command);
			GLib.stdout.printf ("\nstderr:\n");
			GLib.stdout.puts (pesanError);
		// Output: ``0``
			GLib.stdout.printf ("status: %d\n", statusPerintah);
  	}catch(SpawnError e){
  		GLib.stdout.printf(e.message);
  	}
  	setPassword = do_setPassword(statusPerintah, user_name, password);
  	// we check weither status of password creation is success or not
  	if(setPassword==0){
  		return 0; //succeeded
  	}
  	else{
  		return 1; //failed
  	}
  }
  
  /* Set the password */
  private int do_setPassword(int hasilAdduser, string user_name, string password){
  	string command = @"/bin/echo $user_name:$password | /usr/sbin/chpasswd";
  	//reject if password is empty
  	if(hasilAdduser==0 && password!=""){
  		Posix.system("sleep 1");
  		Posix.system(command);
  		return 0;
  	}
  	else{
  		return 1;
  	}
  }
  
  /* Tambah parameter di adduser.conf */
  private void do_ubahParameterGroup(){
  	string grup = """EXTRA_GROUPS = "cdrom floppy sudo audio dip video plugdev netdev" """;
  	Posix.system(@"echo $grup >> /etc/adduser.conf");
  }
  
  /* Set hostname */
  private void do_setHostname(string hostname){
  	//TODO
  	GLib.stdout.printf("hostname");
  }
  
  /* Exit whenever user click FINISH and status of User Creation is success */
  public void do_done(){
  	//delete delete entry in adduser.conf for user extra group setup
  	Posix.system("sed -i '$d' /etc/adduser.conf");
  	// logout xsession
  	Process.spawn_command_line_sync("gnome-session-quit --logout --no-prompt");  	
  	Gtk.main_quit();
  }
  
  
  /* main function of programme */
	public static int main(string[] args){
  	Gtk.init(ref args);
  	/* add CSS style for Gtk styling */
  	var css_prov = new Gtk.CssProvider();
  	try{
  		css_prov.load_from_path(pathCSS);
  	}
  	catch(GLib.Error e){
  		warning("stylesheet file cannot be opened! %s",e.message);
  	}
  	Gtk.StyleContext.add_provider_for_screen(
																						Gdk.Screen.get_default(),
																						css_prov,
																						Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
		);
		/* END CSS declaration */
  	new AddUserApp();
  	Gtk.main();
  	return 0;
	}
}
