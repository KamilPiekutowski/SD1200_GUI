import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import People 1.0
import "QML"

Item {
    property string fontFamily: "Roboto"

    id: root
    width: 800
    height: 460

    Loading  {
        id: loading
        color: "#647a35"
        textColor: "#F6F5FC"
        z: 100
    }

    OSCBinder {
        id: oscBinder
        onFxListReceived: {
             console.log("request list");
             if(fxList.length) {
                 browserButton.customText = fxList[0].split("_")[0];

                 // set the synthdef to the first on effect in the list
                 sendQMLGuiSetSynthDef(fxList[0]);

                 for(var i = 0; i < fxList.length; i++) {
                     effectsBrowser.model.append( { 'name': fxList[i].split("_")[0]});
                     effectsBrowser.model.setProperty(i, 'index', i);
                     effectsBrowser.model.setProperty(i, 'ctlType', fxList[0].split("_")[1]);
                 }

                 loading.visible = false;
             }
         }
    }

    Rectangle {
        id : rootBackground;
        width: parent.width;
        height: parent.height;
        color: "#0C1923"
    }

    MenuButton {
        id: browserButton
        width: parent.width * 0.35
        height: parent.height * 0.25
        anchors.left: parent.left
        anchors.margins: aButtonLeft.width
        font.family: root.fontFamily
        customText: "Effect_1"

        onClicked: effectsBrowser.visible = !effectsBrowser.visible
    }

    ArrowButton {
        id: aButtonLeft
        width: parent.height * 0.25
        height: parent.height * 0.25
        anchors.right: browserButton.left
        font.family: root.fontFamily



        Image {
            source: "qrc:/img/ForwardButtonSmall.png"
            width: parent.height// * 0.75
            height: parent.height// * 0.75
            anchors.fill: parent
            anchors.margins: 4
            rotation: 180
        }

        onClicked: {
            console.log(effectsBrowser.children[0].children[0].count);
            var nextIndex = effectsBrowser.children[0].children[0].currentIndex - 1;
            if(nextIndex < 0)
            {
                nextIndex = 0;
            }

            console.log("index: " + nextIndex);
            effectsBrowser.children[0].children[0].currentIndex = nextIndex;
        }
    }

    ArrowButton {
        id: aButtonRight
        width: parent.height * 0.25
        height: parent.height * 0.25
        anchors.left: browserButton.right
        font.family: root.fontFamily
        Image {
            source: "qrc:/img/ForwardButtonSmall.png"
            width: parent.height// * 0.75
            height: parent.height// * 0.75
            anchors.fill: parent
            anchors.margins: 4
            rotation: 0
        }

        onClicked: {
            console.log(effectsBrowser.children[0].children[0].count);
            var nextIndex = effectsBrowser.children[0].children[0].currentIndex + 1;
            if(nextIndex > effectsBrowser.children[0].children[0].count - 1)
            {
                nextIndex = effectsBrowser.children[0].children[0].count - 1;
            }

            console.log("index: " + nextIndex);
            effectsBrowser.children[0].children[0].currentIndex = nextIndex;
        }
    }

    MenuButton {
        id: settings
        width: parent.width - browserButton.width - aButtonLeft.width - aButtonRight.width
        height: parent.height * 0.25
        anchors.right: parent.right
        font.family: root.fontFamily
        customText: "Settings"
    }

    Slider2D {
        id: slider2D
    }

    EffectsBrowser {
        id: effectsBrowser
        textColor: browserButton.textColor
    }
}
