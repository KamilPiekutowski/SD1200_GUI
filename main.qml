import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Window {
    id: root
    visible: true
    width: 800
    height: 460
    title: qsTr("SD 1200")
    color: "#0C1923"


    Component.onCompleted:  {

        for(var i = 0; i < 20; i++)
        {
            OSCBinder.Test()
            myListView.model.append( { name: "Effect_" + i})
        }
    }

    RoundButton {
        id: navigation
        width: parent.width * 0.35
        height: parent.height * 0.25
        anchors.left: parent.left
        anchors.margins: button1.width
        background: Rectangle {
            radius: button1.radius
            color: "#0C1923"
        }

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, navigation.height * 0.01)
            end: Qt.point(0, navigation.height * (0.99))
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#0C1923" }
                GradientStop { position: 0.5; color: "#1a374d" }
                GradientStop { position: 1.0; color: "#0C1923" }
            }
        }

        Text {
            id: navText1
            text: qsTr("Flanger + Echo")
            color: "#F6F5FC"
            anchors.centerIn: parent

            font.pixelSize: 24
            font.family: "Roboto"

            layer.enabled: true
            layer.samples: 16
        }

        onClicked: listViewBox.visible = !listViewBox.visible

        radius: 0
    }


    RoundButton {
        id: button1
        width: parent.height * 0.25
        height: parent.height * 0.25
        anchors.right: navigation.left
        background: Rectangle {
            radius: button1.radius
            color: "#A3C756"
        }

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, navigation.height * 0.01)
            end: Qt.point(0, navigation.height * (0.99))
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#647a35" }
                GradientStop { position: 0.5; color: "#a3c756" }
                GradientStop { position: 1.0; color: "#647a35" }
            }
        }

        Text {
            id: bText1
            text: qsTr("button1")
            color: "#F6F5FC"
            anchors.centerIn: parent

            font.family: "Roboto"

            layer.enabled: true
            layer.samples: 16
        }

        radius: 0
    }

    RoundButton {
        id: button2
        width: parent.height * 0.25
        height: parent.height * 0.25
        anchors.left: navigation.right
        background: Rectangle {
            radius: button1.radius
            color: "#A3C756"
        }

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, navigation.height * 0.01)
            end: Qt.point(0, navigation.height * (0.99))
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#647a35" }
                GradientStop { position: 0.5; color: "#a3c756" }
                GradientStop { position: 1.0; color: "#647a35" }
            }
        }

        Text {
            id: bText2
            text: qsTr("Button2")
            color: "#F6F5FC"
            anchors.centerIn: parent

            font.family: "Roboto"

            layer.enabled: true
            layer.samples: 16
        }

        radius: 0
    }

    RoundButton {
        id: settings
        width: parent.width - navigation.width - button1.width - button2.width
        height: parent.height * 0.25
        anchors.right: parent.right
        background: Rectangle {
            radius: button1.radius
            color: "#0C1923"
        }

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, navigation.height * 0.01)
            end: Qt.point(0, navigation.height * (0.99))
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#0C1923" }
                GradientStop { position: 0.5; color: "#1a374d" }
                GradientStop { position: 1.0; color: "#0C1923" }
            }
        }


        Text {
            id: sText1
            text: qsTr("Settings")
            color: "#F6F5FC"
            anchors.centerIn: parent

            font.pixelSize: 24

            font.family: "Roboto"

            layer.enabled: true
            layer.samples: 16
        }



        radius: 0
    }


    Rectangle {
        id: box2
        width: parent.width;
        height: parent.height * 0.75
        color: "#0C1923"
        anchors.bottom: parent.bottom
        border.width: 4;
        border.color: "#647a35"
        radius: 10

        MouseArea {
            anchors.fill: box2
            drag.target: sliderBtn
            drag.minimumX: 0
            drag.maximumX: width - sliderBtn.width - sliderBtn.border.width
            drag.minimumY: 0
            drag.maximumY: height - sliderBtn.height - sliderBtn.border.width

            onClicked: {
                var posX = mouse.x
                var posY = mouse.y

                if(posX > box2.width - sliderBtn.width - sliderBtn.border.width)
                {
                    posX = box2.width - sliderBtn.width - sliderBtn.border.width
                }
                if(posY > box2.height - sliderBtn.height - sliderBtn.border.width)
                {
                    posY = box2.height - sliderBtn.height - sliderBtn.border.width
                }

                sliderBtn.x = posX
                sliderBtn.y = posY
            }
        }

        Rectangle {
            id: sliderBtn
            width: 27
            height: 30
            x: parent.width /2 - width/2
            y: parent.height /2 - height/2
            radius: 50
            color: box2.color
            border.width: 4;
            border.color: box2.border.color
        }

    }

    Rectangle {
        visible: false
        id: listViewBox
        width: parent.width
        height: parent.height * 0.75
        color: "#0C1923"
        anchors.bottom: parent.bottom
        border.width: 4;
        border.color: "#647a35"


        Rectangle
        {
            anchors.fill: parent
            anchors.topMargin: parent.border.width +3
            anchors.bottomMargin: parent.border.width +3
            anchors.rightMargin: parent.border.width +3
            anchors.leftMargin: parent.border.width +3

            color: parent.color

            ListView {
                id: myListView
                height: parent.height
                width: parent.width
                anchors.fill: parent
                model: ListModel {}
                clip: true

                delegate: Text {
                    text: name
                    color: navText1.color
                    font.pixelSize: navText1.font.pixelSize
                    font.family: navText1.font.family
                    clip:true
                }

                boundsBehavior: Flickable.StopAtBounds
                focus: true
            }

        }


    }

}
