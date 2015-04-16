using Toybox.WatchUi as Ui;
using Toybox.Graphics as Graphics;
using Toybox.Communications as Http;

class YrWeatherView extends Ui.View {

    hidden var position;
    hidden var currentPosition;
    hidden var currentImage;

    function initialize(positionManager) {
        position = positionManager;
    }

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
        position.start(method(:onPosition));
        Http.makeImageRequest("http://api.yr.no/weatherapi/weathericon/1.1/?symbol=5;content_type=image/png", {}, method(:onImage));
        Http.makeJsonRequest("http://vg.no", {}, {}, method(:onJson));
    }

    //! Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        var text = "unknown";
        if (currentPosition) {
            text = currentPosition;
        }
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_WHITE);
        var x = dc.getWidth() / 2;
        var y = dc.getHeight() / 2;
        dc.drawText(x, y, Graphics.FONT_LARGE, text, Graphics.TEXT_JUSTIFY_CENTER);

        System.println("image: " + currentImage);
        if (currentImage) {
            System.println("drawing image");
            currentImage.draw(dc);
        }
    }

    //! Called when this View is removed from the screen. Save the
    //! state of your app here.
    function onHide() {
    }

    function onPosition(position) {
        System.println("received position");
        currentPosition = position;
        Ui.requestUpdate();
    }

    function onImage(statusCode, image) {
        System.println("received image");
        System.println(image.getDimensions());
        if (image) {
            System.println("received actual image");
        }
        currentImage = image;
        Ui.requestUpdate();
    }

    function onJson(responseCode, data) {
        System.println("received: " + responseCode);
    }

}