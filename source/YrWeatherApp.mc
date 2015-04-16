using Toybox.Application as App;

class YrWeatherApp extends App.AppBase {

    //! onStart() is called on application start up
    function onStart() {
        System.println("starting Yr");
    }

    //! onStop() is called when your application is exiting
    function onStop() {
    }

    //! Return the initial view of your application here
    function getInitialView() {
        return [ new YrWeatherView(new PositionManager())];
    }

    function debug(position) {
        System.println(position);
    }
}