import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class MyImageWidgetApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

	function settingUpdate() {
		// Load Settings
		// TODO: Load settings
		
    	//AppBase.reloadImages();
	}

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new MyImageWidgetView(), new MyImageWidgetDelegate() ] as Array<Views or InputDelegates>;
    }
    
	function onSettingsChanged(){
    	settingUpdate();
        WatchUi.requestUpdate();
    }
    
	(:glance)    
	function getGlanceView() {
        return [ new MyImageGlanceView() ];
    }     
}

function getApp() as MyImageWidgetApp {
    return Application.getApp() as MyImageWidgetApp;
}