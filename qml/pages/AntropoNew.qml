import VPlayApps 1.0
import QtQuick 2.11

import "../common"
import "../pages"

Page {
    id: antropoNewPage
    title: "Nova medida"
    height: 960
    width: 640

    rightBarItem: NavigationBarRow {
        id: rightNavBarRowMeasureCorp

        IconButtonBarItem {
            title: "Salvar"
            icon: IconType.check

            onClicked: {
                if (txtRightArmBicepsUser.text == "" || txtRightArmAntebracoUser.text
                        == "" || txtLeftArmBicepsUser.text == "" || txtLeftArmAntebracoUser.text
                        == "" || txtChest.text == "" || txtWaist.text == "" || txtHip
                        == "" || txtRightLegThighUser == "" || txtRightLegCalfUser
                        == "" || txtLeftLegThighUser.text == "" || txtLeftLegCalfUser.text == "") {

                    nativeUtils.displayAlertDialog(
                                "Atenção",
                                "Tem certeza que deseja salvar essa medida? \nNem todos os campos estão preenchidos",
                                "Sim", "Não")
                }
            }

            Connections {
                target: nativeUtils

                onAlertDialogFinished: {
                    if (accepted) {
                        var corpKey = "corporal_" + userID + "_" + Qt.formatDate(
                                    Date.fromLocaleString(
                                        Qt.locale(), txtDatePickerUser.text,
                                        "dd MMM yyyy"), "yyyyMMdd")
                        console.log("SALVAR medida corporal aceita - key: " + corpKey)
                        antropoStack.pop()
                    }
                }
            }
        }
    }

    Item {
        id: imageAntropo
        width: parent.width / 2
        height: parent.height
        anchors.left: parent.left

        AppImage {
            id: personRef
            source: "../../assets/Wantropo.png"
            height: parent.height - dp(30)
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
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

            Item {
                id: datePicker
                width: parent.width
                height: txtDatePicker.height + datePickerUser.height
                anchors.top: parent.top
                anchors.left: parent.left

                Text {
                    id: txtDatePicker
                    text: "Data"
                    color: amareloMassa
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width
                    topPadding: dp(10)
                    horizontalAlignment: Text.AlignHCenter
                }

                Item {
                    id: datePickerUser
                    height: txtDatePickerUser.height
                    width: parent.width
                    anchors.right: parent.right
                    anchors.top: txtDatePicker.bottom

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

                    Text {
                        id: txtDatePickerUser
                        anchors.top: parent.top
                        width: parent.width - dp(10)
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter
                        topPadding: dp(5)

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
                                            txtDatePickerUser.color = "black"
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
                                            txtDatePickerUser.color = "black"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Item {
                id: rightArm
                width: parent.width
                height: txtRightArm.height + rightBiceps.height + rightAntebraco.height
                anchors.top: datePicker.bottom
                anchors.left: parent.left

                Text {
                    id: txtRightArm
                    text: "Braço direito"
                    color: amareloMassa
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width
                    topPadding: dp(10)
                    horizontalAlignment: Text.AlignHCenter
                }

                Item {
                    id: rightBiceps
                    height: rightBicepsUser.height
                    width: parent.width / 2
                    anchors.left: parent.left
                    anchors.top: txtRightArm.bottom

                    Text {
                        id: txtRightArmBiceps
                        width: parent.width
                        height: parent.height
                        text: "Bíceps: "
                        color: verdeMassa
                        anchors.left: parent.left
                        verticalAlignment: Text.AlignBottom
                    }
                }

                Item {
                    id: rightBicepsUser
                    height: txtRightArmBicepsUser.height
                    width: parent.width / 2
                    anchors.right: parent.right
                    anchors.top: txtRightArm.bottom

                    AppTextField {
                        id: txtRightArmBicepsUser
                        anchors.top: parent.top
                        width: parent.width - dp(10)
                        rightPadding: dp(3)
                        inputMethodHints: Qt.ImhFormattedNumbersOnly

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                personRef.source = "../../assets/Wbicepsdireito.png"
                                txtRightArmBicepsUser.forceActiveFocus()
                            }
                        }
                    }
                }

                Item {
                    id: rightAntebraco
                    height: rightBicepsUser.height
                    width: parent.width / 2
                    anchors.left: parent.left
                    anchors.top: rightBiceps.bottom

                    Text {
                        id: txtRightArmAntebraco
                        width: parent.width
                        height: parent.height
                        text: "Antebraço: "
                        color: verdeMassa
                        anchors.left: parent.left
                        verticalAlignment: Text.AlignBottom
                    }
                }

                Item {
                    id: rightAntebracoUser
                    height: txtRightArmAntebracoUser.height
                    width: parent.width / 2
                    anchors.right: parent.right
                    anchors.top: rightBiceps.bottom

                    AppTextField {
                        id: txtRightArmAntebracoUser
                        anchors.top: parent.top
                        width: parent.width - dp(10)
                        rightPadding: dp(3)
                        inputMethodHints: Qt.ImhFormattedNumbersOnly

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                personRef.source = "../../assets/Wantebraçodireito.png"
                                txtRightArmAntebracoUser.forceActiveFocus()
                            }
                        }
                    }
                }
            }

            Item {
                id: leftArm
                width: parent.width
                height: txtLeftArm.height + leftBiceps.height + leftAntebraco.height
                anchors.top: rightArm.bottom
                anchors.left: parent.left

                Text {
                    id: txtLeftArm
                    text: "Braço esquerdo"
                    color: amareloMassa
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width
                    topPadding: dp(10)
                    horizontalAlignment: Text.AlignHCenter
                }

                Item {
                    id: leftBiceps
                    height: leftBicepsUser.height
                    width: parent.width / 2
                    anchors.left: parent.left
                    anchors.top: txtLeftArm.bottom

                    Text {
                        id: txtLeftArmBiceps
                        width: parent.width
                        height: parent.height
                        text: "Bíceps: "
                        color: verdeMassa
                        anchors.left: parent.left
                        verticalAlignment: Text.AlignBottom
                    }
                }

                Item {
                    id: leftBicepsUser
                    height: txtLeftArmBicepsUser.height
                    width: parent.width / 2
                    anchors.right: parent.right
                    anchors.top: txtLeftArm.bottom

                    AppTextField {
                        id: txtLeftArmBicepsUser
                        anchors.top: parent.top
                        width: parent.width - dp(10)
                        rightPadding: dp(3)
                        inputMethodHints: Qt.ImhFormattedNumbersOnly

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                personRef.source = "../../assets/Wbicepsesquerdo.png"
                                txtLeftArmBicepsUser.forceActiveFocus()
                            }
                        }
                    }
                }

                Item {
                    id: leftAntebraco
                    height: leftBicepsUser.height
                    width: parent.width / 2
                    anchors.left: parent.left
                    anchors.top: leftBiceps.bottom

                    Text {
                        id: txtLeftArmAntebraco
                        width: parent.width
                        height: parent.height
                        text: "Antebraço: "
                        color: verdeMassa
                        anchors.left: parent.left
                        verticalAlignment: Text.AlignBottom
                    }
                }

                Item {
                    id: leftAntebracoUser
                    height: txtLeftArmAntebracoUser.height
                    width: parent.width / 2
                    anchors.right: parent.right
                    anchors.top: leftBiceps.bottom

                    AppTextField {
                        id: txtLeftArmAntebracoUser
                        anchors.top: parent.top
                        width: parent.width - dp(10)
                        rightPadding: dp(3)
                        inputMethodHints: Qt.ImhFormattedNumbersOnly

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                personRef.source = "../../assets/Wantebraçoesquerdo.png"
                                txtLeftArmAntebracoUser.forceActiveFocus()
                            }
                        }
                    }
                }
            }

            Item {
                id: chest
                width: parent.width
                height: txtChest.height + chestItem.height
                anchors.top: leftArm.bottom
                anchors.left: parent.left

                Text {
                    id: txtChest
                    text: "Peitoral"
                    color: amareloMassa
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width
                    topPadding: dp(10)
                    horizontalAlignment: Text.AlignHCenter
                }

                Item {
                    id: chestItem
                    height: chestUser.height
                    width: parent.width / 2
                    anchors.left: parent.left
                    anchors.top: txtChest.bottom

                    Text {
                        id: txtChestItem
                        width: parent.width
                        height: parent.height
                        text: "Peitoral: "
                        color: verdeMassa
                        anchors.left: parent.left
                        verticalAlignment: Text.AlignBottom
                    }
                }

                Item {
                    id: chestUser
                    height: txtChestUser.height
                    width: parent.width / 2
                    anchors.right: parent.right
                    anchors.top: txtChest.bottom

                    AppTextField {
                        id: txtChestUser
                        anchors.top: parent.top
                        width: parent.width - dp(10)
                        rightPadding: dp(3)
                        inputMethodHints: Qt.ImhFormattedNumbersOnly

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                personRef.source = "../../assets/Wpeitoral.png"
                                txtChestUser.forceActiveFocus()
                            }
                        }
                    }
                }
            }

            Item {
                id: waist
                width: parent.width
                height: txtWaist.height + waistItem.height
                anchors.top: chest.bottom
                anchors.left: parent.left

                Text {
                    id: txtWaist
                    text: "Cintura"
                    color: amareloMassa
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width
                    topPadding: dp(10)
                    horizontalAlignment: Text.AlignHCenter
                }

                Item {
                    id: waistItem
                    height: waistUser.height
                    width: parent.width / 2
                    anchors.left: parent.left
                    anchors.top: txtWaist.bottom

                    Text {
                        id: txtWaistItem
                        width: parent.width
                        height: parent.height
                        text: "Cintura: "
                        color: verdeMassa
                        anchors.left: parent.left
                        verticalAlignment: Text.AlignBottom
                    }
                }

                Item {
                    id: waistUser
                    height: txtWaistUser.height
                    width: parent.width / 2
                    anchors.right: parent.right
                    anchors.top: txtWaist.bottom

                    AppTextField {
                        id: txtWaistUser
                        anchors.top: parent.top
                        width: parent.width - dp(10)
                        rightPadding: dp(3)
                        inputMethodHints: Qt.ImhFormattedNumbersOnly

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                personRef.source = "../../assets/Wcintura.png"
                                txtWaistUser.forceActiveFocus()
                            }
                        }
                    }
                }
            }

            Item {
                id: hip
                width: parent.width
                height: txtHip.height + hipItem.height
                anchors.top: waist.bottom
                anchors.left: parent.left

                Text {
                    id: txtHip
                    text: "Quadril"
                    color: amareloMassa
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width
                    topPadding: dp(10)
                    horizontalAlignment: Text.AlignHCenter
                }

                Item {
                    id: hipItem
                    height: waistUser.height
                    width: parent.width / 2
                    anchors.left: parent.left
                    anchors.top: txtHip.bottom

                    Text {
                        id: txtHipItem
                        width: parent.width
                        height: parent.height
                        text: "Quadril: "
                        color: verdeMassa
                        anchors.left: parent.left
                        verticalAlignment: Text.AlignBottom
                    }
                }

                Item {
                    id: hipUser
                    height: txtWaistUser.height
                    width: parent.width / 2
                    anchors.right: parent.right
                    anchors.top: txtHip.bottom

                    AppTextField {
                        id: txtHipUser
                        anchors.top: parent.top
                        width: parent.width - dp(10)
                        rightPadding: dp(3)
                        inputMethodHints: Qt.ImhFormattedNumbersOnly

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                personRef.source = "../../assets/Wquadril.png"
                                txtHipUser.forceActiveFocus()
                            }
                        }
                    }
                }
            }

            Item {
                id: rightLeg
                width: parent.width
                height: txtRightLeg.height + rightThigh.height + rightCalf.height
                anchors.top: hip.bottom
                anchors.left: parent.left

                Text {
                    id: txtRightLeg
                    text: "Perna direita"
                    color: amareloMassa
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width
                    topPadding: dp(10)
                    horizontalAlignment: Text.AlignHCenter
                }

                Item {
                    id: rightThigh
                    height: rightThighUser.height
                    width: parent.width / 2
                    anchors.left: parent.left
                    anchors.top: txtRightLeg.bottom

                    Text {
                        id: txtRightLegThigh
                        width: parent.width
                        height: parent.height
                        text: "Coxa: "
                        color: verdeMassa
                        anchors.left: parent.left
                        verticalAlignment: Text.AlignBottom
                    }
                }

                Item {
                    id: rightThighUser
                    height: txtRightLegThighUser.height
                    width: parent.width / 2
                    anchors.right: parent.right
                    anchors.top: txtRightLeg.bottom

                    AppTextField {
                        id: txtRightLegThighUser
                        anchors.top: parent.top
                        width: parent.width - dp(10)
                        rightPadding: dp(3)
                        inputMethodHints: Qt.ImhFormattedNumbersOnly

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                personRef.source = "../../assets/Wcoxadireita.png"
                                txtRightLegThighUser.forceActiveFocus()
                            }
                        }
                    }
                }

                Item {
                    id: rightCalf
                    height: rightCalfUser.height
                    width: parent.width / 2
                    anchors.left: parent.left
                    anchors.top: rightThigh.bottom

                    Text {
                        id: txtRightLegCalf
                        width: parent.width
                        height: parent.height
                        text: "Panturrilha: "
                        color: verdeMassa
                        anchors.left: parent.left
                        verticalAlignment: Text.AlignBottom
                    }
                }

                Item {
                    id: rightCalfUser
                    height: txtRightLegCalfUser.height
                    width: parent.width / 2
                    anchors.right: parent.right
                    anchors.top: rightThigh.bottom

                    AppTextField {
                        id: txtRightLegCalfUser
                        anchors.top: parent.top
                        width: parent.width - dp(10)
                        rightPadding: dp(3)
                        inputMethodHints: Qt.ImhFormattedNumbersOnly

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                personRef.source = "../../assets/Wpanturrilhadireita.png"
                                txtRightLegCalfUser.forceActiveFocus()
                            }
                        }
                    }
                }
            }

            Item {
                id: leftLeg
                width: parent.width
                height: txtLeftLeg.height + leftThigh.height + leftCalf.height
                anchors.top: rightLeg.bottom
                anchors.left: parent.left

                Text {
                    id: txtLeftLeg
                    text: "Perna esquerda"
                    color: amareloMassa
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width
                    topPadding: dp(10)
                    horizontalAlignment: Text.AlignHCenter
                }

                Item {
                    id: leftThigh
                    height: leftThighUser.height
                    width: parent.width / 2
                    anchors.left: parent.left
                    anchors.top: txtLeftLeg.bottom

                    Text {
                        id: txtLeftLegThigh
                        width: parent.width
                        height: parent.height
                        text: "Coxa: "
                        color: verdeMassa
                        anchors.left: parent.left
                        verticalAlignment: Text.AlignBottom
                    }
                }

                Item {
                    id: leftThighUser
                    height: txtLeftLegThighUser.height
                    width: parent.width / 2
                    anchors.right: parent.right
                    anchors.top: txtLeftLeg.bottom

                    AppTextField {
                        id: txtLeftLegThighUser
                        anchors.top: parent.top
                        width: parent.width - dp(10)
                        rightPadding: dp(3)
                        inputMethodHints: Qt.ImhFormattedNumbersOnly

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                personRef.source = "../../assets/Wcoxaesquerda.png"
                                txtLeftLegThighUser.forceActiveFocus()
                            }
                        }
                    }
                }

                Item {
                    id: leftCalf
                    height: leftThighUser.height
                    width: parent.width / 2
                    anchors.left: parent.left
                    anchors.top: leftThigh.bottom

                    Text {
                        id: txtLeftLegCalf
                        width: parent.width
                        height: parent.height
                        text: "Panturrilha: "
                        color: verdeMassa
                        anchors.left: parent.left
                        verticalAlignment: Text.AlignBottom
                    }
                }

                Item {
                    id: leftCalfUser
                    height: txtLeftLegCalfUser.height
                    width: parent.width / 2
                    anchors.right: parent.right
                    anchors.top: leftThigh.bottom

                    AppTextField {
                        id: txtLeftLegCalfUser
                        anchors.top: parent.top
                        width: parent.width - dp(10)
                        rightPadding: dp(3)
                        inputMethodHints: Qt.ImhFormattedNumbersOnly

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                personRef.source = "../../assets/Wpanturrilhaesquerda.png"
                                txtLeftLegCalfUser.forceActiveFocus()
                            }
                        }
                    }
                }
            }
        }
    }

    ScrollIndicator {
        flickable: flickableAntropo
    } // scroll indicator
}
