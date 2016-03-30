import QtQuick 2.5
import QtQuick.Extras 1.4
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0

import "lluvia.js" as LluviaJS

Rectangle {

    color: "#df000000"
    anchors.fill:parent
    id: view
    property variant sources
    property variant indexes

    MouseArea
    {
        anchors.fill: parent
        onClicked: view.destroy()
    }

    Image {
        id: centerImg
        mipmap: true
        autoTransform: true


        anchors.rightMargin: 100
        anchors.leftMargin: 100
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        sourceSize.width: width
        sourceSize.height: height
        fillMode: Image.PreserveAspectFit
        anchors.fill: parent
        source: parent.sources[3]
        z:3
        Rectangle {
            id:rec
                width:parent.paintedWidth + 1
                height:parent.paintedHeight + 1
                anchors.centerIn: parent

                color:"transparent"
                border.color:"white"
                border.width: 2


            }
        Rectangle {
                width:rec.width
                height:rec.height
                anchors.centerIn: rec

                color:"black"
                z:-2



            }
        RectangularGlow {

            width:parent.paintedWidth + 1
            height:parent.paintedHeight + 1
            anchors.centerIn: parent
                glowRadius: 8
                spread: 0.1
                color: "black"
                cornerRadius: 30
                z:-2
            }
        MouseArea{
            onDoubleClicked: LluviaJS.displayFullViewer(view.indexes[3])

            anchors.fill: rec
        }
    }


    Image {
        id: image4
        autoTransform: true
        rotation: -30

        asynchronous: true
        x: (centerImg.width/2 * Math.cos(Math.PI*1.9)) + (parent.width/2-width/2)
        y: (centerImg.width/2 * Math.sin(Math.PI*1.9)) + (parent.height/2-height/2)
        fillMode: Image.PreserveAspectFit
        width: parent.width / 3
        height: parent.height / 3
        sourceSize.width: width
        sourceSize.height: height
        source: parent.sources[4]
        property int index: parent.indexes[4]
        z:2
        visible: status == Image.Ready
        Rectangle {
            id:rec1
            antialiasing: true
                width:parent.paintedWidth
                height:parent.paintedHeight
                anchors.centerIn: parent
                border.color: "white"
                color: "transparent"
                border.width: 1

            }
        RectangularGlow {

            anchors.fill: rec1
                glowRadius: 4
                spread: 0.1
                color: "black"
                cornerRadius: 30
                z:-1
            }
        MouseArea{
            cursorShape:Qt.PointingHandCursor
            onClicked: updateViewer(image4.index);anchors.fill: parent}
    }
    Image {
        id: image5
        autoTransform: true
        asynchronous: true
        x: (centerImg.width/2 * Math.cos(Math.PI*2)) + (parent.width/2-width/2)
        y: (centerImg.width/2 * Math.sin(Math.PI*2)) + (parent.height/2-height/2)
        fillMode: Image.PreserveAspectFit
        width: parent.width / 4
        height: parent.height / 4
        sourceSize.width: width
        sourceSize.height: height
        source: parent.sources[5]
        property int index: parent.indexes[5]
        Rectangle {
            id:rec2
            antialiasing: true
                width:parent.paintedWidth
                height:parent.paintedHeight
                anchors.centerIn: parent
                border.color: "white"
                color: "transparent"
                border.width: 1
            }
        RectangularGlow {

            anchors.fill: rec2
                glowRadius: 4
                spread: 0.1
                color: "black"
                cornerRadius: 30
                z:-1
            }
        MouseArea{
            cursorShape:Qt.PointingHandCursor
            onClicked: updateViewer(image5.index);anchors.fill: parent}
        z:1
        visible: status == Image.Ready
    }
    Image {
        id: image6
        autoTransform: true
        rotation: 30
        antialiasing: true
        asynchronous: true
        x: (centerImg.width/2 * Math.cos(Math.PI*0.1)) + (parent.width/2-width/2)
        y: (centerImg.width/2 * Math.sin(Math.PI*0.1)) + (parent.height/2-height/2)
        fillMode: Image.PreserveAspectFit
        width: parent.width / 5
        height: parent.height / 5
        sourceSize.width: width
        sourceSize.height: height
        source: parent.sources[6]
        property int index: parent.indexes[6]
        Rectangle {
            id:rec3
            antialiasing: true
                width:parent.paintedWidth
                height:parent.paintedHeight
                anchors.centerIn: parent
                border.color: "white"
                color: "transparent"
                border.width: 1
            }
        RectangularGlow {

            anchors.fill: rec3
                glowRadius: 4
                spread: 0.1
                color: "black"
                cornerRadius: 30
                z:-1
            }
        MouseArea{
            cursorShape:Qt.PointingHandCursor
            onClicked: updateViewer(image6.index);anchors.fill: parent}
        z:0
        visible: status == Image.Ready
    }

    Image {
        id: image2
        autoTransform: true
        rotation: -30
        antialiasing: true
        asynchronous: true
        x: (centerImg.width/2 * Math.cos(Math.PI*0.9)) + (parent.width/2-width/2)
        y: (centerImg.width/2 * Math.sin(Math.PI*0.9)) + (parent.height/2-height/2)
        fillMode: Image.PreserveAspectFit
        width: parent.width / 3
        height: parent.height / 3
        sourceSize.width: width
        sourceSize.height: height
        source: parent.sources[2]
        property int index: parent.indexes[2]
        Rectangle {
            id:rec4
            antialiasing: true
                width:parent.paintedWidth
                height:parent.paintedHeight
                anchors.centerIn: parent
                border.color: "white"
                color: "transparent"
                border.width: 1
            }
        RectangularGlow {

            anchors.fill: rec4
                glowRadius: 4
                spread: 0.1
                color: "black"
                cornerRadius: 30
                z:-1
            }
        MouseArea{
            cursorShape:Qt.PointingHandCursor
            onClicked: updateViewer(image2.index);anchors.fill: parent}
        z:2
        visible: status == Image.Ready
    }
    Image {
        id: image1
        autoTransform: true
        asynchronous: true
        x: (centerImg.width/2 * Math.cos(Math.PI)) + (parent.width/2-width/2)
        y: (centerImg.width/2 * Math.sin(Math.PI)) + (parent.height/2-height/2)
        fillMode: Image.PreserveAspectFit
        width: parent.width / 4
        height: parent.height / 4
        sourceSize.width: width
        sourceSize.height: height
        source: parent.sources[1]
        property int index: parent.indexes[1]
        Rectangle {
            id:rec5
            antialiasing: true
                width:parent.paintedWidth
                height:parent.paintedHeight
                anchors.centerIn: parent
                border.color: "white"
                color: "transparent"
                border.width: 1
            }
        RectangularGlow {

            anchors.fill: rec5
                glowRadius: 4
                spread: 0.1
                color: "black"
                cornerRadius: 30
                z:-1
            }
        MouseArea{
            cursorShape:Qt.PointingHandCursor
            onClicked: updateViewer(image1.index);anchors.fill: parent}
        z:1
        visible: status == Image.Ready
    }
    Image {
        id: image0
        autoTransform: true
        rotation: 30
        antialiasing: true
        asynchronous: true
        x: (centerImg.width/2 * Math.cos(Math.PI*1.1)) + (parent.width/2-width/2)
        y: (centerImg.width/2 * Math.sin(Math.PI*1.1)) + (parent.height/2-height/2)
        fillMode: Image.PreserveAspectFit
        width: parent.width / 5
        height: parent.height / 5
        sourceSize.width: width
        sourceSize.height: height
        source: parent.sources[0]
        property int index: parent.indexes[0]
        Rectangle {
            id:rec6
            antialiasing: true
                width:parent.paintedWidth
                height:parent.paintedHeight
                anchors.centerIn: parent
                border.color: "white"
                color: "transparent"
                border.width: 1
            }
        RectangularGlow {

            anchors.fill: rec6
                glowRadius: 4
                spread: 0.1
                color: "black"
                cornerRadius: 30
                z:-1
            }
        MouseArea{
            cursorShape:Qt.PointingHandCursor
            onClicked: updateViewer(image0.index);anchors.fill: parent}
        z:0
        visible: status == Image.Ready
    }
    Keys.onLeftPressed: updateViewer(indexes[2])
    Keys.onRightPressed: updateViewer(indexes[4])
    Keys.onSpacePressed: updateViewer(indexes[4])
    Keys.onEscapePressed: view.destroy()
    Component.onCompleted: this.focus = true
    function updateViewer(index)
    {
        if(index<0)return 0;
        var imgNumb = files.listNumber("images");
        if(index>=imgNumb)return 1;
        var indexEnd = index + 4;
        var indexes = [];
        var imageList = [];
        var get=files.getProperty;
        for(var i=index-3;i<indexEnd;i++)
        {
            if(i < 0 || i >= imgNumb)imageList.push("");
            else imageList.push(get(i,"thumbnail","images"));
            indexes.push(i);
        }

        view.sources = imageList;
        view.indexes = indexes;
    }

}

