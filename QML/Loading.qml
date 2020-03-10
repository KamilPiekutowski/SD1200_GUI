import QtQuick 2.0

Item {
    property string color: "#000000"

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
        color: "#F6F5FC"
        anchors.centerIn: parent
        //font.family: "Roboto"
        font.pixelSize: 50
        layer.enabled: true
        layer.samples: 16
    }
}
