import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.9
import VPlayPlugins 1.0

import "../common"
import "../pages"

Page {
    id: profilePage
    title: "Perfil"
    height: screenSizeY
    width: screenSizeX

    property color txtColor: white
    property color userTxtColor: greenLight

    property var txtTitleSize: root.sp(12)
    property var txtUserSize: root.sp(12)

    property bool inicialP: true

    // Função para pegar o primeiro e último nome do usuário
    function splitString (str){
        // Função para separar a primeira e última palavra da String

        var firstWord;
        var lastWord;
        var name;
        var total = 0;

        total = str.split(" ").length;

        firstWord = str.split(" ")[0];
        lastWord = str.split(" ")[total-1];

        name = firstWord + " " + lastWord;

        return name;
    }

    // Ícones na barra de navegação superior
    rightBarItem:  NavigationBarRow {
      id: rightNavBarRow

      // Ícone para editar o perfil
      IconButtonBarItem {
          title: "Editar Perfil"
          icon: IconType.pencil

          onClicked: {
            profileStack.push(editProfileView);
              indicator.stopAnimating()
              indicator.visible = false
        }
      } // Editar Perfil
    }

    AppFlickable {
        id: scrollProfile
        anchors.fill: parent
        contentHeight: contentProfile.height

        MouseArea {
            anchors.fill: parent
            onClicked: {
                scrollProfile.forceActiveFocus()
            }
        } // Mouse Area

        Item {
            id: contentProfile
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            height: rowImageProfile.height + rowEmail.height + rowIdade.height + rowGenero.height +
                    rowAltura.height + rowPesoDesejado.height + spacer1.height + spacer2.height +
                    rowMedidas.height

            Item {
                width: parent.width

                Item {
                    id: rowImageProfile
                    width: parent.width
                    height: userImage.height + backName.height
                    anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle {
                        id: space1
                        width: parent.width
                        height: root.dp(25)
                        color: "transparent"
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Image {
                        id: userImageBack
                        width: root.dp(150)
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: space1.bottom
                        source: "../../assets/circle.png"
                        z: -1
                    }

                    UserImage {
                      id: userImage
                      property string iconFontName: Theme.iconFont.name
                      width: userImageBack.width - root.dp(6)
                      height: width
                      anchors.centerIn: userImageBack

                      placeholderImage: "\uf007" // user
                      source: ""
                    } // User Image

                    Rectangle {
                        id: backName
                        width: userImageBack.width + root.dp(10)
                        height: userNameField.height + root.dp(10)
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: userImageBack.bottom
                        color: grayDark
                    }

                    Text {
                        id: userNameField
                        anchors.horizontalCenter: backName.horizontalCenter
                        anchors.verticalCenter: backName.verticalCenter
                        color: greenDark
                        font.bold: true
                        font.pixelSize: root.sp(16)
                    }
                } // Imagem do Usuário

                Spacer {
                    id: spacer1
                    width: parent.width
                    anchors.top: rowImageProfile.bottom
                }

                Item {
                    id: rowEmail
                    width: parent.width
                    height: root.dp(70)
                    anchors.top: spacer1.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomTextView {
                        id: emailUserTxt
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        txtTitleColor: white
                        txtTextColor: greenLight
                        txtColor: grayLight
                        txtRadius: radiusText
                        txtTextTitle: "E-mail: "
                    }
                } // Campo de E-mail

                Item {
                    id: rowIdade
                    anchors.top: rowEmail.bottom
                    width: parent.width
                    height: root.dp(70)
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomTextView {
                        id: idadeUserTxt
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        txtTitleColor: white
                        txtTextColor: greenLight
                        txtColor: grayLight
                        txtRadius: radiusText
                        txtTextTitle: "Idade: "
                    }
                } // Campo de Aniversário / Idade

                Item {
                    id: rowGenero
                    width: parent.width
                    height: root.dp(70)
                    anchors.top: rowIdade.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomTextView {
                        id: generoUserTxt
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        txtTitleColor: white
                        txtTextColor: greenLight
                        txtColor: grayLight
                        txtRadius: radiusText
                        txtTextTitle: "Gênero: "
                    }
                } // Campo de Gênero

                Item {
                    id: rowAltura
                    width: parent.width
                    height: root.dp(70)
                    anchors.top: rowGenero.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomTextView {
                        id: alturaUserTxt
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        txtTitleColor: white
                        txtTextColor: greenLight
                        txtColor: grayLight
                        txtRadius: radiusText
                        txtTextTitle: "Altura: "
                    }
                } // Campo de Altura

                Item {
                    id: rowPesoDesejado
                    width: parent.width
                    height: root.dp(70)
                    anchors.top: rowAltura.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomTextView {
                        id: pesoDesejadoUserTxt
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        txtTitleColor: white
                        txtTextColor: greenLight
                        txtColor: grayLight
                        txtRadius: radiusText
                        txtTextTitle: "Peso Desejado: "
                    }
                }

                Item {
                    id: rowMedidas
                    width: parent.width
                    height: iconMedidas.height + root.dp(60)
                    anchors.top: rowPesoDesejado.bottom

                    Item {
                        id: col1
                        width: parent.width / 3
                        height: parent.height
                        anchors.left: parent.left

                        Image {
                            id: iconMedidas
                            width: root.dp(50)
                            height: width

                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter

                            source: "../../assets/icon_medidas.png"
                        }
                    }

                    Item {
                        id: col2
                        width: parent.width * 2 / 3
                        height: medidas.height + recMedidas.height
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            id: medidas
                            text: "Total de medidas realizadas"
                            font.bold: true
                            color: txtColor
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: txtTitleSize
                            bottomPadding: root.dp(10)
                        }

                        Rectangle {
                            id: recMedidas
                             width: root.dp(40)
                             height: width
                             color: contrastColor3
                             border.color: "transparent"
                             radius: width * 0.5
                             anchors.horizontalCenter: parent.horizontalCenter
                             anchors.top: medidas.bottom

                             Text {
                                 id: medidasTotal
                                  anchors.horizontalCenter: parent.horizontalCenter
                                  anchors.verticalCenter: parent.verticalCenter
                                  color: "white"
                                  font.bold: true
                                  font.pixelSize: txtUserSize
                             }
                        }
                    }
                } // Linha Total de Medidas

                Spacer {
                    id: spacer2
                }
            }

            Component.onCompleted: {
                userNameField.text = splitString(userName)
                emailUserTxt.txtText = userEmail
                idadeUserTxt.txtText = userAge + " anos"
                generoUserTxt.txtText = userGender
                alturaUserTxt.txtText = userHeight + " m"
                pesoDesejadoUserTxt.txtText = userPesoDesejado + " kg"
                medidasTotal.text = qtdeMedida
                userImage.source = userPhoto

                inicialP = false
            }
        } // Coluna Conteúdo
    } // Flickable

    ScrollIndicator {
        flickable: scrollProfile
    } // ScrollIndicator

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

        realtimeValueKeys: [keyUser + "/nome", keyUser + "/email",
            keyUser + "/age", keyUser + "/gender", keyUser + "/height",
            keyUser + "/desiredWeight", keyUser + "/totalMeasure",
            keyUser + "/photo", keyUser + "/totalMeasureCorp"]

        onRealtimeValueChanged: {

            if(!inicialP){
                if(success){

                    switch (key) {
                        case "nome": {
                            userName = value
                            userNameField.text = splitString(userName)
                            break
                        }
                        case "email": {
                            userEmail = value
                            emailUserTxt.txtText = userEmail
                            break
                        }
                        case "age": {
                            userAge = value
                            idadeUserTxt.txtText = userAge + " anos"
                            break
                        }
                        case "gender": {
                            userGender = value
                            generoUserTxt.txtText = userGender
                            break
                        }
                        case "height": {
                            userHeight = value
                            alturaUserTxt.txtText = userHeight + " m"
                            break
                        }
                        case "desiredWeight": {
                            userPesoDesejado = value
                            pesoDesejadoUserTxt.txtText = userPesoDesejado + " kg"
                            break
                        }
                        case "totalMeasure": {
                            qtdeMedida = value
                            medidasTotal.text = qtdeMedida
                            break
                        }
                        case "totalMeasureCorp": {
                            qtdeMedidaCorp = value
                            //medidasTotal.text = qtdeMedidaCorp
                            break
                        }
                        case "photo": {
                            userPhoto = value
                            userImage.source = userPhoto
                            break
                        }
                    }
                }
            }
        }
    }
} // Page
