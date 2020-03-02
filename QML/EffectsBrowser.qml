import QtQuick 2.0
import QtQuick.Controls.Styles 1.0

Rectangle {
    property string textColor: "white"
    property ListModel model: ListModel {}

    visible: false
    id: listViewBox
    width: parent.width
    height: parent.height * 0.75
    anchors.bottom: parent.bottom
    border.width: 4;
    border.color: "#647a35"
    color: "#0C1923"

    Rectangle
    {
        property string textColor: parent.textColor
        property ListModel model: parent.model

        anchors.fill: parent
        anchors.topMargin: parent.border.width +3
        anchors.bottomMargin: parent.border.width +3
        anchors.rightMargin: parent.border.width +3
        anchors.leftMargin: parent.border.width +3
        color: parent.color

        ListView {
            property string textColor: parent.textColor

            id: browserListView
            height: parent.height
            width: parent.width
            anchors.fill: parent
            model: parent.model
            clip: true

            delegate: Text {
                property string textColor: browserListView.textColor

                text: name
                color: textColor
                font.pixelSize: browserButton.children[1].font.pixelSize
                font.family: browserButton.children[1].font.family
                clip:true
            }

            boundsBehavior: Flickable.StopAtBounds
            focus: true
        }

    }

}
