import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

import "lluvia.js" as LluviaJS

FocusScope{
    id:imgCont
    activeFocusOnTab: true
    focus:true
    onWidthChanged: autoSize.restart()
    onHeightChanged: autoSize.restart()
    property string source
    property real sourceWidth
    property real sourceHeight
    property real aspect
    property bool ready: false
    property int zoomMode
    //1:Fit to height
    //2:Fit to width
    //3:Original size
    //4:User defined(wheel zoom)
    property int update: 10
    property int index
    property real scale
    onSourceChanged: fImg.source = source

    Timer
    {
        id:autoSize
        interval: 100
        repeat: false
        running: false
        onTriggered: updateZoom(0)
    }



    width: parent.width
    height: parent.height

    Keys.onLeftPressed: LluviaJS.changeIndex(fImg, fImg.index-1, fImg.index, setImg)
    Keys.onRightPressed: LluviaJS.changeIndex(fImg,fImg.index+1, fImg.index, setImg)
    Keys.onSpacePressed: LluviaJS.changeIndex(fImg,fImg.index+1, fImg.index, setImg)
    Keys.onEscapePressed: {win.visible=true;fullView.close()}
    Keys.onPressed: {
        if(event.key === Qt.Key_A)LluviaJS.changeIndex(fImg,fImg.index-1, fImg.index, setImg);
        else if(event.key === Qt.Key_D)LluviaJS.changeIndex(fImg,fImg.index+1, fImg.index, setImg);
        else if(event.key === Qt.Key_F)win.visibility=win.visibility===2?5:2;
    }

    Flickable {
        id:flick
        clip:true
        width: parent.width
        height: parent.height

        anchors.centerIn: parent

        contentWidth: fImg.width; contentHeight: fImg.height

        Image {
            id:fImg
            fillMode: Image.Stretch
            autoTransform: true
            onSourceChanged: reloadimage()
            property int index: imgCont.index
            property string tmpSource


            Timer {
                id: setImg
                interval: 150
                repeat: false
                running: false
                onTriggered: fImg.source = fImg.tmpSource
            }

            MouseArea
            {
                onClicked: imgCont.forceActiveFocus()
                cursorShape:Qt.OpenHandCursor
                anchors.fill: parent
                onDoubleClicked: updateZoom(1)
                onWheel: {
                    imgCont.update++;
                    if(imgCont.update>5)
                    {

                        var scale=imgCont.scale;
                        if (wheel.angleDelta.y > 0) scale+=scale*0.05;
                        else scale-=scale*0.05;
                        if(scale > 0.1){
                            imgCont.zoomMode=4;
                            fImg.width=imgCont.sourceWidth*scale;
                            fImg.height=imgCont.sourceHeight*scale;
                            updateZoom(0);
                            imgCont.update=0;
                        }
                    }
                }
            }

        }
    }


    NevadaButton {
        id: buttonH
        width: 22
        height: parent.height*0.25
        text: qsTr("+")
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 5
        onClicked: newSplit(Qt.Horizontal)
        activeFocusOnTab: false
        visible:btnExit.visible
    }

    NevadaButton {
        id: buttonV
        height:22
        width: parent.width*0.25
        text: qsTr("+")
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: newSplit(Qt.Vertical)
        activeFocusOnTab: false
        visible:btnExit.visible
    }

    Component.onCompleted: {
        reloadimage();
        this.focus=true;
    }
    function reloadimage()
    {
        if(fImg.source=="")fImg.source=imgCont.source;
        else imgCont.source=fImg.source;
        var dimensions = files.imageInfo(fImg.source);
        imgCont.sourceWidth = parseInt(dimensions[0]);
        imgCont.sourceHeight = parseInt(dimensions[1]);
        imgCont.aspect = dimensions[0]/dimensions[1];
        imgCont.ready=true;
        if(imgCont.aspect> imgCont.width / imgCont.height)imgCont.zoomMode=2;
        else imgCont.zoomMode=1;
        updateZoom(0);
        imgCont.scale=fImg.width/imgCont.sourceWidth;
    }

    function newSplit(orientation){
        var w,h;
        if(orientation===Qt.Horizontal)
        {w=parent.width/2;h=parent.height}
        else{w=parent.width;h=parent.height/2}
        var split = Qt.createComponent("splitView.qml");
        var p=split.createObject(imgCont.parent,{"source":imgCont.source,"orientation":orientation,"w":w,"h":h,"i":fImg.index});
        imgCont.focus=false;
        imgCont.visible=false;


    }
    function updateZoom(add)
    {
        if(!imgCont.ready)return 0;
        var zoom=imgCont.zoomMode;
        zoom+=add;

        if(zoom>=4 && add===1)zoom=1;

        //1:Fit to height
        //2:Fit to width
        //3:Original size
        //4:User defined(wheel zoom)
        var h=imgCont.height,w=imgCont.width,a=imgCont.aspect,iw=fImg.width,ih=fImg.height;
        switch(zoom)
        {
        case 1:
            iw=fImg.width=h*a;
            ih=fImg.height=h;
            if(w>iw)flick.width=iw;
            else flick.width=w;
            if(h>ih)flick.height=ih;
            else flick.height=h;
            break;
        case 2:
            iw=fImg.width=w;
            ih=fImg.height=w/a;
            if(w>iw)flick.width=iw;
            else flick.width=w;
            if(h>ih)flick.height=ih;
            else flick.height=h;
            break;

        case 3:
            ih=fImg.height=imgCont.sourceHeight;
            iw=fImg.width=imgCont.sourceWidth;
            if(w>iw)flick.width=iw;
            else flick.width=w;
            if(h>ih)flick.height=ih;
            else flick.height=h;
            break;
        case 4:
            if(w>iw)flick.width=iw;
            else flick.width=w;
            if(h>ih)flick.height=ih;
            else flick.height=h;
            break;
        }
        fImg.sourceSize.height=ih;
        fImg.sourceSize.width=iw;
        imgCont.zoomMode=zoom;
        imgCont.scale = iw/imgCont.sourceWidth;
    }
}
