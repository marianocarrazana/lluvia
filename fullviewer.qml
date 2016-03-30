import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4

import "lluvia.js" as LluviaJS


Rectangle {
    id: fullView
    color:"black"
    width:win.width
    height:win.height
    z:9
    property real thumbSize
    property int activeIndex

    Timer {
        id:autoHideThumbs
        interval: 1000; running: false; repeat: false
        onTriggered: scroll.state = "INVISIBLE"
    }

    Timer {
        id:autoHideButtons
        interval: 1000; running: true; repeat: false
        onTriggered: btnExit.visible = false
    }

    Timer {
        id: timerPreview
        interval: 100
        repeat: false
        running: false
        onTriggered: {
            var list = thumbs.children;
            var positionX = -1;
            var contentX = thumbsFlick.contentX;
            var w = list[0].height;
            for (var i=list.length-1;i>=0;i--) {
                positionX = list[i].x + w - contentX;
                if(positionX >= 0 && positionX < win.width + w)list[i].load = true;

            }
        }
    }

    MouseArea {
        hoverEnabled: true
        y:parent.height-height
        height:116
        width: parent.width
        onEntered: {
            scroll.opacity = 1;
            autoHideThumbs.stop();
            autoHideButtons.start();
        }

    }

    MouseArea {
        hoverEnabled: true
        y:0
        height:parent.height-scroll.height
        width: parent.width
        onEntered: {
            btnExit.visible = true;
            autoHideThumbs.start();
        }
        onMouseXChanged: {btnExit.visible = true;autoHideButtons.restart()}
        onMouseYChanged: {btnExit.visible = true;autoHideButtons.restart()}
    }

    Item {
        id: imgContainer
        width:fullView.width
        height:fullView.height

    }

    Item {
        id:scroll
        visible: false
        y:parent.height-height
        height: 110
        width:parent.width

        states: [
            State {
                name: "VISIBLE"
                PropertyChanges {
                    target: scroll
                    opacity: 1
                }
            },
            State {
                name: "INVISIBLE"
                PropertyChanges {
                    target: scroll
                    opacity: 0
                }
            }
        ]

        state: "INVISIBLE"

        transitions: [
            Transition {
                from: "*"
                to: "*"

                NumberAnimation {
                    target: scroll
                    property: "opacity"
                    duration: 200
                    easing.type: Easing.Linear
                }
            }
        ]

        Flickable {
            id: thumbsFlick
            anchors.fill: parent
            rightMargin: 10
            leftMargin: 10
            contentWidth: thumbs.width
            contentHeight: thumbs.height
            onContentXChanged: timerPreview.restart()

            RowLayout {
                id: thumbs
                y:4
                height:scroll.height
                spacing: 10

                NumberAnimation {
                    id: moveAnim
                    target: thumbsFlick
                    property: "contentX"
                    from: thumbsFlick.contentX
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    NevadaButton {
        id: btnExit
        text: qsTr("Close")
        width:50
        height:25
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        onClicked: {
            win.visibility=2;
            fullView.destroy();
        }
    }

    Component.onCompleted:    {
        LluviaJS.loadFullViewer(fullView.activeIndex);
        win.visibility = 5;
        scroll.visible = true;
    }
}
