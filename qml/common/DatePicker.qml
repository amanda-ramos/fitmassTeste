import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2
import VPlayPlugins 1.0

Item{
    DatePickerDialog {
        id: tDialog
        titleText: "Date of birth"
        onAccepted: callbackFunction()
    }

    function launchDialog() {
        tDialog.open();
    }

    function launchDialogToToday() {
        var d = new Date();
        tDialog.year = d.getFullYear();
        tDialog.month = d.getMonth();
        tDialog.day = d.getDate();
        tDialog.open();
    }

    function callbackFunction() {
        result.text = tDialog.year + " " + tDialog.month + " " + tDialog.day
    }
}



//Frame {
//        id: frame
//        padding: 0
//        anchors.centerIn: parent
//        implicitHeight: yearTumbler.height
//        implicitWidth: daysTumbler.width + monthsTumbler.width + yearTumbler.width + dp(30)

//        property var anoAtual: 2018

//        Row {
//            id: row

//            Tumbler {
//                id: daysTumbler
//                model: daysTumblerModel ()
//                delegate: delegateComponent
//                implicitWidth: dp(50)
//                implicitHeight: visibleItemCount * 80

//                function daysTumblerModel() {
//                    var days = [];
//                    var i = 0;
//                    for (var day = 1; day <= 31; day++) {
//                            days[i] = day;
//                            i++;
//                        }
//                    return days;
//                }
//            }

//            Tumbler {
//                id: monthsTumbler
//                model: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
//                delegate: delegateComponent
//                implicitWidth: dp(50)
//                implicitHeight: visibleItemCount * 80
//            }

//            Tumbler {
//                id: yearTumbler
//                model: yearTumblerModel()
//                delegate: delegateComponent
//                implicitWidth: dp(100)
//                implicitHeight: visibleItemCount * 80

//                function yearTumblerModel() {
//                    var years = [];
//                    var i = 0;
//                    for (var year = anoAtual - 80; year <= anoAtual; year++) {
//                            years[i] = year;
//                            i++;
//                        }
//                    return years;
//                }
//            }
//        }
//    }
