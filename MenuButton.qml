import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

RoundButton {
    id: browserButton
    width: parent.width * 0.35
    height: parent.height * 0.25

    property string customText;

    background: Rectangle {
        radius: 0
        color: "#0C1923"
    }

    LinearGradient {
        anchors.fill: parent
        start: Qt.point(0, parent.height * 0.01)
        end: Qt.point(0, parent.height * (0.99))
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#0C1923" }
            GradientStop { position: 0.5; color: "#1a374d" }
            GradientStop { position: 1.0; color: "#0C1923" }
        }
    }

    Text {
        id: browserText1
        text: qsTr(customText)
        color: "#F6F5FC"
        anchors.centerIn: parent

        font.pixelSize: 24
        font.family: "Roboto"

        layer.enabled: true
        layer.samples: 16
    }

    radius: 0
}
