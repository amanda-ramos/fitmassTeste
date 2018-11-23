import VPlayApps 1.0
import QtQuick 2.11
import VPlayPlugins 1.0

import "../common"
import "../pages"

Page {
    id: antropoNewPage
    title: "Nova medida"
    height: screenSizeY
    width: screenSizeX

    property color txtTitle: greenDark
    property var txtTitleSize: root.sp(16)

    // Ícones na barra de navegação superior
    rightBarItem: NavigationBarRow {
        id: rightNavBarRowMeasureCorp

        // Ícone para salvar a nova medida no banco de dados
        IconButtonBarItem {
            title: "Salvar"
            icon: IconType.check

            onClicked: {
                // Verifica se não há campos vazios
                if (rightBiceps.tfTextText === "" || rightAntebraco.tfTextText
                        === "" || leftBiceps.tfTextText === "" || leftAntebraco.tfTextText
                        === "" || chestItem.tfTextText === "" || waistItem.tfTextText === "" || hipItem.tfTextText
                        === "" || rightThigh.tfTextText === "" || rightCalf.tfTextText
                        === "" || leftThigh.tfTextText === "" || leftCalf.tfTextText === "") {

                    // Confirma o salvar mesmo com campos vazios
                    nativeUtils.displayAlertDialog(
                                "Atenção",
                                "Tem certeza que deseja salvar essa medida? \nNem todos os campos estão preenchidos",
                                "Sim", "Não")
                } else {
                    // Confirma o salvar
                    nativeUtils.displayAlertDialog(
                                "Atenção",
                                "Tem certeza que deseja salvar essa medida? ",
                                "Sim", "Não")
                }
            }

            Connections {
                target: nativeUtils

                onAlertDialogFinished: {
                    if (accepted) {
                        // Ao aceitar, salvar os dados no banco de dados
                        //
                        //

                        // Temporário: cria key da medida e aparece no log
                        var corpKey = "corporal_" + userID + "_" + Qt.formatDate(
                                    Date.fromLocaleString(
                                        Qt.locale(), txtDatePickerUser.text,
                                        "dd MMM yyyy"), "yyyyMMdd")
                        console.log("SALVAR medida corporal aceita - key: " + corpKey)

                        dbFitmass.setValue("medidasCorp/" + corpKey, {
                             "dateCorp": Date.fromLocaleString(locale, txtDatePickerUser.text, "dd MMM yyyy"),
                             "bicepsDir": rightBiceps.tfTextText,
                             "bicepsEsq": leftBiceps.tfTextText,
                             "antebracoDir": rightAntebraco.tfTextText,
                             "antebracoEsq": leftAntebraco.tfTextText,
                             "peitoral": chestItem.tfTextText,
                             "cintura": waistItem.tfTextText,
                             "quadril": hipItem.tfTextText,
                             "coxaDir": rightThigh.tfTextText,
                             "coxaEsq": leftThigh.tfTextText,
                             "panturrilhaDir": rightCalf.tfTextText,
                             "panturrilhaEsq": leftCalf.tfTextText,
                             "userCorp": root.userID
                        }, function(success, message) {
                                 if(success) {
                                   console.log("CADASTRO MEDIDA - sucesso")

                                     nativeUtils.displayAlertDialog("Sucesso", "Dados salvos com sucesso!", "OK")
                                     // volta a tela
                                     antropoStack.pop()
                                     antropoStack.push({item: antropoView, replace: true})
                                     indicator.stopAnimating()
                                     indicator.visible = false

                                 } else {
                                   console.log("CADASTRO MEDIDA - DB write error:", message)
                                 }
                               })
                    }
                }
            }
        }
    }

    // Imagem do perfil de uma pessoa
    Item {
        id: imageAntropo
        width: parent.width / 2
        height: parent.height
        anchors.left: parent.left

        AppImage {
            id: personRef
            source: "../../assets/Wantropo.png"
            width: parent.width - root.dp(80)
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }

        Item {
            id: info
            width: parent.width
            height: iconInfo.height + space2.height
            anchors.bottom: parent.bottom

            Item {
                width: parent.width
                height: iconInfo.height+ space2.height

                Image {
                    id: iconInfo
                    height: root.dp(22)
                    width: height
                    source: "../../assets/icon_info.png"
                    anchors.left: space1.right
                    anchors.bottom: space2.top

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
//                            var infopage = infoView.createObject()
//                            fitmassStack.push(infopage)
                        }
                    }
                }

                Rectangle {
                    id: space1
                    height: iconInfo.height
                    width: dp(20)
                    color: "transparent"
                    anchors.left: parent.left
                }

                Rectangle {
                    id: space2
                    anchors.bottom: parent.bottom
                    height: dp(20)
                    width: iconInfo.height
                    color: "transparent"
                }
            }
        }
    }

    AppFlickable {
        id: flickableAntropo
        width: parent.width
        anchors.right: parent.right
        contentHeight: measureAntropo.height + dp(20)
        height: parent.height

        MouseArea {
            anchors.fill: parent
            onClicked: {
                flickableAntropo.forceActiveFocus()
            }
        }

        Item {
            id: measureAntropo
            width: parent.width / 2
            height: rightArm.height + leftArm.height + chest.height + waist.height
                    + hip.height + rightLeg.height + leftLeg.height + datePicker.height
            anchors.right: parent.right

            // Selecionar a data da medida a ser salva
            Item {
                id: datePicker
                width: parent.width
                height: txtDatePicker.height + datePickerUser.height
                anchors.top: parent.top
                anchors.left: parent.left

                Text {
                    id: txtDatePicker
                    text: "Data"
                    color: txtTitle
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width - root.dp(10)
                    topPadding: root.dp(10)
                    horizontalAlignment: Text.AlignHCenter
                }

                Item {
                    id: datePickerUser
                    height: dateBackground.height
                    width: parent.width
                    anchors.right: parent.right
                    anchors.top: txtDatePicker.bottom

                    Rectangle {
                        id: spacer2
                        width: root.dp(15)
                        height: parent.height
                        anchors.right: dateBackground.right
                        anchors.top: parent.top
                        color: "transparent"
                    }

                    Image {
                        id: seta
                        source: "../../assets/seta.png"
                        width: root.dp(15)
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: spacer2.left
                    }

                    Rectangle {
                        id: dateBackground
                        width: parent.width - root.dp(10)
                        height: root.dp(40)
                        anchors.top: parent.top
                        anchors.left: parent.left

                        color: tfColor
                        radius: root.dp(30)
                        z: -1
                    }

                    Text {
                        id: txtDatePickerUser
                        width: parent.width - root. dp(10)
                        anchors.verticalCenter: dateBackground.verticalCenter
                        anchors.horizontalCenter: dateBackground.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter

                        text: Qt.formatDate(new Date(), "dd MMM yyyy")
                        color: "#b4b4b4"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                nativeUtils.displayDatePicker(
                                            Qt.formatDate(
                                                Date.fromLocaleString(
                                                    Qt.locale(),
                                                    txtDatePickerUser.text,
                                                    "dd MMM yyyy"),
                                                "yyyy-MM-dd"), "2000-01-01",
                                            new Date())
                            }

                            Connections {
                                target: nativeUtils

                                onDatePickerFinished: {
                                    if (accepted) {

                                        var hour = ""
                                        var dateStr = ""
                                        var timeShift = ""

                                        dateStr = date.toLocaleTimeString(
                                                    Qt.locale("pt_BR"))
                                        hour = parseInt(dateStr.split(":")[0])
                                        timeShift = Qt.formatDateTime(date, "t")

                                        if (hour === 00) {
                                            txtDatePickerUser.text = Qt.formatDate(
                                                        date, "dd MMM yyyy")
                                        } else {
                                            Date.prototype.addHours = function (h) {
                                                this.setTime(
                                                         this.getTime(
                                                             ) + (h * 60 * 60 * 1000))
                                                return this
                                            }
                                            txtDatePickerUser.text = Qt.formatDate(
                                                        date.addHours(
                                                            24 - hour),
                                                        "dd MMM yyyy")
                                        }
                                        txtDatePickerUser.color = greenLight
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Braço Direito
            Item {
                id: rightArm
                width: parent.width
                height: txtRightArm.height + rightBiceps.height + rightAntebraco.height
                anchors.top: datePicker.bottom
                anchors.left: parent.left

                Text {
                    id: txtRightArm
                    text: "Braço direito"
                    color: txtTitle
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width - root.dp(10)
                    topPadding: root.dp(10)
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: txtTitleSize
                }

                // Bíceps Direito
                CustomTextFieldInterativo {
                    id: rightBiceps
                    height: root.dp(70)
                    anchors.top: txtRightArm.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    tfTitleColor: white
                    tfTextColor: greenLight
                    tfColor: grayLight
                    tfRadius: radiusText
                    tfTextTitle: "Bíceps: "
                    tfTextText: ""
                    tfWidth: parent.width
                    tfHeight: root.dp(40)
                    tfTextType: Qt.ImhFormattedNumbersOnly

                    sourceImage: "../../assets/Wbicepsdireito.png"
                }

                // Antebraço Direito
                CustomTextFieldInterativo {
                    id: rightAntebraco
                    height: root.dp(70)
                    anchors.top: rightBiceps.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    tfTitleColor: white
                    tfTextColor: greenLight
                    tfColor: grayLight
                    tfRadius: radiusText
                    tfTextTitle: "Antebraço: "
                    tfTextText: ""
                    tfWidth: parent.width
                    tfHeight: root.dp(40)
                    tfTextType: Qt.ImhFormattedNumbersOnly

                    sourceImage: "../../assets/Wantebraçodireito.png"
                }
          }

            // Braço Esquerdo
            Item {
                id: leftArm
                width: parent.width
                height: txtLeftArm.height + leftBiceps.height + leftAntebraco.height
                anchors.top: rightArm.bottom
                anchors.left: parent.left

                Text {
                    id: txtLeftArm
                    text: "Braço esquerdo"
                    color: txtTitle
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width - root.dp(10)
                    topPadding: root.dp(10)
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: txtTitleSize
                }

                // Bíceps Esquerdo
                CustomTextFieldInterativo {
                    id: leftBiceps
                    height: root.dp(70)
                    anchors.top: txtLeftArm.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    tfTitleColor: white
                    tfTextColor: greenLight
                    tfColor: grayLight
                    tfRadius: radiusText
                    tfTextTitle: "Bíceps: "
                    tfTextText: ""
                    tfWidth: parent.width
                    tfHeight: root.dp(40)
                    tfTextType: Qt.ImhFormattedNumbersOnly

                    sourceImage: "../../assets/Wbicepsesquerdo.png"
                }

                // Antebraço Esquerdo
                CustomTextFieldInterativo {
                    id: leftAntebraco
                    height: root.dp(70)
                    anchors.top: leftBiceps.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    tfTitleColor: white
                    tfTextColor: greenLight
                    tfColor: grayLight
                    tfRadius: radiusText
                    tfTextTitle: "Antebraço: "
                    tfTextText: ""
                    tfWidth: parent.width
                    tfHeight: root.dp(40)
                    tfTextType: Qt.ImhFormattedNumbersOnly

                    sourceImage: "../../assets/Wantebraçoesquerdo.png"
                }
            }

            // Peitoral
            Item {
                id: chest
                width: parent.width
                height: txtChest.height + chestItem.height
                anchors.top: leftArm.bottom
                anchors.left: parent.left

                Text {
                    id: txtChest
                    text: "Peitoral"
                    color: txtTitle
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width - root.dp(10)
                    topPadding: root.dp(10)
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: txtTitleSize
                }

                CustomTextFieldInterativo {
                    id: chestItem
                    height: root.dp(50)
                    anchors.top: txtChest.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    tfTitleColor: white
                    tfTextColor: greenLight
                    tfColor: grayLight
                    tfRadius: radiusText
                    tfTextTitle: ""
                    tfTextText: ""
                    tfWidth: parent.width
                    tfHeight: root.dp(20)
                    tfTextType: Qt.ImhFormattedNumbersOnly

                    sourceImage: "../../assets/Wpeitoral.png"
                }
            }

            // Cintura
            Item {
                id: waist
                width: parent.width
                height: txtWaist.height + waistItem.height
                anchors.top: chest.bottom
                anchors.left: parent.left

                Text {
                    id: txtWaist
                    text: "Cintura"
                    color: txtTitle
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width - root.dp(10)
                    topPadding: root.dp(10)
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: txtTitleSize
                }

                CustomTextFieldInterativo {
                    id: waistItem
                    height: root.dp(50)
                    anchors.top: txtWaist.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    tfTitleColor: white
                    tfTextColor: greenLight
                    tfColor: grayLight
                    tfRadius: radiusText
                    tfTextTitle: ""
                    tfTextText: ""
                    tfWidth: parent.width
                    tfHeight: root.dp(20)
                    tfTextType: Qt.ImhFormattedNumbersOnly

                    sourceImage: "../../assets/Wcintura.png"
                }
            }

            // Quadril
            Item {
                id: hip
                width: parent.width
                height: txtHip.height + hipItem.height
                anchors.top: waist.bottom
                anchors.left: parent.left

                Text {
                    id: txtHip
                    text: "Quadril"
                    color: txtTitle
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width - root.dp(10)
                    topPadding: root.dp(10)
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: txtTitleSize
                }

                CustomTextFieldInterativo {
                    id: hipItem
                    height: root.dp(50)
                    anchors.top: txtHip.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    tfTitleColor: white
                    tfTextColor: greenLight
                    tfColor: grayLight
                    tfRadius: radiusText
                    tfTextTitle: ""
                    tfTextText: ""
                    tfWidth: parent.width
                    tfHeight: root.dp(20)
                    tfTextType: Qt.ImhFormattedNumbersOnly

                    sourceImage: "../../assets/Wquadril.png"
                }
            }

            // Perna Direita
            Item {
                id: rightLeg
                width: parent.width
                height: txtRightLeg.height + rightThigh.height + rightCalf.height
                anchors.top: hip.bottom
                anchors.left: parent.left

                Text {
                    id: txtRightLeg
                    text: "Perna direita"
                    color: txtTitle
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width - root.dp(10)
                    topPadding: root.dp(10)
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: txtTitleSize
                }

                // Coxa Direita
                CustomTextFieldInterativo {
                    id: rightThigh
                    height: root.dp(70)
                    anchors.top: txtRightLeg.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    tfTitleColor: white
                    tfTextColor: greenLight
                    tfColor: grayLight
                    tfRadius: radiusText
                    tfTextTitle: "Coxa: "
                    tfTextText: ""
                    tfWidth: parent.width
                    tfHeight: root.dp(40)
                    tfTextType: Qt.ImhFormattedNumbersOnly

                    sourceImage: "../../assets/Wcoxadireita.png"
                }

                // Panturrilha Direita
                CustomTextFieldInterativo {
                    id: rightCalf
                    height: root.dp(70)
                    anchors.top: rightThigh.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    tfTitleColor: white
                    tfTextColor: greenLight
                    tfColor: grayLight
                    tfRadius: radiusText
                    tfTextTitle: "Panturrilha: "
                    tfTextText: ""
                    tfWidth: parent.width
                    tfHeight: root.dp(40)
                    tfTextType: Qt.ImhFormattedNumbersOnly

                    sourceImage: "../../assets/Wpanturrilhadireita.png"
                }
            }

            // Perna Esquerda
            Item {
                id: leftLeg
                width: parent.width
                height: txtLeftLeg.height + leftThigh.height + leftCalf.height
                anchors.top: rightLeg.bottom
                anchors.left: parent.left

                Text {
                    id: txtLeftLeg
                    text: "Perna esquerda"
                    color: txtTitle
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width - root.dp(10)
                    topPadding: root.dp(10)
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: txtTitleSize
                }

                // Coxa Esquerda
                CustomTextFieldInterativo {
                    id: leftThigh
                    height: root.dp(70)
                    anchors.top: txtLeftLeg.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    tfTitleColor: white
                    tfTextColor: greenLight
                    tfColor: grayLight
                    tfRadius: radiusText
                    tfTextTitle: "Coxa: "
                    tfTextText: ""
                    tfWidth: parent.width
                    tfHeight: root.dp(40)
                    tfTextType: Qt.ImhFormattedNumbersOnly

                    sourceImage: "../../assets/Wcoxaesquerda.png"
                }

                // Panturrilha Esquerda
                CustomTextFieldInterativo {
                    id: leftCalf
                    height: root.dp(70)
                    anchors.top: leftThigh.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    tfTitleColor: white
                    tfTextColor: greenLight
                    tfColor: grayLight
                    tfRadius: radiusText
                    tfTextTitle: "Panturrilha: "
                    tfTextText: ""
                    tfWidth: parent.width
                    tfHeight: root.dp(40)
                    tfTextType: Qt.ImhFormattedNumbersOnly

                    sourceImage: "../../assets/Wpanturrilhaesquerda.png"
                }
            }
        }
    }

    ScrollIndicator {
        flickable: flickableAntropo
    } // scroll indicator

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
