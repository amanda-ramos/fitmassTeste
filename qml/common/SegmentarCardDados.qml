import QtQuick 2.0

Item {
    height: row.height
    width: parent.width

    property color titleColor: verdeMassa
    property color subtitleColor: amareloMassa
    property color textColor: "black"
    property color detailColor: "#b4b4b4"

    property var titleFontSize: sp(4)
    property var subtitleFontSize: sp(4)
    property var textFontSize: sp(4)

    property var horizontalAlignmentText: Text.AlignHCenter

    property alias title: title.text
    property alias subtitle: subtitle.text
    property alias valor: valor.text
    property alias analise: analise.text

    Row {
        id: row
        width: parent.width
        height: title.height + subtitle.height + valor.height + analise.height

        Text {
            id: title
            text: ""
            color: titleColor
            font.bold: true
            font.pointSize: titleFontSize
            horizontalAlignment: horizontalAlignmentText
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: subtitle
            text: ""
            color: subtitleColor
            font.bold: true
            font.pointSize: subtitleFontSize
            horizontalAlignment: horizontalAlignmentText
            anchors.right: title.right
            anchors.top: title.bottom
        }

        Text {
            id: valor
            text: ""
            color: textColor
            font.bold: true
            font.pointSize: textFontSize
            horizontalAlignment: horizontalAlignmentText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: subtitle.bottom
        }

        Text {
            id: analise
            text: ""
            color: detailColor
            font.pointSize: textFontSize
            horizontalAlignment: horizontalAlignmentText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: valor.bottom
        }
    }

}
