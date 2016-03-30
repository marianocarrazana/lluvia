import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.2

import "lluvia.js" as LluviaJS

Item {
    id:thumb
    width: scroll.height - 20
    height: scroll.height - 20
    property string displayName
    property int index
    property int sourceHeight
    property int sourceWidth
    property url source
    property bool load: false
    onLoadChanged: if(load) imgThumb.source = this.source
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: LluviaJS.changeIndex(win.activeFocusItem,thumb.index,win.activeFocusItem.index)
    }
    Image {
        id: imgThumb
        cache: false
        asynchronous: true
        sourceSize.width: thumb.sourceWidth * 1.5
        sourceSize.height: thumb.sourceHeight * 1.5
        width: thumb.sourceWidth
        height: thumb.sourceHeight
        fillMode: Image.PreserveAspectFit
        onStatusChanged: {
            if(status === Image.Ready){
                th.destroy();
                border.visible = true;
                shadow.visible = true;
            }
        }

        Rectangle
        {
            id: border
            width:imgThumb.paintedWidth + 1
            height:imgThumb.paintedHeight + 1
            anchors.centerIn: parent
            color:"transparent"
            visible: false
            border.width: 2
            border.color: "white"
        }
        Image
        {
            id: th
            width:imgThumb.width
            height:imgThumb.height
            sourceSize.width: imgThumb.sourceWidth
            sourceSize.height: imgThumb.sourceHeight
            fillMode: Image.PreserveAspectFit
            source: "icons/gpicview.svg"
            z:-1
        }
        RectangularGlow
        {
            id: shadow
            anchors.centerIn: parent
            width: parent.paintedWidth
            height: parent.paintedHeight
            color:"black"
            z:-1
            spread: 0.1
            cornerRadius: 5
            glowRadius: 5
            visible: false
        }

    }
    transformOrigin: Item.Bottom
    states: [
        State {
            name: "UNSELECTED"
            PropertyChanges {
                target: shadow
                color: "black"
            }
            PropertyChanges {
                target: thumb
                scale: 1
            }
            PropertyChanges {
                target: thumb
                z: 0
            }
        },
        State {
            name: "SEMISELECTED"
            PropertyChanges {
                target: shadow
                color: "black"
            }
            PropertyChanges {
                target: thumb
                scale: 1.2
            }
            PropertyChanges {
                target: thumb
                z: 1
            }
        },
        State {
            name: "SELECTED"
            PropertyChanges {
                target: shadow
                color: "#35f"
            }
            PropertyChanges {
                target: thumb
                scale: 1.5
            }
            PropertyChanges {
                target: thumb
                z: 2
            }
        }
    ]
    state: "UNSELECTED"
//
// TRANSITIONS MAKE THE IMAGES LOADS VERY SLOW
// WHEN THEY ARE TOO MUCH OR TOO BIG (cpu dependent)
// WE NEED A CONFIGURATION DIALOG TO ENABLE THIS
//
    transitions: [
        Transition {
            from: "*"
            to: "*"
            NumberAnimation {
                target: thumb
                property: "scale"
                duration: 300
                easing.type: Easing.Linear
            }
        }
    ]
}

