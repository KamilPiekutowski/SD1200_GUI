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

