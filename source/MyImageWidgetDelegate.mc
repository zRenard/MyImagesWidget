using Toybox.WatchUi;
using Toybox.System;

class MyImageWidgetDelegate extends WatchUi.BehaviorDelegate {
    function initialize() as Void {
        WatchUi.BehaviorDelegate.initialize();
    }

    function onSelect() {
        return false;
    }

    function onBack() {
    	return false;
	}

    function onNextPage() {
        cycleImages(-1);
        return false;
    }

    function onPreviousPage() {
        cycleImages(1);
        return false;
    }
}