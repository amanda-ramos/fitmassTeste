import QtQuick 2.11

Item {
    width: parent.width
    height: root.dp(300)

    property alias weight: weightTxt.text
    property alias leanMass: musclesTxt.text
    property alias bodyFat: bodyFatTxt.text
    property var dateCard: "1800-01-01T00:00:00.000"

    Rectangle {
        id: content
        width: parent.width
        height: root.dp(265)
        color: cardColor

        Item {
            width: parent.width / 3
            height: iconWeight.height + weightTxt.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            Rectangle {
                anchors.fill: parent
                color: contrastColor2
            }

            Image {
                id: iconWeight
                height: root.dp(80)
                width: height
                source: "../../assets/icon_weight.png"
                fillMode: Image.PreserveAspectFit
                anchors.bottom: weightTxt.top
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: weightTxt
                color: greenLight
                text: "teste"
                anchors.top: iconWeight.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                topPadding: root.dp(5)
                font.bold: true
            }
        }

        Item {
            width: parent.width / 3
            height: parent.height
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: iconMuscle
                height: root.dp(80)
                width: height
                source: "../../assets/icon_muscle.png"
                fillMode: Image.PreserveAspectFit
                anchors.bottom: musclesTxt.top
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: musclesTxt
                color: greenLight
                text: leanMass
                anchors.top: iconMuscle.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                topPadding: root.dp(5)
                font.bold: true
            }
        }

        Item {
            width: parent.width / 3
            height: parent.height
            anchors.top: parent.top
            anchors.right: parent.right

            Image {
                id: iconBodyFat
                height: root.dp(80)
                width: height
                source: "../../assets/icon_body_fat.png"
                fillMode: Image.PreserveAspectFit
                anchors.bottom: bodyFatTxt.top
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: bodyFatTxt
                color: greenLight
                text: bodyFat
                anchors.top: iconBodyFat.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                topPadding: root.dp(5)
                font.bold: true
            }
        }
    }

    Rectangle {
        id: footer
        height: root.dp(35)
        width: parent.width
        color: grayLight
        anchors.bottom: content.bottom

        Image {
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
            color: greenLight
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            rightPadding: dp(8)
        }
    }
}
