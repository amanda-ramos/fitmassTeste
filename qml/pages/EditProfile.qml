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
                // Código para salvar os dados no banco de dados
                //
                //

                // Temporário: aparece uma msg de sucesso
                editProfile = true;
                saveBtn = true;
                nativeUtils.displayAlertDialog("Sucesso!", "Os dados foram alterados.", "OK")
            }

            Connections {
                target: nativeUtils
                onAlertDialogFinished: {
                    if(saveProfileBtn.saveBtn)
                        profileStack.pop();
                }
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
                // Código para recuperar dados do banco de dados
                //
                //

                // Temporário: pega os valores de um vetor fixo no Main.qml
                nomeUserTxt.tfTextText = user[0]
                emailUserTxt.tfTextText = user[1]
                idadeUserTxt.tfTextText = user[2]
                generoUserTxt.cbTextSelected = user[3]
                alturaUserTxt.cbTextSelected = user[4]
                pesoDesejadoUserTxt.cbTextSelected = user[5]
                userImage.source = user[6]
            }
        }

        Connections {
            target: nativeUtils

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
            }

            // @disable-check M16
            onImagePickerFinished: {
                console.debug("Image picker finished with path:", path)

                if(accepted){
                    //userImageCadastro.source = Qt.resolvedUrl(path)
                    storageFitmass.uploadFile(path, "userPhoto" + Date.now() + ".png", function(progress, finished, success, downloadUrl) {
                           if(!finished){
                               console.log("Firebase Storage: progresso " + progress.toFixed(2))
                           } else if(success) {

                               userImage.source = downloadUrl
                               pathImage = downloadUrl;
                               console.log("Sucesso - Path: " + pathImage)
                           } else {

                             console.log("Falha ao carregar imagem  no Firebase Storage" + message)
                           }
                  })
                }
            }

            // @disable-check M16
            onCameraPickerFinished: {
                console.debug("Camera picker finished with path:", path)

                if(accepted){
                    //userImageCadastro.source = Qt.resolvedUrl(path)
                    storageFitmass.uploadFile(path, "userPhoto.png", function(progress, finished, success, downloadUrl) {
                           if(!finished){
                               console.log("Firebase Storage: progresso " + progress.toFixed(2))

                           } else if(success) {
                               console.log("Sucesso - Path: " + pathImage)
                             userImage.source = downloadUrl
                             pathImage = downloadUrl;
                           } else {
                             console.log("Falha ao carregar imagem  no Firebase Storage" + message)
                           }
                  })
                }
            }
        }
    }


    ScrollIndicator {
        flickable: scrollProfile
    }
}
