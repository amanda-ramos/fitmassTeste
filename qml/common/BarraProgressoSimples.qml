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

    Text {
        id: title1
        text: ""
        anchors.left: back.left
        bottomPadding: dp(5)
    }

    Text {
        id: title2
        text: ""
        font.pointSize: sp(3)
        anchors.left: title1.right
        anchors.bottom: title1.bottom
        leftPadding: dp(5)
        bottomPadding: dp(5)
    }

    Text {
        id: titleValue
        text: ""
        anchors.right: back.right
        bottomPadding: dp(5)
        color: amareloMassa
        font.bold: true
    }

    Rectangle {
        id: back
        width: barWidth
        height: dp(15)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: title1.bottom
        color: "#d6d6d6"
    }

    Rectangle {
        id: topLayer
        width: topWidth
        height: back.height
        anchors.left: back.left
        anchors.top: back.top
        color: amareloMassa
    }

    Text {
        id: minValue
        text: min
        anchors.top: back.bottom
        anchors.left: back.left
        color: verdeMassa
        font.pointSize: sp(3)
    }

    Text {
        id: maxValue
        text: max + " kg"
        anchors.top: back.bottom
        anchors.right: back.right
        color: verdeMassa
        font.pointSize: sp(3)
    }
}
