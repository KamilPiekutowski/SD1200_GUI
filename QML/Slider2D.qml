import QtQuick 2.0

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
        id: mouseArea
        anchors.fill: box2
        drag.target: sliderBtn
        drag.minimumX: 0
        drag.maximumX: width - sliderBtn.width - sliderBtn.border.width
        drag.minimumY: 0
        drag.maximumY: height - sliderBtn.height - sliderBtn.border.width

        onPressed: {
            sliderBtn.x = Math.min(Math.max(parseInt(mouseX), 1), box2.width - sliderBtn.width - sliderBtn.border.width);
            sliderBtn.y = Math.min(Math.max(parseInt(mouseY), 1), box2.height - sliderBtn.height - sliderBtn.border.width);;
        }

        onMouseXChanged: {
            myPerson.sendQMLGuiCtrl(sliderBtn.x/ mouseArea.drag.maximumX,
                                    sliderBtn.y/ mouseArea.drag.maximumY, 'T');
        }

        onMouseYChanged: {
            myPerson.sendQMLGuiCtrl(sliderBtn.x/ mouseArea.drag.maximumX,
                                    sliderBtn.y/ mouseArea.drag.maximumY, 'T');
        }

        onReleased: {
            myPerson.sendQMLGuiCtrl(sliderBtn.x/ mouseArea.drag.maximumX,
                                    sliderBtn.y/ mouseArea.drag.maximumY, 'F');
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

