import QtQuick 2.0
import QtMultimedia 5.5

Rectangle {
    id:videoPlayer
    color:"#df000000"
    anchors.fill:parent
    property url source
    MediaPlayer {
            id: mediaplayer
            source: "file://" + videoPlayer.source
            autoLoad: true
            autoPlay: true
        }

        VideoOutput {
            id:out
            source: mediaplayer
            Rectangle{
                color:"black"
                anchors.fill: parent
                z:-1
            }
        }

        MouseArea {
            id: playArea
            anchors.fill: parent
            onPressed: mediaplayer.play();
            onDoubleClicked: videoPlayer.destroy()
        }
        Component.onCompleted: {
            if(mediaplayer.metaData.size===undefined) {
                out.height=videoPlayer.height-40;
                out.width=videoPlayer.width-40;
                out.x=20;
                out.y=20;
            }
            else {

            }

        }
}

