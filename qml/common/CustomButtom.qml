import QtQuick 2.0

Item {
    id: customButtom
    height: root.dp(40)
    width: root.dp(100)

    property color btnBorderColor: "#ff00ff"
    property color btnColor: "#00dbee"

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
        font.pointSize: root.sp(4)
        anchors.centerIn: parent
    }
}
