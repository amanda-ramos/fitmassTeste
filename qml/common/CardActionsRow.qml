import VPlayApps 1.0
import QtQuick 2.9

Item {

    property var dateCard: "1800-01-01T00:00:00.000"

    id: actionsRow
    width: parent.width
    anchors.top: mediaRec.bottom

    Rectangle {
        id: roundRect
        color: cardColor
        width: parent.width
        height: dateTxt.height + 15
        anchors.bottom: parent.top
        radius: dp(5)
        opacity: 1

        Item {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: roundRect.height //- squareRect.height

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
                width: dp(6)
                height: parent.height
                anchors.right: dateTxt.left
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                id: dateTxt
                text: Qt.formatDate(dateCard, "dd/MM/yyyy")
                color: grayLight2
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                rightPadding: dp(8)
            }
        }
    }
}
