import QtQuick 2.5
import QtGraphicalEffects 1.0

import "nevadaTheme.js" as Theme

Rectangle
{
    id:folder
    color: "transparent"

    border.width: 1
    radius: 3
    height: column.height+2
    border.color: "transparent"
    property string displayName
    property string path
    property url thumbs : qsTr()
    property bool load: false
    onLoadChanged: if(load) preview.source = this.thumbs

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: folder
        hoverEnabled: true
        onEntered: folder.state = "ENTER"
        onExited: folder.state = "EXIT"
        onClicked: files.directory = parent.path
    }

    Column {
        id: column
        width: folder.width

        Image
        {
            id:image
            width: folder.width
            source: "icons/folder.svg"
            height:folder.width
            asynchronous: false
            sourceSize.width: width
            sourceSize.height: height
            fillMode: Image.PreserveAspectFit
            Image
            {
                id:preview
                asynchronous: true
                width: folder.width * 0.7
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                y:parent.height * 0.15
                sourceSize.width: width
                sourceSize.height: width
                fillMode: Image.PreserveAspectFit
                onStatusChanged: if(preview.status === Image.Error)preview.destroy()
                rotation: 15-Math.random()*30
                Rectangle
                {
                    antialiasing: true
                    anchors.centerIn: preview
                    width: parent.paintedWidth + 1
                    height: parent.paintedHeight + 1
                    color: "transparent"
                    visible: preview.status == Image.Ready
                    border.width: 2
                    border.color: "white"
                }
                RectangularGlow
                {
                    anchors.centerIn: parent
                    width: parent.paintedWidth
                    height: parent.paintedHeight
                    color:"black"
                    z:-1
                    spread: 0.1
                    cornerRadius: 5
                    glowRadius: 5
                    visible: preview.status == Image.Ready
                }


            }

        }

        Text {
            id: text
            width: parent.width
            text: folder.displayName
            textFormat: Text.PlainText
            wrapMode: Text.Wrap
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
            color:Theme.textColor
        }

    }

    states: [
        State {
            name: "ENTER"
            PropertyChanges { target: folder; border.color: "#aa3355ff"; color: "#440000ff"}
        },
        State {
            name: "EXIT"
            PropertyChanges { target: folder; border.color: "transparent"; color: "transparent"}
        }
    ]

    transitions: [
        Transition {
            from: "ENTER"
            to: "EXIT"
            ColorAnimation { target: folder; duration: 1000}
        },
        Transition {
            from: "ENTER"
            to: "EXIT"
            ColorAnimation { target: folder; duration: 300}
        }
    ]

}
