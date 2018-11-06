
import VPlayApps 1.0
import QtQuick 2.11
import QtCharts 2.2

import "../common"
import "../pages"

Page {
    id: antropoPage
    title: "Medidas do Corpo"
    height: screenSizeY
    width: screenSizeX
    backgroundColor: bgColor

    property var line
    property bool dateTo: false
    property bool dateFrom: false
    property var muscles: ["Bíceps", "Antebraço", "Peitoral", "Cintura", "Quadril", "Coxa", "Panturrilha", "Relação Cintura-Quadril"]
    property var diaHoje: Qt.formatDate(new Date(), "dd")
    property int mesPassado: parseInt(Qt.formatDate(new Date(), "MM"))-1
    property var anoHoje: Qt.formatDate(new Date(), "yyyy")


    property var dateMin1: "2000-01-01"
    property var dateMin2: "2000-01-01"
    property var dateMax1: new Date()
    property var dateMax2: new Date()

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
                height: root.dp(20)
                width: parent.width
                anchors.top: parent.top
                color: bgColor
            }

            Item {
                id: muscleSelect
                width: parent.width
                height: root.dp(70)
                anchors.top: spacer.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                CustomComboBox {
                    id: muscleSelectUser
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    cbTextTitle: ""
                    cbTitleColor: white
                    cbTextColor: greenLight
                    cbColor: grayLight
                    cbRadius: root.dp(30)
                    cbTextSelected: muscles[0]

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            muscleSelectUser.forceActiveFocus()
                            nativeUtils.displayAlertSheet("Selecione o grupo muscular", muscles, true)
                        }
                    }
                }
            }

            Item {
                id: spacer4
                width: dates.width
                height: root.dp(35)
                anchors.top: muscleSelect.bottom
                anchors.left: muscleSelect.left
            }

            Item {
                id: dates
                width: parent.width - dp(40)
                height: dateFromSelect.height
                anchors.top: spacer4.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                Item {
                    width: parent.width / 2
                    height: parent.height
                    anchors.left: parent.left

                    Text {
                        text: "De: "
                        color: white
                        anchors.bottom: dateFromSelect.top
                        anchors.left: dateFromSelect.left
                    }

                    CustomButtom {
                        id: dateFromSelect
                        btnColor: grayLight
                        btnBorderColor: grayLight
                        btnRadius: root.dp(30)
                        btnText: diaHoje + "/" + mesPassado + "/" + anoHoje
                        btnBorderWidth: root.dp(1)
                        btnTextColor: greenLight
                        btnTextSize: root.sp(14)

                        anchors.horizontalCenter: parent.horizontalCenter

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                dateFrom = true;
                                nativeUtils.displayDatePicker(Qt.formatDate(Date.fromLocaleString(Qt.locale(), dateFromSelect.btnText, "dd/MM/yyyy"), "yyyy-MM-dd"), "2000-01-01", dateMax1)
                            }
                        }
                    }
                }

                Item {
                    width: parent.width / 2
                    height: parent.height
                    anchors.right: parent.right

                    Text {
                        text: "Até: "
                        color: white
                        anchors.bottom: dateToSelect.top
                        anchors.left: dateToSelect.left
                    }

                    CustomButtom {
                        id: dateToSelect
                        btnColor: grayLight
                        btnBorderColor: grayLight
                        btnRadius: root.dp(30)
                        btnText: Qt.formatDate(new Date(), "dd/MM/yyyy")
                        btnBorderWidth: root.dp(1)
                        btnTextColor: greenLight
                        btnTextSize: root.sp(14)

                        anchors.horizontalCenter: parent.horizontalCenter

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                dateTo = true;
                                nativeUtils.displayDatePicker(Qt.formatDate(Date.fromLocaleString(Qt.locale(), dateToSelect.btnText, "dd/MM/yyyy"), "yyyy-MM-dd"), "2000-01-01", dateMax2)
                            }
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

                Item {
                    id: grafico
                    width: parent.width - dp(40)
                    height: width * 2 / 3
                    anchors.horizontalCenter: parent.horizontalCenter

                    ChartView {
                        id: muscleChart
                        title: ""
                        width: parent.width
                        height: parent.height
                        antialiasing: true
                        backgroundColor: bgColor

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
                            color: greenDark
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
                            color: contrastColor3
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
                    height: root.dp(20)
                    width: parent.width
                    anchors.top: parent.top
                    anchors.left: parent.left

                    Text {
                        id: txt1
                        width: parent.width / 2
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter

                        text: "esquerdo"
                        color: greenDark
                        font.bold: true
                        topPadding: root.dp(2)
                        font.pixelSize: root.sp(16)
                    }

                    Text {
                        id: txt2
                        width: parent.width / 2
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "direito"
                        color: contrastColor3
                        font.bold: true
                        font.pixelSize: root.sp(16)
                    }
                }

                Item {
                    id: valueNowItem
                    height: root.dp(20)
                    width: parent.width
                    anchors.top: txtItem.bottom
                    anchors.left: parent.left

                    Text {
                        id: valueNowLeft
                        width: parent.width / 2
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter

                        text: "Atual: 27 cm"
                        color: greenDark
                        font.pixelSize: root.sp(14)
                    }

                    Text {
                        id: valueNowRight
                        width: parent.width / 2
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "Atual: 29 cm"
                        color: contrastColor3
                        font.pixelSize: root.sp(14)
                    }
                }

                Item {
                    id: valueMaxItem
                    height: root.dp(20)
                    width: parent.width
                    anchors.top: valueNowItem.bottom
                    anchors.left: parent.left

                    Text {
                        id: valueMaxLeft
                        width: parent.width / 2
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter

                        text: "máx: 30 cm"
                        font.pixelSize: root.sp(12)
                        color: white
                    }

                    Text {
                        id: valueMaxRight
                        width: parent.width / 2
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "máx: 29 cm"
                        font.pixelSize: root.sp(12)
                        color: white
                    }
                }

                Item {
                    id: valueMinItem
                    height: root.dp(20)
                    width: parent.width
                    anchors.top: valueMaxItem.bottom
                    anchors.left: parent.left

                    Text {
                        id: valueMinLeft
                        width: parent.width / 2
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter

                        text: "min: 26 cm"
                        font.pixelSize: root.sp(12)
                        color: white
                    }

                    Text {
                        id: valueMinRight
                        width: parent.width / 2
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "min: 24 cm"
                        font.pixelSize: root.sp(12)
                        color: white
                    }
                }

                Item {
                    id: valueMedItem
                    height: root.dp(20)
                    width: parent.width
                    anchors.top: valueMinItem.bottom
                    anchors.left: parent.left

                    Text {
                        id: valueMedLeft
                        width: parent.width / 2
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter

                        text: "méd: 28.7 cm"
                        font.pixelSize: root.sp(12)
                        color: white
                    }

                    Text {
                        id: valueMedRight
                        width: parent.width / 2
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "méd: 26.3 cm"
                        font.pixelSize: root.sp(12)
                        color: white
                    }
                }
            }
        }
    }

    Connections {
        target: nativeUtils

        onAlertSheetFinished: {
            if(index>=0)
                muscleSelectUser.cbTextSelected = muscles[index]
        }

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
                    dateToSelect.btnText = pickedDate;
                }
                if(dateFrom){
                    dateFrom = false;
                    dateFromSelect.btnText = pickedDate;
                }
            }
        }
    }

    }

    ScrollIndicator {
        flickable: scrollAntropoPage
    } // scroll indicator
}
