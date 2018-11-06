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

    property real barWidth: parent.width - root.dp(30)
    property real topWidth: value * barWidth / (max - min)

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
        color: grayLight //"#d6d6d6"
    }

    Rectangle {
        id: topLayer
        width: topWidth
        height: back.height
        anchors.left: back.left
        anchors.top: back.top
        color: contrastColor3
    }

    Text {
        id: minValue
        text: min
        anchors.top: back.bottom
        anchors.left: back.left
        color: contrastColor2
        font.pixelSize: root.sp(8)
    }

    Text {
        id: maxValue
        text: max + " kg"
        anchors.top: back.bottom
        anchors.right: back.right
        color: contrastColor2
        font.pixelSize: root.sp(8)
    }
}
