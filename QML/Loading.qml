import QtQuick 2.0

Item {
    property string color: "#F6F5FC"
    property string fontFamily: parent.fontFamily
    property string textColor: "white"

    width: parent.width
    height: parent.height

    Rectangle {
        width: parent.width
        height: parent.height
        color: parent.color
    }

    Text {
        id: bText1
        text: "Loading..."
        color: parent.textColor
        anchors.centerIn: parent
        font.family: "Roboto"
        font.pixelSize: 50
        layer.enabled: true
        layer.samples: 16
    }
}
