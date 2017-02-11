using GLib;
using Gtk;


class AddUserApp : Gtk.Window{
  const string pathImage = "/etc/skel/.face";
  const string pathUI = "input_user.ui"; // path for ui file
  const string pathCSS = "custom.css"; // path for css file
  
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
  		previewLabel.set_text("");
  		/* whenever preview button has "clicked" signal, its connect to updatePreview() */
  		preview.clicked.connect(()=>{
  			updatePreview(userEntry, hostEntry, previewLabel);
  		});
  		
  		submit.clicked.connect(()=>{
  			sendData();
  		});
  		
  	}
  	/* catch error caused by file.ui not found for layout app */
  	catch(Error e){
  		stderr.printf("Could not load UI file: %s\n", e.message);
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
  
  public void sendData(){
  	stdout.printf("I'm Clicked now!!\n");
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
