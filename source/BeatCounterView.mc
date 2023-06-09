import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;
import Toybox.Timer;


class BeatCounterView extends WatchUi.SimpleDataField {
    var startTime;
    // Set the label of the data field here.
    function initialize() {
        SimpleDataField.initialize();
        label = "Total Beats";
        self.startTime = Time.now();
    }

    // The given info object contains all the current workout
    // information. Calculate a value and return it in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info as Activity.Info) as Numeric or Duration or String or Null {
        // See Activity.Info in the documentation for available information.
        var elapsedTime = getElapsedTime();

        var activityTime = info.elapsedTime / 1000.0;
        var averageHeartRate = info.averageHeartRate;
        var activityTimeMins = activityTime / 60.0;
        var totalBeats = activityTimeMins * averageHeartRate;
        // System.println("Activity Time: " + activityTime);
        // System.println("Elapsed Time: " + elapsedTime);
        // System.println("totalBeats: " + totalBeats);

        return totalBeats.toNumber();
    }

    function getElapsedTime() as Number {
        var currentTime = Time.now();
        var elapsedTime = currentTime.subtract(self.startTime);
        self.startTime = Time.now();
        return elapsedTime.value();
    }
}