import QtQuick 2.0

Item {
    id: customButtom
    height: root.dp(40)
    width: root.dp(100)

    property color btnBorderColor: contrastColor1
    property color btnColor: contrastColor3
    property color btnTextColor: btnBorderColor

    property var btnBorderWidth: root.dp(2)
    property var btnRadius: root.dp(30)
    property var btnText: ""
    property var btnTextSize: root.sp(12)

    Rectangle {
        anchors.fill: parent
        z: -1
        color: btnColor
        radius: btnRadius
    }

    CustomBorderRec {
            commonBorder: true
            commonBorderWidth: btnBorderWidth
            borderColor: btnBorderColor
            radius: btnRadius
    }

    Text {
        id: btnTextField
        text: btnText
        color: btnTextColor
        font.pixelSize: btnTextSize
        anchors.centerIn: parent
    }
}
