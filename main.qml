import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import "."

Window {
    id: root
    visible: true
    width: 800
    height: 460
    title: qsTr("SD 1200")
    color: "#0C1923"

    MenuButton {
        id: browserButton
        width: parent.width * 0.35
        height: parent.height * 0.25
        anchors.left: parent.left
        anchors.margins: aButtonLeft.width
        customText: "Effect_1"
        onClicked: effectsBrowser.visible = !effectsBrowser.visible
    }

    ArrowButton {
        id: aButtonLeft
        width: parent.height * 0.25
        height: parent.height * 0.25
        anchors.right: browserButton.left
    }

    ArrowButton {
        id: aButtonRight
        width: parent.height * 0.25
        height: parent.height * 0.25
        anchors.left: browserButton.right
    }

    MenuButton {
        id: settings
        width: parent.width - browserButton.width - aButtonLeft.width - aButtonRight.width
        height: parent.height * 0.25
        anchors.right: parent.right
        customText: "Settings"
    }

    Slider2D {
        id: slider2D
    }

    EffectsBrowser {
        id: effectsBrowser
    }

    Component.onCompleted:  {
        for(var i = 0; i < 20; i++)
        {
            OSCBinder.test()
            effectsBrowser.model.append( { name: "Effect_" + i})
        }
    }
}
