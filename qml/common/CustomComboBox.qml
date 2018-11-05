import QtQuick 2.11

Item {
    id: customComboBox
    height: root.dp(70)
    width: root.dp(300)

    property color cbTitleColor: contrastColor1
    property color cbTextColor: contrastColor1
    property color cbColor: contrastColor3

    property var cbRadius: root.dp(0)
    property var cbTextTitle: "Title"
    property var cbTextSelected: ""

    Rectangle {
        id: spacer
        width: parent.width
        height: root.dp(10)
        color: "transparent"
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Text {
        id: cbTitle
        width: parent.width
        height: root.dp(20)
        text: cbTextTitle
        font.bold: true
        font.pixelSize: root.sp(14)
        anchors.left: parent.left
        anchors.top: spacer.bottom
        color: cbTitleColor
    }

    Image {
        id: seta
        height: root.dp(5)
        fillMode: Image.PreserveAspectFit
        source: "../../assets/seta2.png"
        anchors.right: parent.right
        anchors.verticalCenter: cbBackground.verticalCenter

    }

    Rectangle {
        id: cbBackground
        width: parent.width
        height: root.dp(40)
        anchors.top: cbTitle.bottom
        anchors.left: parent.left

        color: cbColor
        radius: cbRadius
        z: -1

        Text {
            text: cbTextSelected
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            leftPadding: cbRadius
            color: greenLight
            font.pixelSize: root.sp(14)
        }
    }

}
