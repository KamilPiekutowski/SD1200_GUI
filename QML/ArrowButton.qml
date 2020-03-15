import QtQuick 2.4
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

RoundButton {
    id: button1
    width: 100
    height: 100
    background: Rectangle {
        radius: 0
        color: "#A3C756"
    }
    font.family: "Roboto"

    LinearGradient {
        anchors.fill: parent
        start: Qt.point(0, parent.height * 0.01)
        end: Qt.point(0, parent.height * (0.99))
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#647a35" }
            GradientStop { position: 0.5; color: "#a3c756" }
            GradientStop { position: 1.0; color: "#647a35" }
        }
    }

    radius: 0
}
