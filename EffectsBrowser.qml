import QtQuick 2.0

Rectangle {
    visible: false
    id: listViewBox
    width: parent.width
    height: parent.height * 0.75
    color: "#0C1923"
    anchors.bottom: parent.bottom
    border.width: 4;
    border.color: "#647a35"
    property ListModel model: ListModel {}


    Rectangle
    {
        anchors.fill: parent
        anchors.topMargin: parent.border.width +3
        anchors.bottomMargin: parent.border.width +3
        anchors.rightMargin: parent.border.width +3
        anchors.leftMargin: parent.border.width +3

        color: parent.color

        property ListModel model: parent.model

        ListView {
            id: myListView
            height: parent.height
            width: parent.width
            anchors.fill: parent
            model: parent.model
            clip: true

            delegate: Text {
                text: name
                color: browserButton.children[1].color
                font.pixelSize: browserButton.children[1].font.pixelSize
                font.family: browserButton.children[1].font.family
                clip:true
            }

            boundsBehavior: Flickable.StopAtBounds
            focus: true
        }

    }

}
