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

    Item {
        id: content
        width: parent.width
        height: parent.height

        Item {
            id: spinMuscle
            anchors.fill: parent

            Item {
                id: tabIcons
                width: parent.width
                height: root.dp(40)
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                Item {
                    id: secao
                    width: parent.width / 2
                    height: parent.height
                    anchors.left: parent.left
                    anchors.top: parent.top

                    Rectangle {
                        id: secaoRec
                        anchors.fill: parent
                        color: grayLight

                        Rectangle {
                            id: secaoGreenRec
                            width: parent.width
                            height: root.dp(4)
                            color: greenDark
                            anchors.bottom: secaoRec.bottom
                        }

                        Text {
                            anchors.centerIn: parent
                            color: white
                            text: "Medidas por seção muscular"
                            font.pixelSize: root.sp(12)
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                medidaPorSecao.visible = true
                                medidaCompleta.visible = false
                                secaoRec.color = grayLight
                                secaoGreenRec.visible = true
                                completaGreenRec.visible = false
                                completaRec.color = bgColor
                            }
                        }
                    }
                }

                Item {
                    id: completa
                    width: parent.width / 2
                    height: parent.height
                    anchors.right: parent.right
                    anchors.top: parent.top

                    Rectangle {
                        id: completaRec
                        anchors.fill: parent
                        color: bgColor

                        Rectangle {
                            id: completaGreenRec
                            width: parent.width
                            height: root.dp(4)
                            color: greenDark
                            anchors.bottom: completaRec.bottom
                            visible: false
                        }

                        Text {
                            anchors.centerIn: parent
                            color: white
                            text: "Medidas completas"
                            font.pixelSize: root.sp(12)
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                medidaPorSecao.visible = false
                                medidaCompleta.visible = true
                                secaoRec.color = bgColor
                                secaoGreenRec.visible = false
                                completaGreenRec.visible = true
                                completaRec.color = grayLight
                            }
                        }
                    }
            }
        }

            Item {
                id: medidaPorSecao
                height: parent.height - tabIcons.height
                width: parent.width
                anchors.top: tabIcons.bottom

                MeasureAntropoGraphic {
                    measureHeight: parent.height
                    measureWidth: parent.width
                }
            }

            Item {
                id: medidaCompleta
                height: parent.height - tabIcons.height
                width: parent.width
                anchors.top: tabIcons.bottom
                visible: false

                MeasureAntropo {
                    measureHeight: parent.height
                    measureWidth: parent.width
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
