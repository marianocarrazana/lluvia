import QtQuick 2.5
import QtGraphicalEffects 1.0

import "lluvia.js" as LluviaJS

import "nevadaTheme.js" as Theme

Rectangle
{
    id: rectangle1
    height: column.height+2
    border.width: 1
    radius: 3
    color: "transparent"
    border.color: "transparent"
    visible: true
    property string displayName
    property string source
    property int index
    property int sourceHeight
    property int sourceWidth
    property bool load: false
    onLoadChanged: if(load) image.source = this.source

    MouseArea {
        cursorShape:Qt.PointingHandCursor
        anchors.fill: parent
        hoverEnabled: true
        onEntered: rectangle1.state = "ENTER"
        onExited: rectangle1.state = "EXIT"
        onClicked: startViewer(parent.index)
    }

    Column {
        id: column
        width: parent.width
            Image
            {
                id: image
                cache:false
                asynchronous: true
                sourceSize.width: rectangle1.sourceWidth
                sourceSize.height: rectangle1.sourceHeight
                width: parent.width
                height: parent.width
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
                    width:image.paintedWidth + 1
                    height:image.paintedHeight + 1
                    anchors.centerIn: parent
                    color:"transparent"
                    visible: false
                    border.width: 2
                    border.color: "white"
                }
                Image
                {
                    id: th
                    width:image.width
                    height:image.height
                    sourceSize.width: rectangle1.sourceWidth
                    sourceSize.height: rectangle1.sourceHeight
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


    Text {
        id: text1
        text: rectangle1.displayName
        wrapMode: Text.Wrap
        textFormat: Text.PlainText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 12
        width: parent.width
        color:Theme.textColor
        }
    }

    states: [
        State {
            name: "ENTER"
            PropertyChanges { target: rectangle1; border.color: "#aa3355ff"; color: "#440000ff"}
        },
        State {
            name: "EXIT"
            PropertyChanges { target: rectangle1; border.color: "transparent"; color: "transparent"}
        }
    ]

    transitions: [
        Transition {
            from: "ENTER"
            to: "EXIT"
            ColorAnimation { target: rectangle1; duration: 1000}
        },
        Transition {
            from: "ENTER"
            to: "EXIT"
            ColorAnimation { target: rectangle1; duration: 300}
        }
    ]
    function startViewer(index) //optimizar
    {
        var imageViewer = Qt.createComponent("viewer.qml");
        var imageList = [];
        var indexEnd = index + 4;
        var imgNumb = files.listNumber("images");
        var indexes = [];
        var get=files.getProperty;
        for(var i=index-3;i<indexEnd;i++)
        {
            if(i < 0 || i >= imgNumb)imageList.push("");
            else imageList.push(get(i,"thumbnail","images"));
            indexes.push(i);
        }
        imageViewer.createObject(win,{"sources":imageList,"indexes":indexes});
    }
}
