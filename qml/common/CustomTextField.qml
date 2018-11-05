import QtQuick 2.11

Item {
    id: customButtom
    height: root.dp(70)
    width: root.dp(300)

    property color tfTitleColor: contrastColor1
    property color tfHintColor: contrastColor2
    property color tfTextColor: contrastColor1
    property color tfColor: contrastColor3

    property var tfRadius: root.dp(30)
    property var tfTextTitle: "Title"
    property var tfTextHint: ""
    property var tfTextType: Qt.ImhNone
    property var tfTextMask: ""
    property var tfEchoMode: TextInput.Normal

    property alias tfTextText: tfTextEdit.text

    Rectangle {
        id: spacer
        width: parent.width
        height: root.dp(10)
        color: "transparent"
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Text {
        id: tfTitle
        width: parent.width
        height: root.dp(20)
        text: tfTextTitle
        font.bold: true
        font.pixelSize: root.sp(14)
        anchors.left: parent.left
        anchors.top: spacer.bottom
        color: tfTitleColor
    }

    TextInput {
        id: tfTextEdit
        width: parent.width
        height: root.dp(40)
        anchors.top: tfTitle.bottom
        anchors.left: parent.left

        font.pixelSize: root.sp(14)
        color: tfTextColor
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        leftPadding: tfRadius
        z: 0
        inputMethodHints: tfTextType
        inputMask: tfTextMask
        echoMode: tfEchoMode
    }

    Rectangle {
        id: tfBackground
        width: parent.width
        height: root.dp(40)
        anchors.top: tfTitle.bottom
        anchors.left: parent.left

        color: tfColor
        radius: tfRadius
        z: -1
    }
}
