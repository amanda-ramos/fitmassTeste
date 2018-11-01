import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.9

import "../common"
import "../pages"

Page {
    id: profilePage
    title: "Perfil"
    height: 960
    width: 640

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
    } // Função Split String

    property color txtColor: verdeMassa
    property color userTxtColor: "#4b4b4b"

    property var txtPadding: dp(10)
    property var userTxtPadding: dp(20)

    property bool inicial: true

    rightBarItem:  NavigationBarRow {
      id: rightNavBarRow

      IconButtonBarItem {
          title: "Editar Perfil"
          icon: IconType.pencil

          onClicked: {
            profileStack.push(editProfileView);
        }
      } // Editar Perfil
    } // Menu superior direito

    AppFlickable {
        id: scrollProfile
        anchors.fill: parent
        contentHeight: contentProfile.height

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log(keyUser)
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
                        height: dp(25)
                        color: "transparent"
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    UserImage {
                      id: userImage
                      property string iconFontName: Theme.iconFont.name
                      width: dp(150)
                      height: width
                      anchors.horizontalCenter: parent.horizontalCenter
                      anchors.top: space1.bottom

                      placeholderImage: "\uf007" // user
                      source: ""
                    } // User Image

                    Rectangle {
                        id: backName
                        width: userName.width + dp(10)
                        height: userName.height + dp(10)
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: userImage.bottom
                        color: verdeMassa
                        radius: dp(5)
                    }

                    Text {
                        id: userName
                        anchors.horizontalCenter: backName.horizontalCenter
                        anchors.verticalCenter: backName.verticalCenter
                        color: "white"
                        font.bold: true
                    }
                } // Linha User Image

                Spacer {
                    id: spacer1
                    width: parent.width
                    anchors.top: rowImageProfile.bottom
                }

                Item {
                    id: rowEmail
                    width: parent.width
                    height: emailTxt.height + emailUserTxt.height
                    anchors.top: spacer1.bottom

                    Text {
                        id: emailTxt
                        text: "E-mail"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    Text {
                        id: emailUserTxt
                        color: userTxtColor
                        anchors.left: parent.left
                        padding: userTxtPadding
                        anchors.top: emailTxt.bottom
                    }
                } // Linha E-mail

                Item {
                    id: rowIdade
                    width: parent.width
                    height: emailTxt.height + emailUserTxt.height
                    anchors.top: rowEmail.bottom

                    Text {
                        id: idadeTxt
                        text: "Idade"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    Text {
                        id: idadeUserTxt
                        color: userTxtColor
                        anchors.left: parent.left
                        padding: userTxtPadding
                        anchors.top: idadeTxt.bottom
                    }
                } // Linha Idade

                Item {
                    id: rowGenero
                    width: parent.width
                    height: emailTxt.height + emailUserTxt.height
                    anchors.top: rowIdade.bottom

                    Text {
                        id: generoTxt
                        text: "Gênero"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    Text {
                        id: generoUserTxt
                        color: userTxtColor
                        anchors.left: parent.left
                        padding: userTxtPadding
                        anchors.top: generoTxt.bottom
                    }
                } // Linha Gênero

                Item {
                    id: rowAltura
                    width: parent.width
                    height: emailTxt.height + emailUserTxt.height
                    anchors.top: rowGenero.bottom

                    Text {
                        id: alturaTxt
                        text: "Altura"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    Text {
                        id: alturaUserTxt
                        color: userTxtColor
                        anchors.left: parent.left
                        padding: userTxtPadding
                        anchors.top: alturaTxt.bottom
                    }
                } // Linha Altura

                Item {
                    id: rowPesoDesejado
                    width: parent.width
                    height: emailTxt.height + emailUserTxt.height
                    anchors.top: rowAltura.bottom

                    Text {
                        id: pesoDesejadoTxt
                        text: "Peso Desejado"
                        color: txtColor
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    Text {
                        id: pesoDesejadoUserTxt
                        color: userTxtColor
                        anchors.left: parent.left
                        padding: userTxtPadding
                        anchors.top: pesoDesejadoTxt.bottom
                    }
                } // Linha Peso Desejado

                Item {
                    id: rowMedidas
                    width: parent.width
                    height: col1.height
                    anchors.top: rowPesoDesejado.bottom

                    Item {
                        id: col1
                        width: parent.width / 3
                        height: iconMedidas.height + txtPadding
                        anchors.left: parent.left

                        Image {
                            id: iconMedidas
                            width: dp(50)
                            height: width

                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter

                            source: "../../assets/icon_medidas.png"
                        }
                    }

                    Item {
                        id: col2
                        width: parent.width * 2 / 3
                        height: col1.height
                        anchors.right: parent.right

                        Text {
                            id: medidas
                            text: "Total de medidas realizadas"
                            font.bold: true
                            color: txtColor
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Rectangle {
                             width: dp(40)
                             height: width
                             color: amareloMassa
                             border.color: "transparent"
                             radius: width * 0.5
                             anchors.horizontalCenter: parent.horizontalCenter
                             anchors.top: medidas.bottom

                             Text {
                                 id: medidasTotal
                                  anchors.horizontalCenter: parent.horizontalCenter
                                  anchors.verticalCenter: parent.verticalCenter
                                  color: "white"
                             }
                        }
                    }
                } // Linha Total de Medidas

                Spacer {
                    id: spacer2
                }
            }

            Component.onCompleted: {
                userName.text = splitString(user[0])
                emailUserTxt.text = user[1]
                idadeUserTxt.text = userAge + " anos"
                generoUserTxt.text = user[3]
                alturaUserTxt.text = user[4] + " m"
                pesoDesejadoUserTxt.text = user[5] + " kg"
                medidasTotal.text = user[7]
                userImage.source = "../../assets/image_perfil.jpg"
            }
        } // Coluna Conteúdo
    } // Flickable

    ScrollIndicator {
        flickable: scrollProfile
    } // ScrollIndicator
} // Page
