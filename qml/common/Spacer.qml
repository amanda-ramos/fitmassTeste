import QtQuick 2.0

Item {
    width: parent.width
    height: rec1.height

    property alias altura: rec1.height
    property var colorRec: "transparent"

    Rectangle {
        id: rec1
        width: parent.width
        height: dp(20)
        color: colorRec
    }

}
