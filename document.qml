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
    property string thumb

    MouseArea {
        cursorShape:Qt.PointingHandCursor
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
            source: "icons/file-roller.svg"
            height:folder.width
            asynchronous: false
            sourceSize.width: width
            sourceSize.height: height
            fillMode: Image.PreserveAspectFit


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
