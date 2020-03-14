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
            highlight: highlightBar
            highlightFollowsCurrentItem: false

            onCurrentIndexChanged: {
                        console.log(model.get("currentIndex"))
                  }

            delegate: Text {
                property string textColor: browserListView.textColor
                property int idx: index
                property string controllerType: ctlType

                id: componentText
                text: name
                color: textColor
                font.pixelSize: browserButton.children[1].font.pixelSize
                font.family: browserButton.children[1].font.family
                clip:true

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("index " + idx);
                        console.log("ctlType " + ctlType);
                        effectsBrowser.visible = !effectsBrowser.visible;

                        //set the text of browser button
                        browserButton.customText = name;
                        browserListView.currentIndex = idx;
                        oscBinder.sendQMLGuiSetSynthDef(name + "_" + ctlType);
                    }
                }
            }

            Component {
                id: highlightBar
                Rectangle {
                    width: listViewBox.width
                    height: browserButton.children[1].font.pixelSize + 6
                    color: "#FFFF88"
                    opacity: 0.2
                    y: browserListView.currentItem.y;
                    //Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
                }
            }


            boundsBehavior: Flickable.StopAtBounds
            focus: true
        }

    }

}
