import QtQuick 2.9
import VPlayApps 1.0
import VPlayPlugins 1.0

import "../common"
import "../pages"

AppCard {
    id: card
    width: parent.width
    margin: dp(15)
    paper.radius: dp(5)

    property var weightCard
    property var musclesCard
    property var bodyFatCard
    property var dateCard
    property var wantedWeight



    MouseArea{
        anchors.fill: parent

        onClicked: {
            var meapage = measureView.createObject();
                meapage.weightValor =  weightCard;
                meapage.muscleValor = musclesCard;
                meapage.bodyFatValor = bodyFatCard;
                meapage.dateValor = dateCard;
                meapage.wantedWeightValor = wantedWeight;

                fitmassStack.push(meapage);
        }
    }

    media: Rectangle {
        width: parent.width
        height: width / 2
        color: "#d6d6d6"

        Row {
            anchors.fill: parent

            Column {
                width: parent.width / 3
                height: parent.height
                anchors.left: parent.left

                AppImage {
                    id: iconWeight
                    height: dp(80)
                    width: height
                    source: "../../assets/icon_weight.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    id: weightTxt
                    color: verdeMassa
                    text: ""
                    anchors.top: iconWeight.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    topPadding: dp(5)
                    font.bold: true
                }
            }

            Column {
                width: parent.width / 3
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter

                AppImage {
                    id: iconMuscle
                    height: dp(80)
                    width: height
                    source: "../../assets/icon_muscle.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    id: musclesTxt
                    color: verdeMassa
                    text: ""
                    anchors.top: iconMuscle.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    topPadding: dp(5)
                    font.bold: true
                }
            }

            Column {
                width: parent.width / 3
                height: parent.height
                anchors.right: parent.right

                AppImage {
                    id: iconBodyFat
                    height: dp(80)
                    width: height
                    source: "../../assets/icon_body_fat.png"
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    id: bodyFatTxt
                    color: verdeMassa
                    text: ""
                    anchors.top: iconBodyFat.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    topPadding: dp(5)
                    font.bold: true
                }
            }
        }
    }

    actions: Row {
        width: parent.width

        Rectangle {
            color: "transparent"
            width: parent.width
            height: dateTxt.height + 10

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
                text: dateCard
                color: "#b4b4b4"
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                rightPadding: dp(6)
            }
        }
    }

    FirebaseDatabase {
        id: databaseFitmass

        config: FirebaseConfig {
             //get these values from the firebase console
             projectId: "fitmass-2018"
             databaseUrl: "https://fitmassapp.firebaseio.com/"

             //platform dependent - get these values from the google-services.json / GoogleService-info.plist
             apiKey:        Qt.platform.os === "android" ? "AIzaSyBh6Kb12xUnOsQDTP2XEbSKtuGsBfmCyic" : "AIzaSyBh6Kb12xUnOsQDTP2XEbSKtuGsBfmCyic"
             applicationId: Qt.platform.os === "android" ? "1:519505351771:android:28365556727f1ea3" : "1:519505351771:ios:28365556727f1ea3"
           }

        onReadCompleted: {
                if(success) {
                    console.debug("CARD - Read value " +  value + " for key " + key)

                    weightTxt.text = value.weight + " kg"
                    musclesTxt.text = value.leanMass + " kg"
                    bodyFatTxt.text = value.bodyFat + " kg"

                } else {
                    console.debug("CARD - Error with message: "  + value)
                    nativeUtils.displayAlertDialog("Error!", value, "OK")
                }
            } // Card
    }

    Component.onCompleted: {
        databaseFitmass.getValue(keyUser + keyMeasure);
    }
}
