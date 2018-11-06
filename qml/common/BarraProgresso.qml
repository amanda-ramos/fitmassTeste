import QtQuick 2.9
import QtQuick.Controls 2.4 as Quick2

Item {
    id: progressCard
    width: parent.width

    // height: title1.height + spacing.height + back.height + spacing.height + low.height + spacing.height

    property alias title: title1.text
    property alias subtitle: title2.text
    property alias titleValue: titleValue.text

    property int min
    property int max
    property real value
    property real lowValue
    property real highValue

    property real barWidth: parent.width - dp(30)
    property real topWidth: value * barWidth / (max - min)
    property real lowWidth: lowValue * barWidth / (max - min)
    property real normalWidth: (highValue - lowValue) * barWidth / (max - min)
    property real highWidth: (max - highValue) * barWidth / (max - min)

    Text {
        id: title1
        text: ""
        anchors.left: back.left
        bottomPadding: root.dp(5)
        color: white
        font.pixelSize: root.sp(12)
    }

    Text {
        id: title2
        text: ""
        font.pixelSize: root.sp(8)
        anchors.left: title1.right
        anchors.bottom: title1.bottom
        leftPadding: root.dp(5)
        bottomPadding: root.dp(5)
        color: white
    }

    Text {
        id: titleValue
        text: ""
        anchors.right: back.right
        bottomPadding: root.dp(5)
        color: contrastColor3
        font.bold: true
        font.pixelSize: root.sp(12)
    }

    Rectangle {
        id: back
        width: barWidth
        height: root.dp(15)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: title1.bottom
        color: grayLight
    }

    Rectangle {
        id: topLayer
        width: topWidth
        height: back.height
        anchors.left: back.left
        anchors.top: back.top
        color: contrastColor3
    }

    Rectangle {
        id: spacing
        color: "transparent"
        height: root.dp(5)
        width: parent.width
        anchors.top: back.bottom
    }

    Rectangle {
        id: low
        width: lowWidth
        height: root.dp(10)
        anchors.left: back.left
        anchors.top: spacing.bottom
        color: grayLight2
        opacity: 0.5
    }

    Text {
        id: lowTitle
        width: low.width
        text: "abaixo"
        font.pixelSize: root.sp(6)
        anchors.horizontalCenter: low.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.verticalCenter: low.verticalCenter
        topPadding: root.dp(1)
    }

    Rectangle {
        id: normal
        width: normalWidth
        height: low.height
        anchors.left: low.right
        anchors.top: low.top
        color: grayLight //"#b4b4b4"
    }

    Text {
        id: normaTitle
        width: normal.width
        text: "normal"
        font.pixelSize: root.sp(6)
        font.bold: true
        anchors.horizontalCenter: normal.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.verticalCenter: normal.verticalCenter
        topPadding: root.dp(1)
        color: white
    }

    Rectangle {
        id: high
        width: highWidth
        height: normal.height
        anchors.left: normal.right
        anchors.top: normal.top
        color: grayLight2
        opacity: 0.5
    }

    Text {
        id: highTitle
        width: high.width
        text: "acima"
        font.pixelSize: root.sp(6)
        anchors.horizontalCenter: high.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.verticalCenter: high.verticalCenter
        topPadding: root.dp(1)
    }
}
