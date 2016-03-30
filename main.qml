import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.2
import com.nevada.lluvia 1.0
import QtQuick.Controls.Styles 1.4

import "lluvia.js" as LluviaJS
import "nevadaTheme.js" as Theme

ApplicationWindow {
    id: win
    title: "Lluvia"
    visible: true
    width:640
    height:480
    color: Theme.bgColor

    minimumHeight: 320
    minimumWidth: 320
    Timer {
        id: timerPreview
        interval: 200
        repeat: false
        running: false
        onTriggered: {
            autoLoadPreview.stop();
            var list = listContainer.children[0].children;
            var positionY = -1;
            var contentY = scrollView1.flickableItem.contentY;
            var h = list[0].height;
            for(var i=list.length-1;i>=0;i--) {
                positionY = list[i].y + h - contentY;
                if(positionY >= 0 && positionY < win.height + h)list[i].load = true;

            }
            autoLoadPreview.start();
        }
    }
    Timer {
        id: autoLoadPreview
        interval: 100
        repeat: true
        running: false
        onTriggered: if (!isCompleted) {
            var list = listContainer.children[0].children;
            var n = list.length-1;
            for(var i=0; i <= n; i++) {
                if(list[i].load === false){
                    list[i].load = true;
                    break;
                }
                if(i === n)isCompleted = true;
            }
        }
        property bool isCompleted: false
    }

    ColumnLayout{
        anchors.fill:parent
        spacing: 0

        LluviaToolbar{
            id:tools
            Layout.fillWidth: true
        }


        ScrollView {
            id: scrollView1
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            style: ScrollViewStyle{
                transientScrollBars:true
            }
            flickableItem.onContentYChanged: {
                timerPreview.restart();

            }
            onHeightChanged: timerPreview.restart()
            onWidthChanged: timerPreview.restart()

            Item {
                id: listContainer
                property string listTypes: "images"
                onListTypesChanged: LluviaJS.reloadImages()
                x: 0
                height: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0

            }

        }
        StatusBar {
            Layout.fillWidth: true
            style: StatusBarStyle {
                padding {
                    left: 8
                    right: 8
                    top: 3
                    bottom: 3
                }
                background: Rectangle {
                    implicitHeight: 16
                    implicitWidth: 200
                    gradient: Gradient{
                        GradientStop{color: Theme.btnGradient1; position: 0}
                        GradientStop{color: Theme.btnGradient2 ; position: 1}
                    }
                    Rectangle {
                        anchors.top: parent.top
                        width: parent.width
                        height: 1
                        color: "#999"
                    }
                }
            }

            RowLayout {
                anchors.fill: parent
                Label {id: stats}
                Slider {
                    id: imageSizeSlider;
                    maximumValue: 256.0
                    minimumValue: 32.0
                    value: 96.0
                    stepSize: 16.0
                    Layout.alignment: Qt.AlignRight
                }
            }
        }
    }

    Lluvia{id:files}

    Component.onCompleted:LluviaJS.load();



}

