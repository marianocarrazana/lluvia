import QtQuick 2.5
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.2

import "nevadaTheme.js" as Theme

MouseArea {
    id:btn
    property string iconSource
    property string text
    property int fontSize: 12
    hoverEnabled: true
    onEntered: glow.state = "ENTER"
    onExited: glow.state = "EXIT"

    ColumnLayout{
        id:col
        anchors.fill: parent
        anchors.topMargin: 2
        anchors.bottomMargin: 2
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        Image {
            id:icon
            source: iconSource
            Layout.fillWidth: true
            Layout.fillHeight: true
            fillMode: Image.PreserveAspectFit
            sourceSize.width: width
            sourceSize.height: height
        }
        Text {
            id:label
            color: Theme.textColor
            text: btn.text
            font.pointSize: btn.fontSize
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true

        }
    }
    Rectangle {
        anchors.fill:parent
        border.width: 1
        radius:3
        gradient: Gradient {
            GradientStop {
                position: 0
                color: Theme.btnGradient1
            }

            GradientStop {
                position: 1
                color: Theme.btnGradient2
            }
        }
        border.color: Theme.btnBorderColor
        z:-1
    }
    RectangularGlow{
        id:glow
        anchors.fill: parent
        glowRadius: 0
        spread: 0.1
        color: "#111"
        cornerRadius: 2
        z:-2
        states: [
            State {
                name: "ENTER"
                PropertyChanges { target: glow;  color: "#35f";glowRadius: 2}
            },
            State {
                name: "EXIT"
                PropertyChanges { target: glow;  color: "#111";glowRadius: 0}
            }
        ]

        transitions: [
            Transition {
                from: "ENTER"
                to: "EXIT"
                NumberAnimation { properties: "glowRadius"; duration: 1000 }
                ColorAnimation { target: glow; duration: 1000}
            },
            Transition {
                from: "ENTER"
                to: "EXIT"
                NumberAnimation { properties: "glowRadius"; duration: 300 }
                ColorAnimation { target: glow; duration: 300}
            }
        ]
    }
    Component.onCompleted: {
        if(text==="")label.destroy();
        if(iconSource==="")icon.destroy();
    }
}
