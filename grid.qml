import QtQuick 2.0
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4


GridLayout {
    id: previewContainer
        Layout.fillHeight: false
        Layout.fillWidth: true
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.leftMargin: 30
        onHeightChanged: parent.height = height;


    }

