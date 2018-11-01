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
    title: "Editar"
    height: 960
    width: 640

    property color txtColor: verdeMassa
    property color userTxtColor: "#4b4b4b"
    property color backEditField: "#efefef"

    property var pathImage: ""

    property var txtPadding: dp(10)
    property var userTxtPadding: dp(20)
    property var editTextMargin: dp(20)

    property bool inicial: true
    property bool genero: false
    property bool pesoDesejado: false
    property bool altura: false


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

    rightBarItem: NavigationBarRow {
        id: rightNavBarRow

        IconButtonBarItem {

            property var saveBtn: false

            onClicked: {
                editProfile = true;
                saveBtn = true;
                nativeUtils.displayAlertDialog("Sucesso!", "Os dados foram alterados.", "OK")
            }

            Connections {
                target: nativeUtils
                onAlertDialogFinished: {
                    if(saveProfileBtn.saveBtn)  profileStack.pop();
                }
            }

            title: "Salvar Perfil"
            icon: IconType.check
            id: saveProfileBtn
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
                        height: dp(25)
                        color: "white"
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Item {
                        id: userImage1
                        width: parent.width / 2
                        height: userImage.height
                        anchors.top: space1.bottom
                        anchors.left: parent.left

                        UserImage {
                            id: userImage
                            property string iconFontName: Theme.iconFont.name
                            width: dp(150)
                            height: width

                            //anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: space1.bottom
                            anchors.right: parent.right

                            placeholderImage: "\uf007" // user
                        } // User Image
                    }

                    Item {
                        id: userImage2
                        width: parent.width / 2
                        height: userImage1.height
                        anchors.top: space1.bottom
                        anchors.right: parent.right

                        AppButton {
                            id: userImageBtn
                            text: "Alterar foto"
                            onClicked:
                            {
                                shownEditPhotoDialog = true;
                                nativeUtils.displayAlertSheet("", ["Escolher Foto", "Tirar Foto", "Apagar Foto"], true)
                            }
                            verticalMargin: 0
                            flat: false
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left

                            property bool shownEditPhotoDialog: false

                            Connections {
                              target: nativeUtils

                              // @disable-check M16
                              onAlertSheetFinished: {
                                if (userImageBtn.shownEditPhotoDialog) {
                                  if (index == 0)
                                    nativeUtils.displayImagePicker(qsTr("Choose Image")) // Choose image
                                  else if (index == 1)
                                    nativeUtils.displayCameraPicker("Take Photo") // Take from Camera
                                  else if (index == 2){
                                    userImage.source = "" // Reset
                                    pathImage = ""
                                  }
                                  userImageBtn.shownEditPhotoDialog = false
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
                    }
                }

                Spacer {
                    id: spacer1
                    width: parent.width
                    anchors.top: rowImageProfile.bottom
                }

                Item {
                    id: rowNome
                    width: parent.width
                    height: nomeTxt.height + nomeUserTxt.height
                    anchors.top: spacer1.bottom

                    Rectangle {
                        id: recLine
                        anchors.centerIn: parent
                        width: parent.width - dp(40)
                        height: nomeUserTxt.height
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
                        id: nomeTxt
                        text: "Nome"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    TextEdit {
                        id: nomeUserTxt
                        width: parent.width - dp(40)
                        text: ""
                        color: userTxtColor
                        anchors.left: parent.left
                        padding: userTxtPadding
                        anchors.top: nomeTxt.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter
                        cursorVisible: true
                    }
                }

                Item {
                    id: rowEmail
                    width: parent.width
                    height: emailTxt.height + emailUserTxt.height
                    anchors.top: rowNome.bottom

                    Rectangle {
                        anchors.centerIn: parent
                        width: parent.width - dp(40)
                        height: emailUserTxt.height
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
                        id: emailTxt
                        text: "E-mail"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    TextEdit {
                        id: emailUserTxt
                        width: parent.width - dp(40)
                        text: ""
                        color: userTxtColor
                        anchors.left: parent.left
                        padding: userTxtPadding
                        anchors.top: emailTxt.bottom
                        // cursorVisible: true
                        inputMethodHints: Qt.ImhEmailCharactersOnly
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                Item {
                    id: rowIdade
                    width: parent.width
                    height: idadeTxt.height + idadeUserTxtRec.height + sp2Idade.height + sp3Idade.height
                    anchors.top: rowEmail.bottom

                    Text {
                        id: idadeTxt
                        text: "Nascimento *"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    Rectangle {
                        id: sp1
                        color: "transparent"
                        width: userTxtPadding
                        height: idadeUserTxt.height
                        anchors.left: parent.left
                        anchors.top: idadeTxt.bottom
                    }

                    Rectangle {
                        id: sp2Idade
                        color: "transparent"
                        width: parent.width
                        height: txtPadding
                        anchors.left: parent.left
                        anchors.top: idadeTxt.bottom
                    }

                    Rectangle {
                        id: sp3Idade
                        color: "transparent"
                        width: parent.width
                        height: txtPadding
                        anchors.left: parent.left
                        anchors.top: idadeUserTxt.bottom
                    }

                    Rectangle{
                        id: idadeUserTxtRec
                        width: dp(100)
                        height: dp(40)
                        color: backEditField
                        anchors.top: sp2Idade.bottom
                        anchors.left: sp1.right

                                  Text {
                                      id: idadeUserTxt
                                      anchors.centerIn: parent
                                      text: ""
                                      color: "black"
                                  }

                                      MouseArea {
                                          anchors.fill: parent

                                          onClicked: {
                                              nativeUtils.displayDatePicker(Qt.formatDate(Date.fromLocaleString(Qt.locale(), idadeUserTxt.text, "dd/MM/yyyy"), "yyyy-MM-dd"))
                                          }
                                      }
                    }
                }

                Item {
                    id: rowGenero
                    width: parent.width
                    height: emailTxt.height + emailUserTxt.height
                    anchors.top: rowIdade.bottom

                    Text {
                        id: generoTxt
                        text: "Gênero *"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    Rectangle {
                        id: sp2
                        color: "transparent"
                        width: userTxtPadding
                        height: generoUserTxt.height
                        anchors.left: parent.left
                        anchors.top: generoTxt.bottom
                    }

                    Rectangle {
                        id: sp5
                        color: "transparent"
                        width: parent.width
                        height: txtPadding
                        anchors.left: parent.left
                        anchors.top: generoTxt.bottom
                    }

                    Rectangle{
                        id: generoUserTxtRec
                        width: dp(100)
                        height: dp(40)
                        color: backEditField
                        anchors.top: sp5.bottom
                        anchors.left: sp2.right

                        Text {
                            id: generoUserTxt
                            text: ""
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                genero = true;
                                nativeUtils.displayAlertSheet("Gênero", ["Feminino", "Masculino"], true)
                            }
                        }
                    }
                }

                Item {
                    id: rowAltura
                    width: parent.width
                    height: alturaTxt.height + sp5Altura.height + sp5Altura.height + alturaUserTxtRec.height
                    anchors.top: rowGenero.bottom

                    Text {
                        id: alturaTxt
                        text: "Altura *"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    Rectangle {
                        id: sp2Altura
                        color: "transparent"
                        width: userTxtPadding
                        height: alturaUserTxtRec.height
                        anchors.left: parent.left
                        anchors.top: alturaTxt.bottom
                    }

                    Rectangle {
                        id: sp5Altura
                        color: "transparent"
                        width: parent.width
                        height: txtPadding
                        anchors.left: parent.left
                        anchors.top: alturaTxt.bottom
                    }

                    Rectangle{
                        id: alturaUserTxtRec
                        width: dp(100)
                        height: dp(40)
                        color: backEditField
                        anchors.top: sp5Altura.bottom
                        anchors.left: sp2Altura.right

                        Text {
                            id: alturaUserTxt
                            text: ""
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                altura = true;
                                nativeUtils.displayAlertSheet("Altura", vector(1.50,2.30,0.01,true), true)
                            }
                        }
                    }
                }

                Item {
                    id: rowPesoDesejado
                    width: parent.width
                    height: pesoDesejadoTxt.height + sp5PesoDesejado.height + sp5PesoDesejado.height + pesoDesejadoUserTxtRec.height
                    anchors.top: rowAltura.bottom

                    Text {
                        id: pesoDesejadoTxt
                        text: "Peso Desejado *"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    Rectangle {
                        id: sp2PesoDesejado
                        color: "transparent"
                        width: userTxtPadding
                        height: pesoDesejadoUserTxtRec.height
                        anchors.left: parent.left
                        anchors.top: pesoDesejadoTxt.bottom
                    }

                    Rectangle {
                        id: sp5PesoDesejado
                        color: "transparent"
                        width: parent.width
                        height: txtPadding
                        anchors.left: parent.left
                        anchors.top: pesoDesejadoTxt.bottom
                    }


                    Rectangle{
                        id: pesoDesejadoUserTxtRec
                        width: dp(100)
                        height: dp(40)
                        color: backEditField
                        anchors.top: sp5PesoDesejado.bottom
                        anchors.left: sp2PesoDesejado.right

                        Text {
                            id: pesoDesejadoUserTxt
                            text: ""
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                pesoDesejado = true;
                                nativeUtils.displayAlertSheet("Peso Desejado", vector(40,120,1,false), true)
                            }
                        }
                    }
                }

                Spacer {
                    id: spacer2
                }
            }

            Component.onCompleted: {
                nomeUserTxt.text = user[0]
                emailUserTxt.text = user[1]
                idadeUserTxt.text = user[2]
                generoUserTxt.text = user[3]
                alturaUserTxt.text = user[4]
                pesoDesejadoUserTxt.text = user[5]
                userImage.source = "../../assets/image_perfil.jpg"
            }
        }

        Connections {
            target: nativeUtils
            onDatePickerFinished: {

                if(accepted){
                    var hour = "";
                    var dateStr = "";
                    var timeShift = "";

                    dateStr = date.toLocaleTimeString(Qt.locale("pt_BR"));
                    hour = parseInt(dateStr.split(":")[0]);
                    timeShift = Qt.formatDateTime(date, "t")

                    if(hour === 00){
                        idadeUserTxt.text = Qt.formatDate(date, "dd/MM/yyyy");
                        idadeUserTxt.color = "black"
                    }
                    else {
                        Date.prototype.addHours = function(h) {
                           this.setTime(this.getTime() + (h*60*60*1000));
                           return this;
                        }
                        idadeUserTxt.text = Qt.formatDate(date.addHours(24-hour), "dd/MM/yyyy");
                        idadeUserTxt.color = "black"
                    }
                }
            }

            onAlertSheetFinished: {
                if(pesoDesejado){
                    pesoDesejadoUserTxt.text = (40 + (index * 1)).toFixed(0);
                    pesoDesejado = false;
                }
                if(genero){
                    switch (index) {
                        case 0: {
                            generoUserTxt.text = "Feminino"
                            break;
                        }
                        case 1: {
                            generoUserTxt.text = "Masculino"
                            break;
                        }
                    }
                    genero = false;
                }
                if(altura){
                    alturaUserTxt.text = (1.50 + (index * 0.01)).toFixed(2);
                    altura = false;
                }
            }
        }
    }


    ScrollIndicator {
        flickable: scrollProfile
    }
}
