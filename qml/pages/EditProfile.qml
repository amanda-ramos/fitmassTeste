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
    id: editProfilePage
    title: "Editar Perfil"
    height: screenSizeY
    width: screenSizeX

    property color txtTitleColor: white
    property color txtUserColor: greenLight
    property color backEditField: grayLight

    property var pathImage: ""
    property var editTextMargin: root.dp(20)
    property var totalDeMedidas

    property bool inicial: true
    property bool genero: false
    property bool pesoDesejado: false
    property bool altura: false
    property bool foto: false

    // Função para criar vetores de altura e peso
    function vector(min, max, step, decimos){
        var j = 0;
        var i = 0;
        var valores = [];

        for (i = min; i <=max; i = i + step) {
            if(decimos)
                valores[j] = i.toFixed(2);
            else
                valores[j] = i.toFixed(0);

                j++;
        }
        return valores;
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

    // Ícones na barra de navegação superior
    rightBarItem: NavigationBarRow {
        id: rightNavBarRow

       // Ícone para salvar as alterações de perfil
        IconButtonBarItem {
            title: "Salvar Perfil"
            icon: IconType.check
            id: saveProfileBtn

            property bool saveBtn: false

            onClicked: {

                var key = "users/" + root.userID;
                var birthday = Qt.formatDateTime(Date.fromLocaleString(Qt.locale(), idadeUserTxt.tfTextText, "dd/MM/yyyy"), "dd/MM/yyyy");

                  dbFitmass.setValue(key, {
                       "nome": nomeUserTxt.tfTextText,
                       "email": emailUserTxt.tfTextText,
                       "age": calculateAge(Date.fromLocaleString(Qt.locale(), birthday, "dd/MM/yyyy")),
                       "height": alturaUserTxt.cbTextSelected,
                       "desiredWeight": pesoDesejadoUserTxt.cbTextSelected,
                       "totalMeasure": totalDeMedidas,
                       "gender": generoUserTxt.cbTextSelected,
                       "birthday": birthday,
                       "photo": pathImage,
                       "userID": root.userID
                  }, function(success, message) {
                           if(success) {
                             console.log("EDITAR PERFIL - sucesso ao salvar os dados")
                                editProfile = true;
                             nativeUtils.displayAlertDialog("Sucesso!", "Os dados foram alterados.", "OK")

                           } else {
                             console.log("CADASTRO - registro d - DB write error:", message)
                           }
                         })
            }
        }
    }

    AppFlickable {
        id: scrollProfile
        anchors.fill: parent
        contentHeight: contentProfile.height

        MouseArea {
            anchors.fill: parent
            onClicked: scrollProfile.forceActiveFocus()
        }

        Item {
            id: contentProfile
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            height: rowImageProfile.height + rowNome.height + rowEmail.height
                    + rowIdade.height + rowGenero.height + rowAltura.height
                    + rowPesoDesejado.height + spacer1.height + spacer2.height

            Item {
                width: parent.width

                Item {
                    id: rowImageProfile
                    width: parent.width
                    height: userImage1.height + space1.height
                    anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle {
                        id: space1
                        width: parent.width
                        height: root.dp(25)
                        color: bgColor
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Item {
                        id: userImage1
                        width: parent.width / 2
                        height: userImageBack.height
                        anchors.top: space1.bottom
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
                            id: userImage
                            property string iconFontName: Theme.iconFont.name
                            width: userImageBack.width - root.dp(10)
                            height: width
                            anchors.centerIn: userImageBack
                            placeholderImage: "\uf007" // user
                            source: ""
                        } // User Image


                    }

                    Item {
                        id: userImage2
                        width: parent.width / 2
                        height: userImage1.height
                        anchors.top: space1.bottom
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
                                id: userImageBtn
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: spacer.bottom

                                btnColor: bgColor
                                btnBorderColor: userImageBtnMouseArea.pressed ? grayLight : greenDark
                                btnRadius: radiusText
                                btnText: "Carregar foto"

                                MouseArea {
                                    id: userImageBtnMouseArea
                                    anchors.fill: parent

                                    property bool shownEditPhotoDialog: false

                                    onClicked: {
                                        foto = true
                                        shownEditPhotoDialog = true
                                        userImage.forceActiveFocus();
                                        nativeUtils.displayAlertSheet(
                                                    "",
                                                    ["Escolher Foto", "Tirar Foto", "Apagar Foto"],
                                                    true)
                                    }
                                }
                            }
                        }
                    } // Coluna imagem do usuário
                } // Linha imagem do usuário

                Spacer {
                    id: spacer1
                    width: parent.width
                    anchors.top: rowImageProfile.bottom
                }

                Item {
                    id: rowNome
                    anchors.top: spacer1.bottom
                    width: parent.width
                    height: root.dp(70)
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomTextField {
                        id: nomeUserTxt
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        tfTitleColor: txtTitleColor
                        tfTextColor: txtUserColor
                        tfColor: backEditField
                        tfRadius: radiusText
                        tfTextTitle: "Nome: *"
                        tfTextText: ""
                        tfTextType:  Qt.ImhNoPredictiveText
                    }
                } // Campo de Nome

                Item {
                    id: rowEmail
                    anchors.top: rowNome.bottom
                    width: parent.width
                    height: root.dp(70)
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomTextField {
                        id: emailUserTxt
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        tfTitleColor: txtTitleColor
                        tfTextColor: txtUserColor
                        tfColor: backEditField
                        tfRadius: radiusText
                        tfTextTitle: "E-mail: *"
                        tfTextType: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText | Qt.ImhPreferLowercase | Qt.ImhEmailCharactersOnly
                        tfTextText: ""
                    }
                } // Campo de E-mail

                Item {
                    id: rowIdade
                    anchors.top: rowEmail.bottom
                    width: parent.width
                    height: root.dp(70)
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomTextField {
                        id: idadeUserTxt
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        tfTitleColor: txtTitleColor
                        tfTextColor: txtUserColor
                        tfColor: backEditField
                        tfRadius: radiusText
                        tfTextTitle: "Nascimento: *"
                        tfTextMask: "00/00/0000"
                        tfTextText: ""
                        tfTextType: Qt.ImhDigitsOnly
                    }
                } // Campo de Aniversário / Idade

                Item {
                    id: rowGenero
                    width: parent.width
                    height: root.dp(70)
                    anchors.top: rowIdade.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomComboBox {
                        id: generoUserTxt
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        cbTextTitle: "Gênero: *"
                        cbTitleColor: txtTitleColor
                        cbTextColor: txtUserColor
                        cbColor: backEditField
                        cbRadius: radiusText
                        cbTextSelected: ""

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                genero = true
                                generoUserTxt.forceActiveFocus()
                                nativeUtils.displayAlertSheet(
                                            "Gênero",
                                            ["Feminino", "Masculino"], true)
                            }
                        }
                    }
                } // Campo de Gênero

                Item {
                    id: rowAltura
                    width: parent.width
                    height: root.dp(70)
                    anchors.top: rowGenero.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomComboBox {
                        id: alturaUserTxt
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        cbTextTitle: "Altura: *"
                        cbTitleColor: txtTitleColor
                        cbTextColor: txtUserColor
                        cbColor: backEditField
                        cbRadius: radiusText
                        cbTextSelected: ""

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                altura = true
                                alturaUserTxt.forceActiveFocus()
                                nativeUtils.displayAlertSheet(
                                            "Altura", vector(1.50, 2.30, 0.01,
                                                             true), true)
                            }
                        }
                    }
                } // Campo de Altura

                Item {
                    id: rowPesoDesejado
                    width: parent.width
                    height: root.dp(70)
                    anchors.top: rowAltura.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomComboBox {
                        id: pesoDesejadoUserTxt
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        cbTextTitle: "Peso Desejado: *"
                        cbTitleColor: txtTitleColor
                        cbTextColor: txtUserColor
                        cbColor: backEditField
                        cbRadius: radiusText
                        cbTextSelected: ""

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                pesoDesejado = true
                                pesoDesejadoUserTxt.forceActiveFocus()
                                nativeUtils.displayAlertSheet("Peso Desejado",
                                                              vector(40, 120,
                                                                     1, false),
                                                              true)
                            }
                        }
                    }
                } // Campo de Peso Desejado

                Spacer {
                    id: spacer2
                }
            }

            Component.onCompleted: {
                indicator.visible = true
                indicator.startAnimating()
                dbFitmass.getValue(keyUser)
            }
        }

        Connections {
            target: nativeUtils

            // @disable-check M16
            onAlertSheetFinished: {
                if(pesoDesejado){
                    pesoDesejadoUserTxt.cbTextSelected = (40 + (index * 1)).toFixed(0);
                    pesoDesejado = false;
                }

                if(genero){
                    switch (index) {
                        case 0: {
                            generoUserTxt.cbTextSelected = "Feminino"
                            break;
                        }
                        case 1: {
                            generoUserTxt.cbTextSelected = "Masculino"
                            break;
                        }
                    }
                    genero = false;
                }

                if(altura){
                    alturaUserTxt.cbTextSelected = (1.50 + (index * 0.01)).toFixed(2);
                    altura = false;
                }

                if(foto){
                    if (userImageBtnMouseArea.shownEditPhotoDialog) {
                        if (index == 0)
                            nativeUtils.displayImagePicker(
                                        qsTr("Choose Image")) // Choose image
                        else if (index == 1)
                            nativeUtils.displayCameraPicker(
                                        "Take Photo") // Take from Camera
                        else if (index == 2){
                          userImage.source = "" // Reset
                          pathImage = ""
                        }
                        userImageBtnMouseArea.shownEditPhotoDialog = false
                    }
                }

                if(editProfile){
                    editProfile = false
                    profileStack.pop()
                    indicator.stopAnimating()
                    indicator.visible = false
                }
            }

            // @disable-check M16
            onImagePickerFinished: {
                console.debug("Image picker finished with path:", path)

                if(accepted){
                    //userImageCadastro.source = Qt.resolvedUrl(path)

                    indicator.visible = true
                    indicator.startAnimating()
                    storageFitmass.uploadFile(path, "userPhoto" + Date.now() + ".png", function(progress, finished, success, downloadUrl) {
                           if(!finished){
                               console.log("Firebase Storage: progresso " + progress.toFixed(2))
                           } else if(success) {

                               userImage.source = downloadUrl
                               pathImage = downloadUrl;
                               console.log("Sucesso - Path: " + pathImage)
                               indicator.stopAnimating()
                               indicator.visible = false
                           } else {
                             console.log("Falha ao carregar imagem  no Firebase Storage" + message)
                               indicator.stopAnimating()
                               indicator.visible = false
                           }
                  })
                }
            }

            // @disable-check M16
            onCameraPickerFinished: {
                console.debug("Camera picker finished with path:", path)

                if(accepted){
                    //userImageCadastro.source = Qt.resolvedUrl(path)

                    indicator.visible = true
                    indicator.startAnimating()
                    storageFitmass.uploadFile(path, "userPhoto.png", function(progress, finished, success, downloadUrl) {
                           if(!finished){
                               console.log("Firebase Storage: progresso " + progress.toFixed(2))
                           } else if(success) {
                               console.log("Sucesso - Path: " + pathImage)
                             userImage.source = downloadUrl
                             pathImage = downloadUrl
                               indicator.stopAnimating()
                               indicator.visible = false
                           } else {
                             console.log("Falha ao carregar imagem  no Firebase Storage" + message)
                               indicator.stopAnimating()
                               indicator.visible = false
                           }
                  })
                }
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

        onReadCompleted: {
            if(success) {
                console.debug("EDITAR PERFIL - Read value " +  value + " for key " + key)
                indicator.stopAnimating()
                indicator.visible = false

                nomeUserTxt.tfTextText = value.nome
                emailUserTxt.tfTextText = value.email
                idadeUserTxt.tfTextText = value.birthday
                generoUserTxt.cbTextSelected = value.gender
                alturaUserTxt.cbTextSelected = value.height
                pesoDesejadoUserTxt.cbTextSelected = value.desiredWeight
                userImage.source = value.photo
                totalDeMedidas = value.totalMeasure
                pathImage = value.photo

            } else {
                console.debug("EDITAR PERFIL - Error with message: "  + value)
                nativeUtils.displayAlertDialog("Error!", value, "OK")
            }
        }
    }

    ScrollIndicator {
        flickable: scrollProfile
    }
}
