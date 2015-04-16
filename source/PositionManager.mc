using Toybox.Position as Position;

class PositionManager {

    hidden var handler;

    function initialize(positionHandler) {
        System.println("initialize");
    }

    function start(positionHandler) {
        System.println("starting positioning..");
        handler = positionHandler;
        initializeListener();
    }

    function initializeListener() {
        Position.enableLocationEvents(Position.LOCATION_ONE_SHOT, method(:onPosition));
    }

    function onPosition(info) {
        System.println(info);
        handler(info.position);
    }

}