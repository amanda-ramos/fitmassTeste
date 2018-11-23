import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2
import QtMultimedia 5.5
import QtQml 2.11
import VPlayPlugins 1.0

import "../common"
import "../pages"

Page {
    id: cadastroPage
    title: "Cadastro"
    height: screenSizeY
    width: screenSizeX

    property color txtColor: greenDark

    property var pathImage: ""

    property bool genero: false
    property bool pesoDesejado: false
    property bool altura: false
    property bool foto: false

    // Função para criar vetores de altura e peso
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

    // Função para calcular idade
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
                        + rowSenhaCadastro.height + rowBtnCadastrar.height + root.dp(32)

                Item {
                    id: rowImageProfileCadastro
                    width: parent.width
                    height: userImage1Cadastro.height + space1Cadastro.height
                    anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle {
                        id: space1Cadastro
                        width: parent.width
                        height: root.dp(25)
                        color: bgColor
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Item {
                        id: userImage1Cadastro
                        width: parent.width / 2
                        height: userImageBack.height
                        anchors.top: space1Cadastro.bottom
                        anchors.left: parent.left

                        Image {
                            id: userImageBack
                            width: parent.width - root.dp(30)
                            height: width
                            anchors.top: parent.top
                            anchors.right: parent.right
                            source: "../../assets/circle.png"
                            z: -1
                        }

                        UserImage {
                            id: userImageCadastro
                            property string iconFontName: Theme.iconFont.name
                            width: userImageBack.width - root.dp(10)
                            height: width
                            anchors.centerIn: userImageBack
                            placeholderImage: "\uf007" // user
                            source: ""
                        }
                    } // Photo View

                    Item {
                        id: userImage2Cadastro
                        width: parent.width / 2
                        height: userImage1Cadastro.height
                        anchors.top: space1Cadastro.bottom
                        anchors.right: parent.right

                        Item {
                            id: rowBtnFoto
                            width: parent.width
                            height: root.dp(70)
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter

                            Rectangle {
                                id: spacer
                                width: parent.width
                                height: root.dp(20)
                                color: "transparent"
                                anchors.left: parent.left
                                anchors.top: parent.top
                            }

                            CustomButtom {
                                id: userImageCadastroBtn
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: spacer.bottom

                                btnColor: bgColor
                                btnBorderColor: userImageCadastroBtnMouseArea.pressed ? grayLight : greenDark
                                btnRadius: radiusText
                                btnText: "Carregar foto"

                                MouseArea {
                                    id: userImageCadastroBtnMouseArea
                                    anchors.fill: parent
                                    onClicked: {
                                        foto = true
                                        userImageCadastro.forceActiveFocus();
                                        nativeUtils.displayAlertSheet(
                                                    "",
                                                    ["Escolher Foto", "Tirar Foto"],
                                                    true)
                                    }
                                }
                            }

                            AppActivityIndicator {
                                id: indicatorCadastro
                                z: 1
                                animating: false
                                visible: false
                                anchors.horizontalCenter: userImageCadastroBtn.horizontalCenter
                                anchors.verticalCenter: userImageCadastroBtn.verticalCenter
                                hidesWhenStopped: true
                                color: greenDark
                            }
                        }
                    } // Botão para foto
                } // Imagem do Usuário

                Spacer {
                    id: spacer1Cadastro
                    width: parent.width
                    anchors.top: rowImageProfileCadastro.bottom
                    colorRec: bgColor
                }

                Item {
                    id: rowNomeCadastro
                    anchors.top: spacer1Cadastro.bottom
                    width: parent.width
                    height: root.dp(70)
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomTextField {
                        id: nomeUserTxtCadastro
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        tfTitleColor: white
                        tfTextColor: greenLight
                        tfColor: grayLight
                        tfRadius: radiusText
                        tfTextTitle: "Nome: *"
                        tfTextText: ""
                        tfTextType:  Qt.ImhNoPredictiveText
                    }
                } // Campo de Nome

                Item {
                    id: rowEmailCadastro
                    anchors.top: rowNomeCadastro.bottom
                    width: parent.width
                    height: root.dp(70)
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomTextField {
                        id: emailUserTxtCadastro
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        tfTitleColor: white
                        tfTextColor: greenLight
                        tfColor: grayLight
                        tfRadius: radiusText
                        tfTextTitle: "E-mail: *"
                        tfTextType: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText | Qt.ImhPreferLowercase | Qt.ImhEmailCharactersOnly
                        tfTextText: ""
                    }
                } // Campo de E-mail

                Item {
                    id: rowIdadeCadastro
                    anchors.top: rowEmailCadastro.bottom
                    width: parent.width
                    height: root.dp(70)
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomTextField {
                        id: idadeUserTxtCadastro
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        tfTitleColor: white
                        tfTextColor: greenLight
                        tfColor: grayLight
                        tfRadius: radiusText
                        tfTextTitle: "Nascimento: *"
                        tfTextType: Qt.ImhDigitsOnly
                        tfTextMask: "00/00/0000"
                        tfTextText: ""
                    }
                } // Campo de Aniversário / Idade

                Item {
                    id: rowGeneroCadastro
                    width: parent.width
                    height: root.dp(70)
                    anchors.top: rowIdadeCadastro.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomComboBox {
                        id: generoUserTxtCadastro
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        cbTextTitle: "Gênero: *"
                        cbTitleColor: white
                        cbTextColor: greenLight
                        cbColor: grayLight
                        cbRadius: radiusText
                        cbTextSelected: "Selecione"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                genero = true
                                generoUserTxtCadastro.forceActiveFocus()
                                nativeUtils.displayAlertSheet(
                                            "Gênero",
                                            ["Feminino", "Masculino"], true)
                            }
                        }
                    }
                } // Campo de Gênero

                Item {
                    id: rowAlturaCadastro
                    width: parent.width
                    height: root.dp(70)
                    anchors.top: rowGeneroCadastro.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomComboBox {
                        id: alturaUserTxtCadastro
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        cbTextTitle: "Altura: *   (m)"
                        cbTitleColor: white
                        cbTextColor: greenLight
                        cbColor: grayLight
                        cbRadius: radiusText
                        cbTextSelected: "Selecione"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                altura = true
                                alturaUserTxtCadastro.forceActiveFocus()
                                nativeUtils.displayAlertSheet(
                                            "Altura", vector(1.50, 2.30, 0.01,
                                                             true), true)
                            }
                        }
                    }
                }  // Campo de Altura

                Item {
                    id: rowPesoDesejadoCadastro
                    width: parent.width
                    height: root.dp(70)
                    anchors.top: rowAlturaCadastro.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomComboBox {
                        id: pesoDesejadoUserTxtCadastro
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        cbTextTitle: "Peso Desejado: *   (kg)"
                        cbTitleColor: white
                        cbTextColor: greenLight
                        cbColor: grayLight
                        cbRadius: radiusText
                        cbTextSelected: "Selecione"

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                pesoDesejado = true
                                pesoDesejadoUserTxtCadastro.forceActiveFocus()
                                nativeUtils.displayAlertSheet("Peso Desejado",
                                                              vector(40, 120,
                                                                     1, false),
                                                              true)
                            }
                        }
                    }
                } // Campo de Peso Desejado

                Item {
                    id: rowSenhaCadastro
                    anchors.top: rowPesoDesejadoCadastro.bottom
                    width: parent.width
                    height: root.dp(70)
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomTextField {
                        id: senhaUserTxtCadastro
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        tfTitleColor: white
                        tfTextColor: greenLight
                        tfColor: grayLight
                        tfRadius: radiusText
                        tfTextTitle: "Senha: *"
                        tfTextType: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText | Qt.ImhPreferLowercase | Qt.ImhHiddenText
                        tfEchoMode: TextInput.Password
                        tfTextText: ""
                    }
                } // Campo de Senha

                Item {
                    id: rowBtnCadastrar
                    width: parent.width
                    height: root.dp(70)
                    anchors.top: rowSenhaCadastro.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle {
                        id: spacer2
                        width: parent.width
                        height: root.dp(20)
                        color: "transparent"
                        anchors.left: parent.left
                        anchors.top: parent.top
                    }

                    CustomButtom {
                        id: btCadastro
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: spacer2.bottom

                        btnColor: bgColor
                        btnBorderColor: btCadastroMouseArea.pressed ? grayLight : greenDark
                        btnRadius: radiusText
                        btnText: "Cadastrar"

                        MouseArea {
                            id: btCadastroMouseArea
                            anchors.fill: parent
                            onClicked: {
                                // validação dos campos obrigatórios
                                if (emailUserTxtCadastro.tfTextText === "" || senhaUserTxtCadastro.tfTextText
                                        === "" || nomeUserTxtCadastro.tfTextText
                                        === "" || idadeUserTxtCadastro.tfTextText
                                        === "" || generoUserTxtCadastro.cbTextSelected
                                        === "" || alturaUserTxtCadastro.cbTextSelected
                                        === "" || pesoDesejadoUserTxtCadastro.cbTextSelected === "") {
                                    nativeUtils.displayAlertDialog(
                                                "Atenção",
                                                "Nem todos os campos obrigatórios foram preenchidos",
                                                "OK")
                                } else {
                                    // resgistro do e-mail e senha do usuário em questão
                                    firebaseAuth.registerUser(emailUserTxtCadastro.tfTextText, senhaUserTxtCadastro.tfTextText)
                                }
                            }
                        }
                    }
                } // Botão para salvar o cadastro

                Spacer {
                    id: spacer2Cadastro
                    anchors.top: rowBtnCadastrar.bottom
                    colorRec: bgColor
                }
            }
        }

        Connections {
            target: nativeUtils

            // @disable-check M16
            onAlertSheetFinished: {
                var value
                if(index>-1) {
                    if (pesoDesejado) {
                        value = (40 + (index * 1)).toFixed(0)
                        pesoDesejadoUserTxtCadastro.cbTextSelected = value
                        pesoDesejado = false
                    }
                    if (genero) {
                        switch (index) {
                            case 0: {
                                generoUserTxtCadastro.cbTextSelected = "Feminino"
                                break
                            }
                            case 1: {
                                generoUserTxtCadastro.cbTextSelected = "Masculino"
                                break
                            }
                        }
                        genero = false
                    }
                    if (altura) {
                        value = (1.50 + (index * 0.01)).toFixed(2)
                        alturaUserTxtCadastro.cbTextSelected = value
                        altura = false
                    }
                    if(foto){
                        if (index == 0)
                            nativeUtils.displayImagePicker("Choose Image") // Choose image
                        else if (index == 1)
                            nativeUtils.displayCameraPicker("Take Photo") // Take from Camera
                        foto = false
                    }
                }
                foto = false
                altura = false
                genero = false
                pesoDesejado = false
            }

            // @disable-check M16
            onCameraPickerFinished: {
                console.debug("Camera picker finished with path:",path)

                if (accepted) {
                    //userImageCadastro.source = Qt.resolvedUrl(path)

                    userImageCadastroBtn.visible = false
                    indicatorCadastro.visible = true
                    indicatorCadastro.startAnimating()
                    // Salva a imagem no Storage do Firebase
                    storageFitmass.uploadFile(
                                path, "userPhoto.png",
                                function (progress, finished, success, downloadUrl) {
                                    if (!finished) {
                                        console.log("Firebase Storage: progresso " + progress.toFixed(2))
                                    } else if (success) {
                                        console.log("Sucesso - Path: " + pathImage)
                                        userImageCadastro.source = downloadUrl
                                        pathImage = downloadUrl
                                        indicatorCadastro.stopAnimating()
                                        indicatorCadastro.visible = false
                                        userImageCadastroBtn.visible = true
                                    } else {
                                        console.log("Falha ao carregar imagem  no Firebase Storage" + message)
                                        indicatorCadastro.stopAnimating()
                                        indicatorCadastro.visible = false
                                        userImageCadastroBtn.visible = true
                                    }
                                })
                }
            }

            // @disable-check M16
            onImagePickerFinished: {
                console.debug("Image picker finished with path:", path)

                if (accepted) {
                    //userImageCadastro.source = Qt.resolvedUrl(path)

                    userImageCadastroBtn.visible = false
                    indicatorCadastro.visible = true
                    indicatorCadastro.startAnimating()
                    // Salva a imagem no Storage do Firebase
                    storageFitmass.uploadFile(path, "userPhoto" + Date.now() + ".png",
                                function (progress, finished, success, downloadUrl) {
                                    if (!finished) {
                                        console.log("Firebase Storage: progresso " + progress.toFixed(2))
                                    } else if (success) {
                                        userImageCadastro.source = downloadUrl
                                        pathImage = downloadUrl
                                        console.log("Sucesso - Path: " + pathImage)
                                        indicatorCadastro.stopAnimating()
                                        indicatorCadastro.visible = false
                                        userImageCadastroBtn.visible = true
                                    } else {
                                        console.log("Falha ao carregar imagem  no Firebase Storage" + message)
                                        indicatorCadastro.stopAnimating()
                                        indicatorCadastro.visible = false
                                        userImageCadastroBtn.visible = true
                                    }
                                })
                }
            }
        }
    }

    FirebaseAuth {
        id: firebaseAuth

        config: FirebaseConfig {
             //get these values from the firebase console
             projectId: "fitmass-2018"
             databaseUrl: "https://fitmassapp.firebaseio.com/"

             //platform dependent - get these values from the google-services.json / GoogleService-info.plist
             apiKey:        Qt.platform.os === "android" ? "AIzaSyBh6Kb12xUnOsQDTP2XEbSKtuGsBfmCyic" : "AIzaSyBh6Kb12xUnOsQDTP2XEbSKtuGsBfmCyic"
             applicationId: Qt.platform.os === "android" ? "1:519505351771:android:28365556727f1ea3" : "1:519505351771:ios:28365556727f1ea3"
           }

        onLoggedIn: {
            if(success){
                console.log("CADASTRO - login - Sucesso ao fazer o login!");
                root.userID = firebaseAuth.userId;
                entrarStack.pop();
                stack.push(mainView);
                indicator.stopAnimating()
                indicator.visible = false
            } else {
                console.log("CADASTRO - login - Error: " + message)
            }
        }

        onUserRegistered: {
            indicator.stopAnimating()

            if(success){
                console.log("CADASTRO - registro es - Sucesso ao fazer o registro!");
                root.userID = firebaseAuth.userId;

                  var key = "users/" + root.userID;
                  var birthday = Qt.formatDateTime(Date.fromLocaleString(Qt.locale(), idadeUserTxtCadastro.tfTextText, "dd/MM/yyyy"), "dd/MM/yyyy");

                    dbFitmass.setValue(key, {
                         "nome": nomeUserTxtCadastro.tfTextText,
                         "email": emailUserTxtCadastro.tfTextText,
                         "age": calculateAge(Date.fromLocaleString(Qt.locale(), birthday, "dd/MM/yyyy")),
                         "height": alturaUserTxtCadastro.cbTextSelected,
                         "desiredWeight": pesoDesejadoUserTxtCadastro.cbTextSelected,
                         "totalMeasure": "0",
                         "gender": generoUserTxtCadastro.cbTextSelected,
                         "birthday": birthday,
                         "photo": pathImage,
                         "userID": root.userID
                    }, function(success, message) {
                             if(success) {
                               console.log("CADASTRO - registro d - sucesso")

                                 firebaseAuth.loginUser(emailUserTxtCadastro.tfTextText, senhaUserTxtCadastro.tfTextText)

                             } else {
                               console.log("CADASTRO - registro d - DB write error:", message)
                             }
                           })
            } else {
                console.log("CADASTRO - registro es - Error: " + message);
                nativeUtils.displayAlertDialod("Atenção", "CADASTRO - registro - Erro: " + message, "OK")
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

        onWriteCompleted: {
            if(success)
                    console.log("CADASTRO - Sucesso ao salvar dados no db!");
            else
                console.log("CADASTRO - DB write error:", message)
        }
    }

    ScrollIndicator {
        flickable: scrollCadastro
    }
}
