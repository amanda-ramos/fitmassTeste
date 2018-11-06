import QtQuick 2.11

Item {
    id: customTextView
    height: root.dp(70)
    width: root.dp(300)

    property color txtTitleColor: contrastColor1
    property color txtHintColor: contrastColor2
    property color txtTextColor: contrastColor1
    property color txtColor: contrastColor3

    property var txtRadius: root.dp(30)
    property var txtTextTitle: "Title"

    property alias txtText: txtText.text

    Rectangle {
        id: spacer
        width: parent.width
        height: root.dp(10)
        color: "transparent"
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Text {
        id: txtTitle
        width: parent.width
        height: root.dp(20)
        text: txtTextTitle
        font.bold: true
        font.pixelSize: root.sp(14)
        anchors.left: parent.left
        anchors.top: spacer.bottom
        color: txtTitleColor
    }

    Text {
        id: txtText
        width: parent.width
        height: root.dp(40)
        anchors.top: txtTitle.bottom
        anchors.left: parent.left

        font.pixelSize: root.sp(14)
        color: txtTextColor
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        leftPadding: txtRadius
        z: 0
    }

    Rectangle {
        id: txtBackground
        width: parent.width
        height: root.dp(40)
        anchors.top: txtTitle.bottom
        anchors.left: parent.left

        color: "transparent"
        border.width: root.dp(1)
        border.color: txtColor
        radius: txtRadius
        z: -1
    }
}
