import QtQuick 2.0

Item {
    height: row.height
    width: parent.width

    property color titleColor: contrastColor3
    property color subtitleColor: contrastColor2
    property color textColor: grayLight2
    property color detailColor: grayLight2

    property var titleFontSize: root.sp(10)
    property var subtitleFontSize: root.sp(10)
    property var textFontSize: root.sp(10)

    property var horizontalAlignmentText: Text.AlignHCenter

    property alias title: title.text
    property alias subtitle: subtitle.text
    property alias valor: valor.text
    property alias analise: analise.text

    Item {
        id: row
        width: parent.width
        height: title.height + subtitle.height + valor.height + analise.height

        Text {
            id: title
            text: ""
            color: titleColor
            font.bold: true
            font.pixelSize: titleFontSize
            horizontalAlignment: horizontalAlignmentText
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: subtitle
            text: ""
            color: subtitleColor
            font.bold: true
            font.pixelSize: subtitleFontSize
            horizontalAlignment: horizontalAlignmentText
            anchors.right: title.right
            anchors.top: title.bottom
        }

        Text {
            id: valor
            text: ""
            color: textColor
            font.bold: true
            font.pixelSize: textFontSize
            horizontalAlignment: horizontalAlignmentText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: subtitle.bottom
        }

        Text {
            id: analise
            text: ""
            color: detailColor
            font.pixelSize: textFontSize
            horizontalAlignment: horizontalAlignmentText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: valor.bottom
        }
    }

}
