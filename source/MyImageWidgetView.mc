using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.System;
using Toybox.Timer;
using Toybox.Application.Storage;


var maxImage=3 ;
var imagesURL = { 0 => "https://zrenard.com/buddy.png", 1 => "https://zrenard.com/zrenard_blue.png" } ;
var imagesData = {} ;
var selection = 0 ;
var nbloadedImages;

function cycleImages(direction) {
	var nbImages=imagesURL.size();
	if (nbImages>0) {
		selection = ((selection+direction)+nbImages)%nbImages;
	}
	System.println("Change to "+selection);
	WatchUi.requestUpdate();	
}

class MyImageWidgetView extends WatchUi.View {
	var responseCode="0";

    function initialize() {
        View.initialize();
        MyImageWidgetApp.settingUpdate();
        
        nbloadedImages = imagesData.size();
        startNextDownload();
    }

	function startNextDownload() {
		if (nbloadedImages<=maxImage) {
			loadImage(nbloadedImages);
		}
	}

	
    // Load your resources here
    function onLayout(dc as Dc) as Void {
        //setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        var width = dc.getWidth();
    	var height = dc.getHeight();
        dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_BLACK);
        dc.clear();
        if (imagesData==null||imagesData.size()==0||imagesURL.get(selection)==null||!imagesData.hasKey(selection)) {
        	dc.drawText( (width / 2), (height/4), Graphics.Graphics.FONT_LARGE,"no image "+selection, Graphics.TEXT_JUSTIFY_CENTER);
    	} else {
    		dc.drawBitmap((width / 2)-imagesData.get(selection).getWidth()/2, (height / 2)-imagesData.get(selection).getHeight()/2, imagesData.get(selection));
    	}        
    }
    
    function loadImage(index) {
    	if (imagesURL.hasKey(index)) {
    		if (!imagesData.hasKey(index)) {
		        var parameters = null;
		        var options = {
		            :maxWidth => 200,                                   // set the max width
		            :maxHeight => 200,                                  // set the max height
		            :dithering => Communications.IMAGE_DITHERING_NONE   // set the dithering
		        };
		        // Make the image request
		        Communications.makeImageRequest(imagesURL.get(index), parameters, options, method(:loadImageRequestCallback));
	        } else { System.println("Image "+ imagesURL.get(index) +" already loaded. Cache."); }
	    }  else { System.println("No image to load"); }
    }
    
	function loadImageRequestCallback(responseCode, data) {
        responseCode = responseCode;
		System.println("Loaded = "+responseCode.toString());
        if (responseCode == 200) {
            imagesData.put(nbloadedImages,data);
            System.println("Image loaded at "+nbloadedImages);
        }  else { System.println("Failed to load\nError: " + responseCode.toString()); }
        nbloadedImages=nbloadedImages+1;
        WatchUi.requestUpdate();
        startNextDownload();
    }    
	
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
