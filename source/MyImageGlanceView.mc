using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;
using Toybox.Timer;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;

(:glance)
class MyImageGlanceView extends WatchUi.GlanceView {

    function initialize() {
        GlanceView.initialize();
        MyImageWidgetApp.settingUpdate();
    }
    
    function onShow() {
    }

    function onHide() {
    }
    
    function onLayout(dc) {
    }
    
    function onUpdate(dc) {
    	var width = dc.getWidth();
	    var height = dc.getHeight();
	    	    
    	dc.setColor(Graphics.COLOR_BLACK,Graphics.COLOR_BLACK);
    	dc.clear();
    	dc.setColor(Graphics.COLOR_WHITE ,Graphics.COLOR_TRANSPARENT);
	    dc.drawRectangle(0, 0, width, height);
	    dc.drawText(0,height/2-Graphics.getFontHeight(Graphics.FONT_TINY ), Graphics.FONT_SYSTEM_TINY, "My Images ("+nbloadedImages+")", Graphics.TEXT_JUSTIFY_LEFT);
    }
 }