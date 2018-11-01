
import VPlayApps 1.0
import QtQuick 2.11
import QtCharts 2.2

import "../common"
import "../pages"

Page {
    id: antropoPage
    title: "Medidas do Corpo"
    height: 960
    width: 640

    property var line
    property bool dateTo: false
    property bool dateFrom: false
    property var muscles: ["Bíceps", "Antebraço", "Peitoral", "Cintura", "Quadril", "Coxa", "Panturrilha"]
    property var diaHoje: Qt.formatDate(new Date(), "dd")
    property int mesPassado: parseInt(Qt.formatDate(new Date(), "MM"))-1
    property var anoHoje: Qt.formatDate(new Date(), "yyyy")

    rightBarItem: NavigationBarRow {
        id: rightNavBarRowMeasure

        IconButtonBarItem {
            title: "Nova medida"
            icon: IconType.plus

            onClicked: {
              antropoStack.push(antropoNewView)
          }
        }
    }

    AppFlickable {
        id: scrollAntropoPage
        anchors.fill: parent
        contentHeight: content.height

        MouseArea {
            anchors.fill: parent
            onClicked: {
                scrollAntropoPage.forceActiveFocus()
            }
        }

    Item {
        id: content
        width: parent.width
        height: spacer.height + muscleSelect.height + spacer4.height + dates.height + graficoMuscle.height + spacer3.height + footer.height

        Item {
            id: spinMuscle
            anchors.fill: parent

            Rectangle {
                id: spacer
                height: dp(20)
                width: parent.width
                anchors.top: parent.top
            }

            Rectangle{
                id: muscleSelect
                width: parent.width - dp(40)
                height: dp(40)
                anchors.top: spacer.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"

                CustomBorderRec {
                        commonBorder: false
                        lBorderwidth: 0
                        rBorderwidth: 0
                        tBorderwidth: 0
                        bBorderwidth: 3
                        borderColor: "#4b4b4b"
                }

                Text {
                    id: muscleSelected
                    text: "Bíceps"
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                }

                Rectangle {
                    id: spacer2
                    width: dp(20)
                    height: parent.height
                    anchors.right: parent.right
                    anchors.top: parent.top
                    color: "transparent"
                }

                Image {
                    id: seta
                    source: "../../assets/seta.png"
                    width: dp(15)
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: spacer2.left
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        nativeUtils.displayAlertSheet("", muscles, true)
                    }
                    Connections {
                        target: nativeUtils

                        onAlertSheetFinished: {
                            muscleSelected.text = muscles[index]
                        }
                    }
                }
            }

            Item {
                id: spacer4
                width: dates.width
                height: dp(35)
                anchors.top: muscleSelect.bottom
                anchors.left: muscleSelect.left

                Text {
                    text: "De: "
                    color: "#b4b4b4"
                    anchors.bottom: parent.bottom
                    anchors.left: dateFromSelect.left
                }

                Text {
                    text: "Até: "
                    color: "#b4b4b4"
                    width: dateToSelect.width
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignLeft
                }
            }

            Item {
                id: dates
                width: parent.width - dp(40)
                height: dateFromSelected.height
                anchors.top: spacer4.bottom
                anchors.left: muscleSelect.left

            Rectangle {
                id: dateFromSelect
                width: parent.width / 2 - dp(20)
                height: dp(40)
                anchors.top: parent.top
                anchors.left: parent.left
                color: "white"

                CustomBorderRec {
                        commonBorder: false
                        lBorderwidth: 0
                        rBorderwidth: 0
                        tBorderwidth: 0
                        bBorderwidth: 3
                        borderColor: "#4b4b4b"
                }

                Text {
                    id: dateFromSelected
                    text: diaHoje + "/" + mesPassado + "/" + anoHoje
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "#b4b4b4"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        dateFrom = true;
                        nativeUtils.displayDatePicker(Qt.formatDate(Date.fromLocaleString(Qt.locale(), dateFromSelected.text, "dd/MM/yyyy"), "yyyy-MM-dd"), "2000-01-01", new Date())
                    }
                }
            }

            Rectangle {
                id: dateToSelect
                width: parent.width / 2 - dp(20)
                height: dp(40)
                anchors.top: parent.top
                anchors.right: parent.right
                color: "white"

                CustomBorderRec {
                        commonBorder: false
                        lBorderwidth: 0
                        rBorderwidth: 0
                        tBorderwidth: 0
                        bBorderwidth: 3
                        borderColor: "#4b4b4b"
                }

                Text {
                    id: dateToSelected
                    text: Qt.formatDate(new Date(), "dd/MM/yyyy")
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "#b4b4b4"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        dateTo = true;
                        nativeUtils.displayDatePicker(Qt.formatDate(Date.fromLocaleString(Qt.locale(), dateToSelected.text, "dd/MM/yyyy"), "yyyy-MM-dd"), "2000-01-01", new Date())
                    }
                }
            }

            }

            Rectangle {
                id: spacer3
                height: dp(3)
                width: parent.width
                anchors.top: dates.bottom
                anchors.left: parent.left
                color: "transparent"
            }

            Item {
                id: graficoMuscle
                width: parent.width
                height: grafico.height
                anchors.top: spacer3.bottom
                anchors.left: muscleSelect.left

                Item {
                    id: grafico
                    width: parent.width - dp(40)
                    height: width * 2 / 3

                    ChartView {
                        id: muscleChart
                        title: ""
                        width: parent.width
                        height: parent.height
                        antialiasing: true
                        backgroundColor: "white"

                        ValueAxis {
                            id: axisY1
                            min: 25
                            max: 31
                            labelsVisible: false
                            gridVisible: false
                            lineVisible: false
                        }

                        ValueAxis {
                            id: axisX1
                            min: 0
                            max: 3
                            labelsVisible: false
                            gridVisible: false
                            lineVisible: false
                        }

                        SplineSeries{
                            name: "esquerdo     "
                            width: dp(3)
                            color: amareloMassa
                            axisX: axisX1
                            axisY: axisY1

                            XYPoint { x: 0; y: 26 }
                            XYPoint { x: 1; y: 28 }
                            XYPoint { x: 2; y: 30 }
                            XYPoint { x: 3; y: 27 }
                        }

                        SplineSeries{
                            name: "direito"
                            width: dp(3)
                            color: verdeMassa
                            axisX: axisX1
                            axisY: axisY1

                            XYPoint { x: 0; y: 27 }
                            XYPoint { x: 1; y: 30 }
                            XYPoint { x: 2; y: 28 }
                            XYPoint { x: 3; y: 26 }
                        }
                    }
                }
            }

            Item {
                id: footer
                width: muscleSelect.width
                height: txtItem.height + valueNowItem.height + valueMaxItem.height + valueMinItem.height + valueMedItem.height

                anchors.top: graficoMuscle.bottom
                anchors.left: muscleSelect.left

                Item {
                    id: txtItem
                    height: muscleSelect.height - dp(5)
                    width: parent.width
                    anchors.top: parent.top
                    anchors.left: parent.left

                    Text {
                        id: txt1
                        width: parent.width / 2
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter

                        text: "esquerdo"
                        color: amareloMassa
                        font.bold: true
                        topPadding: dp(5)
                    }

                    Text {
                        id: txt2
                        width: parent.width / 2
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "direito"
                        color: verdeMassa
                        font.bold: true
                        topPadding: dp(5)
                    }
                }

                Item {
                    id: valueNowItem
                    height: muscleSelect.height - dp(5)
                    width: parent.width
                    anchors.top: txtItem.bottom
                    anchors.left: parent.left

                    Text {
                        id: valueNowLeft
                        width: parent.width / 2
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter

                        text: "Atual: 27 cm"
                        color: amareloMassa
                    }

                    Text {
                        id: valueNowRight
                        width: parent.width / 2
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "Atual: 29 cm"
                        color: verdeMassa
                    }
                }

                Item {
                    id: valueMaxItem
                    height: muscleSelect.height - dp(5)
                    width: parent.width
                    anchors.top: valueNowItem.bottom
                    anchors.left: parent.left

                    Text {
                        id: valueMaxLeft
                        width: parent.width / 2
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter

                        text: "máx: 30 cm"
                        font.pointSize: sp(4)
                    }

                    Text {
                        id: valueMaxRight
                        width: parent.width / 2
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "máx: 29 cm"
                        font.pointSize: sp(4)
                    }
                }

                Item {
                    id: valueMinItem
                    height: muscleSelect.height - dp(5)
                    width: parent.width
                    anchors.top: valueMaxItem.bottom
                    anchors.left: parent.left

                    Text {
                        id: valueMinLeft
                        width: parent.width / 2
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter

                        text: "min: 26 cm"
                        font.pointSize: sp(4)
                    }

                    Text {
                        id: valueMinRight
                        width: parent.width / 2
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "min: 24 cm"
                        font.pointSize: sp(4)
                    }
                }

                Item {
                    id: valueMedItem
                    height: muscleSelect.height - dp(5)
                    width: parent.width
                    anchors.top: valueMinItem.bottom
                    anchors.left: parent.left

                    Text {
                        id: valueMedLeft
                        width: parent.width / 2
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter

                        text: "méd: 28.7 cm"
                        font.pointSize: sp(4)
                    }

                    Text {
                        id: valueMedRight
                        width: parent.width / 2
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "méd: 26.3 cm"
                        font.pointSize: sp(4)
                    }
                }
            }
        }
    }

    Connections {
        target: nativeUtils

        onDatePickerFinished: {
            var pickedDate
            if(accepted){

                var hour = ""
                var dateStr = ""
                var timeShift = ""

                dateStr = date.toLocaleTimeString(Qt.locale("pt_BR"))
                hour = parseInt(dateStr.split(":")[0])
                timeShift = Qt.formatDateTime(date, "t")

                if (hour === 00) {
                    pickedDate = Qt.formatDate(date, "dd/MM/yyyy")
                } else {
                    Date.prototype.addHours = function (h) {
                        this.setTime(this.getTime() + (h * 60 * 60 * 1000))
                        return this
                    }

                    pickedDate = Qt.formatDate(date.addHours(24 - hour), "dd/MM/yyyy")
                }

                if(dateTo){
                    dateTo = false;
                    dateToSelected.text = pickedDate;
                }
                if(dateFrom){
                    dateFrom = false;
                    dateFromSelected.text = pickedDate;
                }
            }
        }
    }

    }

    ScrollIndicator {
        flickable: scrollAntropoPage
    } // scroll indicator
}
