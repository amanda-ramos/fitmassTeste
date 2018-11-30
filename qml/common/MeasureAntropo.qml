import QtQuick 2.11
import VPlayApps 1.0
import VPlayPlugins 1.0

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

    property real bicepsDireito: 0
    property real bicepsEsquerdo: 0
    property real antebracoDireito: 0
    property real antebracoEsquerdo: 0
    property real peitoral: 0
    property real cintura: 0
    property real quadril: 0
    property real coxaDireita: 0
    property real coxaEsquerda: 0
    property real panturrilhaDireita: 0
    property real panturrilhaEsquerda: 0
    property real relacaoCinturaQuadril: 0
    property int j: 0

    function buscaDadosMedidasCorporais() {

        dbFitmass.getValue("medidasCorp", {
                                 orderByChild: "userCorp",
                                 equalTo: userID
                             },
                             function (success, key, value) {
                                 if (success) {

//                                     noContent2.visible = false
//                                     noContent.visible = false
//                                     content.visible = true
//                                     dates.visible = true

                                     //console.debug("HISTORICO 2 - Read value " + value + " for key " + key)
                                     for (var prop in value) {
                                         console.log("ANTROPO - VALUE - " + prop)
                                         keyMeasureCorp = prop
                                            if(buscaMedidasCorporais(keyMeasureCorp))
                                                break
                                     }
                                 } else {
                                     if(qtdeMedidaCorp === 0) {
                                         noContent2.visible = true
                                         noContent.visible = false
                                         content.visible = false
                                         dates.visible = false
                                     } else {
                                         nativeUtils.displayAlertDialog("Error! 3", value3, "OK")
                                     }

                                     indicator.stopAnimating()
                                 }
                             })
    }

    function buscaMedidasCorporais(keyMedidaCorp) {

        console.log("tst: " + keyMedidaCorp)

        dbFitmass.getValue("medidasCorp/" + keyMedidaCorp, {
                                 orderByValue: true
                             }, function (success2, key2, value2) {
                                 console.log("log: " + success2)
                                 if (success2) {

                                     console.log("data1: " + Qt.formatDate(value2.dateCorp, "dd/MM/yyyy"))
                                     console.log("data2: " + dateSelect.btnText)

                                     // se houver na data do datepicker:
                                     if (Qt.formatDate(value2.dateCorp, "dd/MM/yyyy") === dateSelect.btnText){

                                         indicator.stopAnimating()

                                         bicepsDireito = parseFloat(value2.bicepsDir)
                                         bicepsEsquerdo = parseFloat(value2.bicepsEsq)
                                         antebracoDireito = parseFloat(value2.antebracoDir)
                                         antebracoEsquerdo = parseFloat(value2.antebracoEsq)
                                         peitoral = parseFloat(value2.peitoral)
                                         cintura = parseFloat(value2.cintura)
                                         quadril = parseFloat(value2.quadril)
                                         coxaDireita = parseFloat(value2.coxaDir)
                                         coxaEsquerda = parseFloat(value2.coxaEsq)
                                         panturrilhaDireita = parseFloat(value2.panturrilhaDir)
                                         panturrilhaEsquerda = parseFloat(value2.panturrilhaEsq)
                                         relacaoCinturaQuadril = cintura / quadril

                                         noContent2.visible = false
                                         noContent.visible = false
                                         content.visible = true
                                         dates.visible = true
                                         console.log("Há medidas nesta data SIM")

                                         return true

                                     } else {
                                         j++

                                         if(j >= qtdeMedidaCorp) {

                                             indicator.stopAnimating()

                                             noContent2.visible = false
                                             noContent.visible = true
                                             content.visible = false
                                             dates.visible = true
                                             console.log("não há medidas nesta data")
                                             return false
                                         }


                                     }

                                 } else {
                                     console.debug(
                                                 "Error with message: " + value3)
                                     nativeUtils.displayAlertDialog(
                                                 "Error! 1", value3, "OK")
                                     return false
                                 }
                             })
    }

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

        // Seletor de datas para escolha da medida a ser mostrada
        Item {
            id: dates
            width: parent.width - root.dp(40)
            height: dateSelect.height
            anchors.top: spacer1.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            visible: true

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
                    btnRadius: radiusText
                    btnText: Qt.formatDate(new Date(), "dd/MM/yyyy")
                    btnBorderWidth: root.dp(1)
                    btnTextColor: greenLight
                    btnTextSize: root.sp(14)

                    anchors.horizontalCenter: parent.horizontalCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            dateAntropoComplete = true
                            // Apresenta o datePicker padrão do OS
                            nativeUtils.displayDatePicker(Qt.formatDate(Date.fromLocaleString(Qt.locale(), dateSelect.btnText, "dd/MM/yyyy"), "yyyy-MM-dd"), "2000-01-01", new Date())
                        }
                    }
                }
            }
        }

        // Medida Completa
        Item {
            id: content
            height: root.dp(490) + root.dp(30)
            width: parent.width
            anchors.top: dates.bottom
            anchors.left: parent.left
            visible: false

            // Bíceps
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

                // Bíceps Direito
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

                // Bíceps Esquerdo
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
            }  // Biceps

            // Antebraço
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

            // Antebraço Direito
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

            // antebraço Esquerdo
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
            }  // Antebraço

            // Peitoral
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

            // Cintura
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

            // Quadril
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

            // Coxa
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

                // Coxa Direita
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

                // Coxa Esquerda
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
            }  // Coxa

            // Panturrilha
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

                // Panturrilha Direita
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

                // Panturrilha Esquerda
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
            }  // Panturrilha
        }
    }

    Component.onCompleted: {
        buscaDadosMedidasCorporais()
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
            color: greenDark
            font.pixelSize: root.dp(14)
        }
    }

    Item {
        id: noContent2
        anchors.fill: parent
        visible: false

        Text {
            id: noMeasure2
            text: "Você ainda não possui medidas corporais."
            anchors.centerIn: parent
            color: greenDark
            font.pixelSize: root.dp(14)
        }
    }

    Connections {
        target: nativeUtils

        onDatePickerFinished: {
            if(dateAntropoComplete){
                indicator.visible = true
                indicator.startAnimating()

                noContent2.visible = false
                noContent.visible = false
                content.visible = false
                dates.visible = true

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
                }

                j = 0
                buscaDadosMedidasCorporais()


                dateAntropoComplete = false
            }
        }
    }

    FirebaseDatabase {
        id: dbFitmass

        config: FirebaseConfig {
             //get these values from the firebase console
             projectId: "fitmass-2018"
             databaseUrl: "https://fitmassapp.firebaseio.com/"

             //platform dependent - get these values from the google-services.json / GoogleService-info.plist
             apiKey:        Qt.platform.os === "android" ? "AIzaSyBh6Kb12xUnOsQDTP2XEbSKtuGsBfmCyic" : "AIzaSyBh6Kb12xUnOsQDTP2XEbSKtuGsBfmCyic"
             applicationId: Qt.platform.os === "android" ? "1:519505351771:android:28365556727f1ea3" : "1:519505351771:ios:28365556727f1ea3"
           }
    }
}
