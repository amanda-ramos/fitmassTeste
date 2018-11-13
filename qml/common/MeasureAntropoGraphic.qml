import QtQuick 2.11
import VPlayApps 1.0
import QtCharts 2.2

Item {
    id: measure
    height: measureHeight
    width: measureWidth

    property real measureHeight: 960
    property real measureWidth: 640

    AppFlickable {
        id: scrollAntropoPageSecao
        anchors.fill: parent
        contentHeight: content.height

        MouseArea {
            anchors.fill: parent
            onClicked: {
                scrollAntropoPageSecao.forceActiveFocus()
            }
        }

        Rectangle {
            id: spacer
            height: root.dp(5)
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

                    Connections {
                        target: nativeUtils

                        onAlertSheetFinished: {
                            if(index>=0) {

                                muscleSelectUser.cbTextSelected = muscles[index]

                                if(index === 0 || index === 1 || index === 5 || index === 6){
                                    leftSide.visible = true
                                    rightSide.visible = true
                                    central.visible = false
                                    direitoesquerdo.visible = true
                                    centro.visible = false
                                } else {
                                    leftSide.visible = false
                                    rightSide.visible = false
                                    central.visible = true
                                    direitoesquerdo.visible = false
                                    centro.visible = true
                                }
                            }
                        }
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
                width: parent.width - dp(10)
                height: width * 2 / 3
                anchors.horizontalCenter: parent.horizontalCenter

                ChartView {
                    id: muscleChart
                    title: ""
                    width: parent.width
                    height: parent.height
                    antialiasing: true
                    backgroundColor: bgColor
                    legend.font.pixelSize: root.sp(14)
                    legend.labelColor: white                    

                    ValueAxis {
                        id: axisY1
                        min: 25
                        max: 31
                        labelsVisible: true
                        gridVisible: false
                        lineVisible: false
                        tickCount: 3
                        labelsColor: grayLight
                        labelsFont.pixelSize: root.sp(12)
                        labelFormat: "%d"
                    }

                    DateTimeAxis {
                        id: axisX1
                        format: "dd/MM"
                        min: Date.fromLocaleString(locale, "09/11", "dd/MM")
                        max: Date.fromLocaleString(locale, "12/11", "dd/MM")
                        labelsVisible: true
                        gridVisible: false
                        lineVisible: false
                        tickCount: 4
                        labelsColor: grayLight
                        labelsFont.pixelSize: root.sp(12)
                    }

                    SplineSeries {
                        id: leftSide
                        width: root.dp(3)
                        color: greenDark
                        name: "esquerdo"
                        axisX: axisX1
                        axisY: axisY1
                        visible: true
                    }

                    SplineSeries {
                        id: rightSide
                        width: root.dp(3)
                        color: contrastColor3
                        name: "direito"
                        axisX: axisX1
                        axisY: axisY1
                        visible: true
                    }

                    SplineSeries {
                        id: central
                        width: root.dp(3)
                        color: contrastColor3
                        name: muscleSelectUser.cbTextSelected
                        axisX: axisX1
                        axisY: axisY1
                        visible: false
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
            id: direitoesquerdo
            anchors.fill: parent
            visible: true

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

        Item {
            id: centro
            anchors.fill: parent
            visible: false

            Item {
                id: txtCentroItem
                height: root.dp(20)
                width: parent.width
                anchors.top: parent.top
                anchors.left: parent.left

                Text {
                    id: txtCentro1
                    width: parent.width
                    anchors.left: parent.left
                    horizontalAlignment: Text.AlignHCenter

                    text: muscleSelectUser.cbTextSelected
                    color: contrastColor3
                    font.bold: true
                    topPadding: root.dp(2)
                    font.pixelSize: root.sp(16)
                }
            }

            Item {
                id: valueNowCentroItem
                height: root.dp(20)
                width: parent.width
                anchors.top: txtCentroItem.bottom
                anchors.left: parent.left

                Text {
                    id: valueNow
                    width: parent.width
                    anchors.right: parent.right
                    horizontalAlignment: Text.AlignHCenter

                    text: "Atual: 29 cm"
                    color: contrastColor3
                    font.pixelSize: root.sp(14)
                }
            }

            Item {
                id: valueMaxCentroItem
                height: root.dp(20)
                width: parent.width
                anchors.top: valueNowCentroItem.bottom
                anchors.left: parent.left

                Text {
                    id: valueMax
                    width: parent.width
                    anchors.right: parent.right
                    horizontalAlignment: Text.AlignHCenter

                    text: "máx: 29 cm"
                    font.pixelSize: root.sp(12)
                    color: white
                }
            }

            Item {
                id: valueMinCentroItem
                height: root.dp(20)
                width: parent.width
                anchors.top: valueMaxCentroItem.bottom
                anchors.left: parent.left

                Text {
                    id: valueMin
                    width: parent.width
                    anchors.right: parent.right
                    horizontalAlignment: Text.AlignHCenter

                    text: "min: 24 cm"
                    font.pixelSize: root.sp(12)
                    color: white
                }
            }

            Item {
                id: valueMedCentroItem
                height: root.dp(20)
                width: parent.width
                anchors.top: valueMinCentroItem.bottom
                anchors.left: parent.left

                Text {
                    id: valueMed
                    width: parent.width
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

    ScrollIndicator {
        flickable: scrollAntropoPageSecao
    } // scroll indicator

    Component.onCompleted: {

        leftSide.append(Date.fromLocaleString(locale, "09/11", "dd/MM"), 27)
        leftSide.append(Date.fromLocaleString(locale, "10/11", "dd/MM"), 30)
        leftSide.append(Date.fromLocaleString(locale, "11/11", "dd/MM"), 28)
        leftSide.append(Date.fromLocaleString(locale, "12/11", "dd/MM"), 26)

        rightSide.append(Date.fromLocaleString(locale, "09/11", "dd/MM"), 26)
        rightSide.append(Date.fromLocaleString(locale, "10/11", "dd/MM"), 28)
        rightSide.append(Date.fromLocaleString(locale, "11/11", "dd/MM"), 30)
        rightSide.append(Date.fromLocaleString(locale, "12/11", "dd/MM"), 27)

        central.append(Date.fromLocaleString(locale, "09/11", "dd/MM"), 26)
        central.append(Date.fromLocaleString(locale, "10/11", "dd/MM"), 28)
        central.append(Date.fromLocaleString(locale, "11/11", "dd/MM"), 30)
        central.append(Date.fromLocaleString(locale, "12/11", "dd/MM"), 27)
    }
}
