import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Item
{
    id:ss
    anchors.fill: parent
    property string source
    property real w
    property real h
    property int i
    property int orientation
SplitView
{
    id:split
    orientation: parent.orientation
    anchors.fill: parent

    Rectangle{
        width:ss.w
        height:ss.h
        Layout.minimumHeight: 10
        Layout.minimumWidth: 10
        color:"transparent"
        border.width:1
        border.color:children[0].focus?"#35f":"transparent"

        FullImage{
            source:ss.source
            focus:true
            index:i
            z:-1
        }
    }
    Rectangle{
        id:delectable
        width:ss.w
        height:ss.h
        Layout.minimumHeight: 10
        Layout.minimumWidth: 10
        color:"transparent"
        border.width:1
        border.color:children[0].focus?"#35f":"transparent"
        FullImage{
            source:ss.source
            index:i
            z:-1
        }
    }
}
    NevadaButton {
        id: del
        text: qsTr("-")
        height: 24
        width: 24
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 128
        anchors.right: parent.right
        anchors.rightMargin: 5
        onClicked: {split.removeItem(delectable);delectable.destroy();del.destroy()}
        activeFocusOnTab: false
        visible:btnExit.visible
    }

}
