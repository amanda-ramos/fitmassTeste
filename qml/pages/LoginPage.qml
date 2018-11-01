import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2

import "../common"
import "../pages"

Page {
    id: loginPage
    height: screenSizeY
    width: screenSizeX

    backgroundColor: bgColor

    Component.onCompleted: {
        content.forceActiveFocus()
    }

    property var txtPadding: dp(10)
    property var userTxtPadding: dp(20)

    property alias textoEmail: emailUserTxtLogin.text
    property alias textoSenha: senhalUserTxtLogin.text

    AppFlickable {
        id: scrollProfile
        anchors.fill: parent
        contentHeight: contentProfile.height

        MouseArea {
            anchors.fill: parent
            onClicked: scrollProfile.forceActiveFocus()
        }

        Column {
            id: contentProfile
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter

            Item {
                id: content
                width: parent.width
                height: 100
                focus: true

                Item {
                    id: imageLogoFitmass
                    width: parent.width
                    height: width / 2

                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"

                        AppImage {
                            source: "../../assets/fitmass_new_logo.png"
                            fillMode: Image.PreserveAspectFit
                            height: dp(60)
                            anchors.centerIn: parent
                        }
                    }
                }

                Item {
                    id: emailLogin
                    width: parent.width
                    height: emailTxtLogin.height + emailUserTxtLogin.height + dp(
                                20)
                    anchors.top: imageLogoFitmass.bottom

                    Text {
                        id: emailTxtLogin
                        text: "E-mail"
                        color: white
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    AppTextField {
                        id: emailUserTxtLogin
                        implicitWidth: parent.width - 2 * userTxtPadding
                        placeholderText: "E-mail"
                        anchors.top: emailTxtLogin.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        cursorColor: greenDark
                        showClearButton: true
                        borderWidth: 0
                        placeholderColor: grayLight
                        inputMethodHints: Qt.ImhEmailCharactersOnly
                        text: userEmail
                        textColor: greenDark

                        Rectangle {
                            anchors.fill: parent
                            color: bgColor
                            z:-1
                        }

                        CustomBorderRec {
                                commonBorder: false
                                lBorderwidth: 0
                                rBorderwidth: 0
                                tBorderwidth: 0
                                bBorderwidth: 2
                                borderColor: grayLight
                        }
                    }
                }

                Item {
                    id: senhaLogin
                    width: parent.width
                    height: senhaTxtLogin.height + senhalUserTxtLogin.height + dp(
                                20)
                    anchors.top: emailLogin.bottom

                    Text {
                        id: senhaTxtLogin
                        text: "Senha"
                        color: white
                        font.bold: true
                        anchors.top: parent.top
                        anchors.left: parent.left
                        leftPadding: txtPadding
                    }

                    AppTextField {
                        id: senhalUserTxtLogin
                        implicitWidth: parent.width - 2 * userTxtPadding
                        placeholderText: "Senha"
                        anchors.top: senhaTxtLogin.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        cursorColor: greenDark
                        showClearButton: true
                        borderWidth: 0
                        placeholderColor: grayLight
                        echoMode: TextInput.Password
                        text: userSenha
                        textColor: greenDark

                        Rectangle {
                            anchors.fill: parent
                            color: bgColor
                            z:-1
                        }

                        CustomBorderRec {
                                commonBorder: false
                                lBorderwidth: 0
                                rBorderwidth: 0
                                tBorderwidth: 0
                                bBorderwidth: 2
                                borderColor: grayLight
                        }

                    }


                }

                Item {
                    id: botaoLogin
                    width: parent.width / 2
                    height: botaoEntrarLogin.height
                    anchors.top: botaoEsqueceuSenha.bottom
                    anchors.left: parent.left

                    CustomButtom {
                        id: botaoEntrarLogin
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top

                        btnColor: bgColor
                        btnBorderColor: btnLoginMouseArea.pressed ? grayLight : greenDark
                        btnRadius: root.dp(30)
                        btnText: "Entrar"

                        MouseArea {
                            id: btnLoginMouseArea
                            anchors.fill: parent
                            onClicked: {
                                 loginPage.forceActiveFocus()
                                 stack.push(mainView)
                            }
                        }
                    }
                }


                Item {
                    id: botaoCadastro
                    width: parent.width / 2
                    height: botaoEntrarLogin.height
                    anchors.top: botaoEsqueceuSenha.bottom
                    anchors.right: parent.right

                    CustomButtom {
                        id: btnCriarCadastro
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top

                        btnColor: bgColor
                        btnBorderColor: btnCadastroMouseArea.pressed ? grayLight : white
                        btnRadius: root.dp(30)
                        btnText: "Cadastre-se"

                        MouseArea {
                            id: btnCadastroMouseArea
                            anchors.fill: parent
                            onClicked: {
                                 entrarStack.push(cadastroView)
                            }
                        }
                    }
                }

                Item {
                    id: botaoEsqueceuSenha
                    width: parent.width
                    height: txt3.height + root.dp(15)
                    anchors.top: senhaLogin.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: txt3
                        text: "Esqueceu a senha? "
                        leftPadding: userTxtPadding
                        topPadding: userTxtPadding
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: btnSenhaMouseArea.pressed ? greenDark : grayLight
                        font.pointSize: root.sp(4)
                        horizontalAlignment: Text.AlignHCenter
                    }

                    Rectangle {
                        id: btnEsqueceuSenha
                        color: "transparent"
                        width: txt3.width
                        height: dp(15)

                        anchors.fill: txt3
                        anchors.horizontalCenter: parent.horizontalCenter

                        MouseArea {
                            id: btnSenhaMouseArea
                            anchors.fill: parent
                            onClicked: {
                                firebaseAuth.sendPasswordResetEmail(
                                            emailUserTxtLogin.text)
                            }
                        }
                    }
                }
            }
        }

        Dialog {
            id: loginDialog
            title: ""
            positiveActionLabel: "OK"
            z: 1
            negativeAction: false

            property alias text: dialogText.text

            onAccepted: {
                close()
                    stack.push(mainView)
            }

            AppText {
                id: dialogText
                anchors.fill: parent
            }
        }
    }
}
