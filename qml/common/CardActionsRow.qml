import VPlayApps 1.0
import QtQuick 2.9

Item {

    property var dateCard: "1800-01-01T00:00:00.000"

    id: actionsRow
    width: parent.width
    anchors.bottom: mediaRec.top

        Item {
            width: iconCalendar.width + space.width + dateTxt.width
            height: dateTxt.height + root.dp(15)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top

            AppImage {
                id: iconCalendar
                height: dateTxt.height * 3 / 4
                source: "../../assets/icon_calendar.png"
                fillMode: Image.PreserveAspectFit
                anchors.right: space.left
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                id: space
                color: "transparent"
                width: root.dp(6)
                height: parent.height
                anchors.right: dateTxt.left
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                id: dateTxt
                text: Qt.formatDate(dateCard, "dd/MM/yyyy")
                color: grayLight2
                font.pixelSize: root.sp(12)
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                rightPadding: root.dp(8)
            }
    }
}
