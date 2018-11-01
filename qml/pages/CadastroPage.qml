import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2
import QtMultimedia 5.5
import QtQml 2.11

import "../common"
import "../pages"

Page {
    id: cadastroPage
    title: "Cadastro"
    height: 960
    width: 640

    property color txtColor: verdeMassa
    property color userTxtColor: "#4b4b4b"
    property color backEditField: "#efefef"

    property var pathImage: ""

    property var txtPadding: dp(10)
    property var userTxtPadding: dp(20)
    property var editTextMargin: dp(20)

    property bool genero: false
    property bool pesoDesejado: false
    property bool altura: false

    function vector(min, max, step, decimos) {
        var j = 0
        var i = 0
        var valores = []

        for (i = min; i <= max; i = i + step) {
            if (decimos)
                valores[j] = i.toFixed(2)
            else
                valores[j] = i.toFixed(0)

            j++
        }
        return valores
    }

    function calculateAge(birthday) {
        var yearUser = Qt.formatDateTime(birthday, "yyyy")
        var monthUser = Qt.formatDateTime(birthday, "MM")
        var dayUser = Qt.formatDateTime(birthday, "dd")

        var dateNow = new Date()
        var year = Qt.formatDateTime(dateNow, "yyyy")
        var month = Qt.formatDateTime(dateNow, "MM")
        var day = Qt.formatDateTime(dateNow, "dd")

        var age = parseInt(year) - parseInt(yearUser)
        if (month < monthUser) {
            age--
        } else if (month == monthUser) {
            if (dayUser > day) {
                age--
            }
        }
        return age
    }

    AppFlickable {
        id: scrollCadastro
        anchors.fill: parent
        contentHeight: contentProfileCadastro.height

        MouseArea {
            anchors.fill: parent
            onClicked: scrollCadastro.forceActiveFocus()
        }

        Column {
            id: contentProfileCadastro
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter

            Item {
                width: parent.width
                height: rowImageProfileCadastro.height + rowNomeCadastro.height
                        + rowEmailCadastro.height + rowIdadeCadastro.height
                        + rowGeneroCadastro.height + rowAlturaCadastro.height
                        + rowPesoDesejadoCadastro.height
                        + spacer1Cadastro.height + spacer2Cadastro.height
                        + rowSenhaCadastro.height + rowBtnCadastrar.height + dp(
                            32)

                Item {
                    id: rowImageProfileCadastro
                    width: parent.width
                    height: userImage1Cadastro.height + space1Cadastro.height
                    anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle {
                        id: space1Cadastro
                        width: parent.width
                        height: dp(25)
                        color: "white"
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Column {
                        id: userImage1Cadastro
                        width: parent.width / 2
                        height: userImageCadastro.height
                        anchors.top: space1Cadastro.bottom
                        anchors.left: parent.left

                        UserImage {
                            id: userImageCadastro
                            property string iconFontName: Theme.iconFont.name
                            width: dp(150)
                            height: width
                            anchors.top: space1Cadastro.bottom
                            anchors.right: parent.right

                            placeholderImage: "\uf007" // user
                            source: ""
                        } // User Image
                    }

                    Column {
                        id: userImage2Cadastro
                        width: parent.width / 2
                        height: userImage1Cadastro.height
                        anchors.top: space1Cadastro.bottom
                        anchors.right: parent.right

                        AppButton {

                            property bool shownEditPhotoDialog: false

                            id: userImageCadastroBtn
                            text: "Carregar foto"
                            onClicked: {
                                shownEditPhotoDialog = true
                                nativeUtils.displayAlertSheet(
                                            "",
                                            ["Escolher Foto", "Tirar Foto"],
                                            true)
                            }
                            verticalMargin: 0
                            flat: false
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            backgroundColor: verdeMassa

                            Connections {
                                target: nativeUtils

                                // @disable-check M16
                                onAlertSheetFinished: {
                                    if (userImageCadastroBtn.shownEditPhotoDialog) {
                                        if (index == 0)
                                            nativeUtils.displayImagePicker(
                                                        qsTr("Choose Image")) // Choose image
                                        else if (index == 1)
                                            nativeUtils.displayCameraPicker(
                                                        "Take Photo") // Take from Camera
                                        userImageCadastroBtn.shownEditPhotoDialog = false
                                    }
                                }

                                // @disable-check M16
                                onImagePickerFinished: {
                                    console.debug(
                                                "Image picker finished with path:",
                                                path)
                                    if (accepted) {
                                        //userImageCadastro.source = Qt.resolvedUrl(path)
                                        storageFitmass.uploadFile(
                                                    path,
                                                    "userPhoto" + Date.now(
                                                        ) + ".png",
                                                    function (progress, finished, success, downloadUrl) {
                                                        if (!finished) {
                                                            console.log("Firebase Storage: progresso " + progress.toFixed(
                                                                            2))
                                                        } else if (success) {
                                                            userImageCadastro.source = downloadUrl
                                                            pathImage = downloadUrl
                                                            console.log("Sucesso - Path: "
                                                                        + pathImage)
                                                        } else {
                                                            console.log("Falha ao carregar imagem  no Firebase Storage" + message)
                                                        }
                                                    })
                                    }
                                }

                                // @disable-check M16
                                onCameraPickerFinished: {
                                    console.debug(
                                                "Camera picker finished with path:",
                                                path)
                                    if (accepted) {
                                        //userImageCadastro.source = Qt.resolvedUrl(path)
                                        storageFitmass.uploadFile(
                                                    path, "userPhoto.png",
                                                    function (progress, finished, success, downloadUrl) {
                                                        if (!finished) {
                                                            console.log("Firebase Storage: progresso " + progress.toFixed(
                                                                            2))                                                       } else if (success) {
                                                            console.log("Sucesso - Path: "
                                                                        + pathImage)
                                                            userImageCadastro.source = downloadUrl
                                                            pathImage = downloadUrl
                                                        } else {
                                                            console.log("Falha ao carregar imagem  no Firebase Storage" + message)
                                                        }
                                                    })
                                    }
                                }
                            }
                        }
                    } // Coluna imagem do usuário
                } // Linha imagem do usuário

                Spacer {
                    id: spacer1Cadastro
                    width: parent.width
                    anchors.top: rowImageProfileCadastro.bottom
                }

                Item {
                    id: rowNomeCadastro
                    width: parent.width
                    height: nomeTxtCadastro.height + nomeUserTxtCadastro.height
                    anchors.top: spacer1Cadastro.bottom

                    Rectangle {
                        id: recLineCadastro
                        anchors.centerIn: parent
                        width: parent.width - dp(40)
                        height: nomeUserTxtCadastro.height
                        color: "white"

                        CustomBorderRec {
                            commonBorder: false
                            lBorderwidth: 0
                            rBorderwidth: 0
                            tBorderwidth: 0
                            bBorderwidth: 3
                            borderColor: "#4b4b4b"
                        }
                    }

                    Text {
                        id: nomeTxtCadastro
                        text: "Nome"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    TextEdit {
                        id: nomeUserTxtCadastro
                        width: parent.width - dp(40)
                        text: ""
                        color: userTxtColor
                        anchors.left: parent.left
                        padding: userTxtPadding
                        anchors.top: nomeTxtCadastro.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter
                        cursorVisible: true
                    }
                }

                Item {
                    id: rowEmailCadastro
                    width: parent.width
                    height: emailTxtCadastro.height + emailUserTxtCadastro.height
                    anchors.top: rowNomeCadastro.bottom

                    Rectangle {
                        anchors.centerIn: parent
                        width: parent.width - dp(40)
                        height: emailUserTxtCadastro.height
                        color: "white"

                        CustomBorderRec {
                            commonBorder: false
                            lBorderwidth: 0
                            rBorderwidth: 0
                            tBorderwidth: 0
                            bBorderwidth: 3
                            borderColor: "#4b4b4b"
                        }
                    }

                    Text {
                        id: emailTxtCadastro
                        text: "E-mail"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    TextEdit {
                        id: emailUserTxtCadastro
                        width: parent.width - dp(40)
                        text: ""
                        color: userTxtColor
                        anchors.left: parent.left
                        padding: userTxtPadding
                        anchors.top: emailTxtCadastro.bottom
                        inputMethodHints: Qt.ImhEmailCharactersOnly
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                Item {
                    id: rowIdadeCadastro
                    width: parent.width
                    height: idadeTxtCadastro.height + idadeUserTxtRecCadastro.height
                            + sp2IdadeCadastro.height + sp3IdadeCadastro.height
                    anchors.top: rowEmailCadastro.bottom

                    Text {
                        id: idadeTxtCadastro
                        text: "Nascimento *"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    Rectangle {
                        id: sp1Cadastro
                        color: "transparent"
                        width: userTxtPadding
                        height: idadeUserTxtCadastro.height
                        anchors.left: parent.left
                        anchors.top: idadeTxtCadastro.bottom
                    }

                    Rectangle {
                        id: sp2IdadeCadastro
                        color: "transparent"
                        width: parent.width
                        height: txtPadding
                        anchors.left: parent.left
                        anchors.top: idadeTxtCadastro.bottom
                    }

                    Rectangle {
                        id: sp3IdadeCadastro
                        color: "transparent"
                        width: parent.width
                        height: txtPadding
                        anchors.left: parent.left
                        anchors.top: idadeUserTxtCadastro.bottom
                    }

                    Rectangle {
                        id: idadeUserTxtRecCadastro
                        width: dp(100)
                        height: dp(40)
                        color: backEditField
                        anchors.top: sp2IdadeCadastro.bottom
                        anchors.left: sp1Cadastro.right

                        Text {
                            id: idadeUserTxtCadastro
                            anchors.centerIn: parent
                            text: ""
                            color: "black"
                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                nativeUtils.displayDatePicker(
                                            Qt.formatDate(
                                                Date.fromLocaleString(
                                                    Qt.locale(),
                                                    idadeUserTxtCadastro.text,
                                                    "dd/MM/yyyy"),
                                                "yyyy-MM-dd"))
                            }
                        }
                    }
                }

                Item {
                    id: rowGeneroCadastro
                    width: parent.width
                    height: emailTxtCadastro.height + emailUserTxtCadastro.height
                    anchors.top: rowIdadeCadastro.bottom

                    Text {
                        id: generoTxtCadastro
                        text: "Gênero *"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    Rectangle {
                        id: sp2Cadastro
                        color: "transparent"
                        width: userTxtPadding
                        height: generoUserTxtCadastro.height
                        anchors.left: parent.left
                        anchors.top: generoTxtCadastro.bottom
                    }

                    Rectangle {
                        id: sp5Cadastro
                        color: "transparent"
                        width: parent.width
                        height: txtPadding
                        anchors.left: parent.left
                        anchors.top: generoTxtCadastro.bottom
                    }

                    Rectangle {
                        id: generoUserTxtRecCadastro
                        width: dp(100)
                        height: dp(40)
                        color: backEditField
                        anchors.top: sp5Cadastro.bottom
                        anchors.left: sp2Cadastro.right

                        Text {
                            id: generoUserTxtCadastro
                            text: ""
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                genero = true
                                nativeUtils.displayAlertSheet(
                                            "Gênero",
                                            ["Feminino", "Masculino"], true)
                            }
                        }
                    }
                }

                Item {
                    id: rowAlturaCadastro
                    width: parent.width
                    height: alturaTxtCadastro.height + sp5AlturaCadastro.height
                            + sp5AlturaCadastro.height + alturaUserTxtRecCadastro.height
                    anchors.top: rowGeneroCadastro.bottom

                    Text {
                        id: alturaTxtCadastro
                        text: "Altura *"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    Rectangle {
                        id: sp2AlturaCadastro
                        color: "transparent"
                        width: userTxtPadding
                        height: alturaUserTxtRecCadastro.height
                        anchors.left: parent.left
                        anchors.top: alturaTxtCadastro.bottom
                    }

                    Rectangle {
                        id: sp5AlturaCadastro
                        color: "transparent"
                        width: parent.width
                        height: txtPadding
                        anchors.left: parent.left
                        anchors.top: alturaTxtCadastro.bottom
                    }

                    Rectangle {
                        id: alturaUserTxtRecCadastro
                        width: dp(100)
                        height: dp(40)
                        color: backEditField
                        anchors.top: sp5AlturaCadastro.bottom
                        anchors.left: sp2AlturaCadastro.right

                        Text {
                            id: alturaUserTxtCadastro
                            text: ""
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                altura = true
                                nativeUtils.displayAlertSheet(
                                            "Altura", vector(1.50, 2.30, 0.01,
                                                             true), true)
                            }
                        }
                    }
                }

                Item {
                    id: rowPesoDesejadoCadastro
                    width: parent.width
                    height: pesoDesejadoTxtCadastro.height + sp5PesoDesejadoCadastro.height
                            + sp5PesoDesejadoCadastro.height + pesoDesejadoUserTxtRecCadastro.height
                    anchors.top: rowAlturaCadastro.bottom

                    Text {
                        id: pesoDesejadoTxtCadastro
                        text: "Peso Desejado *"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    Rectangle {
                        id: sp2PesoDesejadoCadastro
                        color: "transparent"
                        width: userTxtPadding
                        height: pesoDesejadoUserTxtRecCadastro.height
                        anchors.left: parent.left
                        anchors.top: pesoDesejadoTxtCadastro.bottom
                    }

                    Rectangle {
                        id: sp5PesoDesejadoCadastro
                        color: "transparent"
                        width: parent.width
                        height: txtPadding
                        anchors.left: parent.left
                        anchors.top: pesoDesejadoTxtCadastro.bottom
                    }

                    Rectangle {
                        id: pesoDesejadoUserTxtRecCadastro
                        width: dp(100)
                        height: dp(40)
                        color: backEditField
                        anchors.top: sp5PesoDesejadoCadastro.bottom
                        anchors.left: sp2PesoDesejadoCadastro.right

                        Text {
                            id: pesoDesejadoUserTxtCadastro
                            text: ""
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                pesoDesejado = true
                                nativeUtils.displayAlertSheet("Peso Desejado",
                                                              vector(40, 120,
                                                                     1, false),
                                                              true)
                            }
                        }
                    }
                }

                Item {
                    id: rowSenhaCadastro
                    width: parent.width
                    height: senhaTxtCadastro.height + senhaUserTxtCadastro.height
                    anchors.top: rowPesoDesejadoCadastro.bottom

                    Text {
                        id: senhaTxtCadastro
                        text: "Senha *"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    AppTextField {
                        id: senhaUserTxtCadastro
                        implicitWidth: parent.width - 2 * userTxtPadding
                        placeholderText: "Senha"
                        anchors.top: senhaTxtCadastro.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        cursorColor: verdeMassa
                        showClearButton: true
                        placeholderColor: "#b4b4b4"
                        inputMethodHints: Qt.ImhPreferUppercase
                        font.capitalization: Font.Capitalize
                        echoMode: TextInput.Password
                        text: ""
                    }
                }

                Item {
                    id: rowBtnCadastrar
                    width: parent.width
                    height: btCadastro.height
                    anchors.top: rowSenhaCadastro.bottom

                    Rectangle {
                        id: sp7Cadastro
                        width: parent.width
                        height: 2 * userTxtPadding
                        anchors.top: parent.top
                        anchors.left: parent.left
                    }

                    AppButton {
                        id: btCadastro
                        text: "Cadastrar"
                        verticalMargin: 0
                        flat: false
                        anchors.top: sp7Cadastro.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        backgroundColor: verdeMassa

                        property var registro: false
                        property var cadastro: false

                        onClicked: {
                            cadastro = true

                            if (emailUserTxtCadastro.text === "" || senhaUserTxtCadastro.text
                                    === "" || nomeUserTxtCadastro.text
                                    === "" || idadeUserTxtCadastro.text
                                    === "" || generoUserTxtCadastro.text
                                    === "" || alturaUserTxtCadastro.text
                                    === "" || pesoDesejadoUserTxtCadastro.text === "") {
                                nativeUtils.displayAlertDialog(
                                            "Atenção",
                                            "Nem todos os campos obrigatórios foram preenchidos",
                                            "OK")
                            } else {
                                userID = "ufhxlzxh4XchMt0kfUVBqDajXuQ2"
                                entrarStack.pop()
                                stack.push(mainView)
                            }
                        }
                    }
                }

                Spacer {
                    id: spacer2Cadastro
                }
            }
        }

        Dialog {
            id: cadastroDialog
            title: ""
            positiveActionLabel: "OK"
            z: 1 // make sure the dialog is on top
            negativeAction: false

            property alias text: dialogText.text

            onAccepted: {
                close()
                if (btCadastro.registro && btCadastro.cadastro) {
                    stack.pop()
                    stack.push(mainView)
                    btCadastro.registro = false
                    btCadastro.cadastro = false
                }
            }

            AppText {
                id: dialogText
                anchors.fill: parent
            }
        }

        Connections {
            target: nativeUtils

            onDatePickerFinished: {

                if (accepted) {
                    var hour = ""
                    var dateStr = ""
                    var timeShift = ""

                    dateStr = date.toLocaleTimeString(Qt.locale("pt_BR"))
                    hour = parseInt(dateStr.split(":")[0])
                    timeShift = Qt.formatDateTime(date, "t")

                    if (hour === 00) {
                        idadeUserTxtCadastro.text = Qt.formatDate(date,
                                                                  "dd/MM/yyyy")
                        idadeUserTxtCadastro.color = "black"
                    } else {
                        Date.prototype.addHours = function (h) {
                            this.setTime(this.getTime() + (h * 60 * 60 * 1000))
                            return this
                        }
                        idadeUserTxtCadastro.text = Qt.formatDate(
                                    date.addHours(24 - hour), "dd/MM/yyyy")
                        idadeUserTxtCadastro.color = "black"
                    }
                }
            }

            onAlertSheetFinished: {
                if (pesoDesejado) {
                    pesoDesejadoUserTxtCadastro.text = (40 + (index * 1)).toFixed(
                                0)
                    pesoDesejado = false
                }
                if (genero) {
                    switch (index) {
                    case 0: {
                        generoUserTxtCadastro.text = "Feminino"
                        break
                    }
                    case 1: {
                        generoUserTxtCadastro.text = "Masculino"
                        break
                    }
                    }
                    genero = false
                }
                if (altura) {
                    alturaUserTxtCadastro.text = (1.50 + (index * 0.01)).toFixed(
                                2)
                    altura = false
                }
            }
        }
    }

    ScrollIndicator {
        flickable: scrollCadastro
    }
}
