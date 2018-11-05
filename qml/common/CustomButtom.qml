import QtQuick 2.0

Item {
    id: customButtom
    height: root.dp(40)
    width: root.dp(100)

    property color btnBorderColor: contrastColor1
    property color btnColor: contrastColor3

    property var btnRadius: root.dp(30)
    property var btnText: ""

    Rectangle {
        anchors.fill: parent
        z: -1
        color: btnColor
        radius: btnRadius
    }

    CustomBorderRec {
            commonBorder: true
            commonBorderWidth: root.dp(2)
            borderColor: btnBorderColor
            radius: btnRadius
    }

    Text {
        id: btnTextField
        text: btnText
        color: btnBorderColor
        font.pixelSize: root.sp(12)
        anchors.centerIn: parent
    }
}
