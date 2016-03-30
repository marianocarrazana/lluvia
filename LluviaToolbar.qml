import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtGraphicalEffects 1.0

import "nevadaTheme.js" as Theme
import "lluvia.js" as LluviaJS

Rectangle{
    color:Theme.fgColor
    height:48
    RectangularGlow{
        id:glow
        anchors.fill: parent
        glowRadius: 5
        spread: 0.1
        color: "#111"
        cornerRadius: 2
        z:-1
    }
    RowLayout {
        anchors.fill: parent
        spacing: 10
        anchors.topMargin: 2
        anchors.leftMargin: 5
        NevadaButton {
            iconSource: "icons/go-previous-symbolic.svg"
            width:32
            height:32
            onClicked: files.back()
        }
        NevadaButton {
            iconSource: "icons/go-next-symbolic.svg"
            width:32
            height:32
            onClicked: files.forwad()
        }
        NevadaButton {
            iconSource: "icons/go-up-symbolic.svg"
            width:32
            height:32
            onClicked: files.up()
        }
        Item { Layout.fillWidth: true }
        TextInput {
            readOnly: true
            id: textInput1
            width: 80
            height: 20
            text: files.directory
            color:Theme.textColor
            Layout.fillWidth: true
            font.pixelSize: 12
        }
        Item { Layout.fillWidth: true }
        NevadaButton {
            iconSource: "icons/view-grid-symbolic.svg"
            width:32
            height:32
            onClicked: listContainer.listTypes = "all"
        }
        NevadaButton {
            iconSource: "icons/view-list-symbolic.svg"
            width:32
            height:32
            onClicked: listContainer.listTypes = "all"
        }
        NevadaButton {
            iconSource: "icons/folder-pictures-symbolic.svg"
            width:32
            height:32
            onClicked: listContainer.listTypes = "images"
        }
        NevadaButton {
            iconSource: "icons/folder-videos-symbolic.svg"
            width:32
            height:32
            onClicked: listContainer.listTypes = "videos"
        }
        NevadaButton {
            iconSource: "icons/folder-documents-symbolic.svg"
            width:32
            height:32
            onClicked: listContainer.listTypes = "documents"
        }
    }
}
