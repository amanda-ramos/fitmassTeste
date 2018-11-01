import VPlayApps 1.0
import QtQuick 2.9
import VPlayPlugins 1.0

// This example shows how items can be dynamically added to and removed from
// a ListModel, and how these list modifications can be animated.

Page {
    id: listViewPage
    title: "List View Teste"

    property int qtdeMedida: 0
    property var weightDB: ""
    property var bodyFatDB: ""
    property var leanMassDB: ""
    property var dateDB: ""

    ListView {
        width: parent.width
        height: parent.height

        model: cardModel()
        delegate:
            AppCard {
            id: cardView
            width: parent.width
            margin: dp(15)
            paper.radius: dp(5)

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
                            text: weight
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
                            text: leanMass
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
                            text: bodyFat
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
                        text: date
                        color: "#b4b4b4"
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        rightPadding: dp(6)
                    }
                }
            }
        }

    }

    function cardModel () {
        console.log("cardModel1");
        card = true;
        databaseFitmass.getValue(keyUser);

        console.log("após leitura");
    }

    function cardModel2 (parent){

        console.log("cardModel2")
        console.log(qtdeMedida)
        var s = 'import QtQuick 2.0; ListModel {\n';
        for (var i = 0; i < qtdeMedida; i++){
            var s2 = "ListElement {weight: \"" + weightDB + "\"; leanMass: \"" + leanMassDB + "\"; bodyFat: \"" + bodyFatDB + "\"; date: \"" + dateDB + "\" }\n";
            s += s2;
        }

        s += "}\n";
        console.log(s);

        return Qt.createQmlObject(s, parent, "mainModel");
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
            console.log("Leitura")
            if(card){
                if(success) {
                    console.debug("Read value " +  value + " for key " + key)

                    weightDB = value.weight + " kg"
                    leanMassDB = value.leanMass + " kg"
                    bodyFatDB = value.bodyFat + " kg"
                    dateDB = value.date

                    qtdeMedida = 3;//value.totalMeasure

                    cardModel2(listViewPage);

//                    weightTxt.text = value.weight + " kg"
//                    musclesTxt.text = value.leanMass + " kg"
//                    bodyFatTxt.text = value.bodyFat + " kg"

                } else {
                    console.debug("Error with message: "  + value)
                    nativeUtils.displayAlertDialog("Error!", value, "OK")
                }
                card = false;
            } // Card
        }
    }
}
