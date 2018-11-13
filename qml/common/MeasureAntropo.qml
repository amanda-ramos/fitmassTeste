import QtQuick 2.11
import VPlayApps 1.0

Item {
    id: measure
    height: measureHeight
    width: measureWidth

    property real measureHeight: 960
    property real measureWidth: 640
    property var titleTextSize: root.sp(16)
    property var textSize: root.sp(14)
    property color titleColor: greenDark
    property color textColor: white
    property bool dateAntropoComplete: false

    property string bicepsDireito: "28"
    property string bicepsEsquerdo: "30"
    property string antebracoDireito: "13"
    property string antebracoEsquerdo: "15"
    property string peitoral: "45"
    property string cintura: "62"
    property string quadril: "88"
    property string coxaDireita: "45"
    property string coxaEsquerda: "46"
    property string panturrilhaDireita: "33"
    property string panturrilhaEsquerda: "33"
    property string relacaoCinturaQuadril: "1.05"

    AppFlickable {
        id: scrollAntropoPageCompleta
        anchors.fill: parent
        contentHeight: spacer1.height + dates.height + content.height

        MouseArea {
            anchors.fill: parent
            onClicked: {
                scrollAntropoPageCompleta.forceActiveFocus()
            }
        }

    Item {
        id: spacer1
        width: parent.width
        height: root.dp(20)
        anchors.top: parent.top
    }

    Item {
        id: dates
        width: parent.width - root.dp(40)
        height: dateSelect.height
        anchors.top: spacer1.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        Item {
            width: parent.width
            height: parent.height
            anchors.left: parent.left

            Text {
                text: "Data: "
                color: white
                anchors.verticalCenter: dateSelect.verticalCenter
                anchors.left: parent.left
                font.pixelSize: root.sp(12)
            }

            CustomButtom {
                id: dateSelect
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
                        dateAntropoComplete = true
                        nativeUtils.displayDatePicker(Qt.formatDate(Date.fromLocaleString(Qt.locale(), dateSelect.btnText, "dd/MM/yyyy"), "yyyy-MM-dd"), "2000-01-01", new Date())
                    }
                }
            }
        }
    }

    Item {
        id: content
        height: root.dp(490) + root.dp(30)
        width: parent.width
        anchors.top: dates.bottom
        anchors.left: parent.left
        visible: true

        Item {
            id: bicepsItem
            width: parent.width - root.dp(120)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            height: root.dp(90)

            Text {
                id: bicepsTitle
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Bíceps"
                font.pixelSize: titleTextSize
                color: titleColor
                bottomPadding: root.dp(5)
                topPadding: root.dp(20)
            }

            CustomButtom {
                btnBorderColor: grayLight
                btnColor: bgColor
                anchors.right: parent.right
                anchors.top: bicepsTitle.bottom

                Item {
                    id: rightBicepsTxt
                    width: rightBicepsTxt1.width + rightBicepsTxt2.width
                    height: rightBicepsTxt1.height
                    anchors.centerIn: parent

                    Text {
                        id: rightBicepsTxt1
                        text: qsTr("D: ")
                        font.pixelSize:textSize
                        color: titleColor
                        anchors.left: rightBicepsTxt.left
                    }

                    Text {
                        id: rightBicepsTxt2
                        text: qsTr(bicepsDireito + " cm")
                        font.pixelSize: textSize
                        color: textColor
                        anchors.left: rightBicepsTxt1.right
                    }
                }
            }

            CustomButtom {
                btnBorderColor: grayLight
                btnColor: bgColor
                anchors.left: parent.left
                anchors.top: bicepsTitle.bottom

                Item {
                    id: leftBicepsTxt
                    width: leftBicepsTxt1.width + leftBicepsTxt2.width
                    height: leftBicepsTxt1.height
                    anchors.centerIn: parent

                    Text {
                        id: leftBicepsTxt1
                        text: qsTr("E: ")
                        font.pixelSize: textSize
                        color: titleColor
                        anchors.left: leftBicepsTxt.left
                    }

                    Text {
                        id: leftBicepsTxt2
                        text: qsTr(bicepsEsquerdo + " cm")
                        font.pixelSize: textSize
                        color: textColor
                        anchors.left: leftBicepsTxt1.right
                    }
                }
            }
        }  // biceps

        Item {
            id: antebracoItem
            width: parent.width - root.dp(120)
            height: root.dp(70)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: bicepsItem.bottom

        Text {
            id: antebracoTitle
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Antebraço"
            font.pixelSize: titleTextSize
            color: titleColor
            bottomPadding: root.dp(5)
        }

        CustomButtom {
            btnBorderColor: grayLight
            btnColor: bgColor
            anchors.right: parent.right
            anchors.top: antebracoTitle.bottom

            Item {
                id: rightAntebracoTxt
                width: rightAntebracoTxt1.width + rightAntebracoTxt2.width
                height: rightAntebracoTxt1.height
                anchors.centerIn: parent

                Text {
                    id: rightAntebracoTxt1
                    text: qsTr("D: ")
                    font.pixelSize:textSize
                    color: titleColor
                    anchors.left: rightAntebracoTxt.left
                }

                Text {
                    id: rightAntebracoTxt2
                    text: qsTr(antebracoDireito + " cm")
                    font.pixelSize: textSize
                    color: textColor
                    anchors.left: rightAntebracoTxt1.right
                }
            }
        }

        CustomButtom {
            btnBorderColor: grayLight
            btnColor: bgColor
            anchors.left: parent.left
            anchors.top: antebracoTitle.bottom

            Item {
                id: leftAntebracoTxt
                width: leftAntebracoTxt1.width + leftAntebracoTxt2.width
                height: leftAntebracoTxt1.height
                anchors.centerIn: parent

                Text {
                    id: leftAntebracoTxt1
                    text: qsTr("E: ")
                    font.pixelSize: textSize
                    color: titleColor
                    anchors.left: leftAntebracoTxt.left
                }

                Text {
                    id: leftAntebracoTxt2
                    text: qsTr(antebracoEsquerdo + " cm")
                    font.pixelSize: textSize
                    color: textColor
                    anchors.left: leftAntebracoTxt1.right
                }
            }
        }
        }  // antebraço

        Item {
            id: chestItem
            width: parent.width - root.dp(120)
            height: root.dp(70)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: antebracoItem.bottom

        Text {
            id: chestTitle
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Peitoral"
            font.pixelSize: titleTextSize
            color: titleColor
            bottomPadding: root.dp(5)
        }

        CustomButtom {
            btnBorderColor: grayLight
            btnColor: bgColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: chestTitle.bottom

            Item {
                id: chestTxt
                width: chestTxt1.width
                height: chestTxt1.height
                anchors.centerIn: parent

                Text {
                    id: chestTxt1
                    text: qsTr(peitoral + " cm")
                    font.pixelSize: textSize
                    color: textColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        }  // Peitoral

        Item {
            id: waistItem
            width: parent.width - root.dp(120)
            height: root.dp(70)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: chestItem.bottom

        Text {
            id: waistTitle
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Cintura"
            font.pixelSize: titleTextSize
            color: titleColor
            bottomPadding: root.dp(5)
        }

        CustomButtom {
            btnBorderColor: grayLight
            btnColor: bgColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: waistTitle.bottom

            Item {
                id: waistTxt
                width: waistTxt1.width
                height: waistTxt1.height
                anchors.centerIn: parent

                Text {
                    id: waistTxt1
                    text: qsTr(cintura + " cm")
                    font.pixelSize: textSize
                    color: textColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        }  // Cintura

        Item {
            id: hipItem
            width: parent.width - root.dp(120)
            height: root.dp(70)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: waistItem.bottom

        Text {
            id: hipTitle
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Quadril"
            font.pixelSize: titleTextSize
            color: titleColor
            bottomPadding: root.dp(5)
        }

        CustomButtom {
            btnBorderColor: grayLight
            btnColor: bgColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: hipTitle.bottom

            Item {
                id: hipTxt
                width: hipTxt1.width
                height: hipTxt1.height
                anchors.centerIn: parent

                Text {
                    id: hipTxt1
                    text: qsTr(quadril + " cm")
                    font.pixelSize: textSize
                    color: textColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        }  // Quadril

        Item {
            id: thighItem
            width: parent.width - root.dp(120)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: hipItem.bottom
            height: root.dp(70)

            Text {
                id: thighTitle
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Coxa"
                font.pixelSize: titleTextSize
                color: titleColor
                bottomPadding: root.dp(5)
            }

            CustomButtom {
                btnBorderColor: grayLight
                btnColor: bgColor
                anchors.right: parent.right
                anchors.top: thighTitle.bottom

                Item {
                    id: rightThighTxt
                    width: rightThighTxt1.width + rightThighTxt2.width
                    height: rightThighTxt1.height
                    anchors.centerIn: parent

                    Text {
                        id: rightThighTxt1
                        text: qsTr("D: ")
                        font.pixelSize:textSize
                        color: titleColor
                        anchors.left: rightThighTxt.left
                    }

                    Text {
                        id: rightThighTxt2
                        text: qsTr(coxaDireita + " cm")
                        font.pixelSize: textSize
                        color: textColor
                        anchors.left: rightThighTxt1.right
                    }
                }
            }

            CustomButtom {
                btnBorderColor: grayLight
                btnColor: bgColor
                anchors.left: parent.left
                anchors.top: thighTitle.bottom

                Item {
                    id: leftThighTxt
                    width: leftThighTxt1.width + leftThighTxt2.width
                    height: leftThighTxt1.height
                    anchors.centerIn: parent

                    Text {
                        id: leftThighTxt1
                        text: qsTr("E: ")
                        font.pixelSize: textSize
                        color: titleColor
                        anchors.left: leftThighTxt.left
                    }

                    Text {
                        id: leftThighTxt2
                        text: qsTr(coxaEsquerda + " cm")
                        font.pixelSize: textSize
                        color: textColor
                        anchors.left: leftThighTxt1.right
                    }
                }
            }
        }  // coxa

        Item {
            id: calfItem
            width: parent.width - root.dp(120)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: thighItem.bottom
            height: root.dp(70)

            Text {
                id: calfTitle
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Panturrilha"
                font.pixelSize: titleTextSize
                color: titleColor
                bottomPadding: root.dp(5)
            }

            CustomButtom {
                btnBorderColor: grayLight
                btnColor: bgColor
                anchors.right: parent.right
                anchors.top: calfTitle.bottom

                Item {
                    id: rightCalfTxt
                    width: rightCalfTxt1.width + rightCalfTxt2.width
                    height: rightCalfTxt1.height
                    anchors.centerIn: parent

                    Text {
                        id: rightCalfTxt1
                        text: qsTr("D: ")
                        font.pixelSize:textSize
                        color: titleColor
                        anchors.left: rightCalfTxt.left
                    }

                    Text {
                        id: rightCalfTxt2
                        text: qsTr(panturrilhaDireita + " cm")
                        font.pixelSize: textSize
                        color: textColor
                        anchors.left: rightCalfTxt1.right
                    }
                }
            }

            CustomButtom {
                btnBorderColor: grayLight
                btnColor: bgColor
                anchors.left: parent.left
                anchors.top: calfTitle.bottom

                Item {
                    id: leftCalfTxt
                    width: leftCalfTxt1.width + leftCalfTxt2.width
                    height: leftCalfTxt1.height
                    anchors.centerIn: parent

                    Text {
                        id: leftCalfTxt1
                        text: qsTr("E: ")
                        font.pixelSize: textSize
                        color: titleColor
                        anchors.left: leftCalfTxt.left
                    }

                    Text {
                        id: leftCalfTxt2
                        text: qsTr(panturrilhaEsquerda + " cm")
                        font.pixelSize: textSize
                        color: textColor
                        anchors.left: leftCalfTxt1.right
                    }
                }
            }
        }  // panturrilha
    }
    }
    
    ScrollIndicator {
        flickable: scrollAntropoPageCompleta
    } // scroll indicator

    Item {
        id: noContent
        anchors.fill: parent
        visible: false

        Text {
            id: noMeasure
            text: "Não há medidas nesta data."
            anchors.centerIn: parent
            color: white
            font.pixelSize: titleTextSize
        }
    }

    Connections {
        target: nativeUtils

        onDatePickerFinished: {
            if(dateAntropoComplete){
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

                    dateSelect.btnText = pickedDate;

                    if(content.visible){
                        content.visible = false
                        noContent.visible = true
                    } else {
                        content.visible = true
                        noContent.visible = false
                    }
                }
                dateAntropoComplete = false
            }
        }
    }
}
