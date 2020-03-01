import QtQuick 2.4
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item{
    RoundButton {
        id: button1
        width: 100
        height: 100
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
}
