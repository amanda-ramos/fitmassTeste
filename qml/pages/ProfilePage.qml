import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.9

import "../common"
import "../pages"

Page {
    id: profilePage
    title: "Perfil"
    height: screenSizeY
    width: screenSizeX

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

    property color txtColor: white
    property color userTxtColor: greenLight

    property var txtPadding: root.dp(10)
    property var userTxtPadding: root.dp(20)

    property var txtTitleSize: root.sp(12)
    property var txtUserSize: root.sp(12)

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
                        width: userName.width + root.dp(10)
                        height: userName.height + root.dp(10)
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: userImageBack.bottom
                        color: grayDark
                        //radius: root.dp(30)
                    }

                    Text {
                        id: userName
                        anchors.horizontalCenter: backName.horizontalCenter
                        anchors.verticalCenter: backName.verticalCenter
                        color: greenDark
                        font.bold: true
                        font.pixelSize: root.sp(16)
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
                        txtRadius: root.dp(30)
                        txtTextTitle: "E-mail: "
                    }
                }

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
                        txtRadius: root.dp(30)
                        txtTextTitle: "Idade: "
                    }
                }

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
                        txtRadius: root.dp(30)
                        txtTextTitle: "Gênero: "
                    }
                }

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
                        txtRadius: root.dp(30)
                        txtTextTitle: "Altura: "
                    }
                }


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
                        txtRadius: root.dp(30)
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

                            anchors.horizontalCenter: parent.horizontalCenter
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
                userName.text = splitString(user[0])
                emailUserTxt.txtText = user[1]
                idadeUserTxt.txtText = userAge + " anos"
                generoUserTxt.txtText = user[3]
                alturaUserTxt.txtText = user[4] + " m"
                pesoDesejadoUserTxt.txtText = user[5] + " kg"
                medidasTotal.text = user[7]
                userImage.source = "../../assets/image_perfil.jpg"
            }
        } // Coluna Conteúdo
    } // Flickable

    ScrollIndicator {
        flickable: scrollProfile
    } // ScrollIndicator
} // Page
