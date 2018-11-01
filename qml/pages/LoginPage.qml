import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2

import "../common"
import "../pages"

Page {
    id: loginPage
    height: 960
    width: 640

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
                            source: "../../assets/fitmass_logo_cinzaescuro.png"
                            fillMode: Image.PreserveAspectFit
                            height: dp(160)
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
                        color: verdeMassa
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
                        cursorColor: verdeMassa
                        showClearButton: true
                        borderColor: amareloMassa
                        borderWidth: 1
                        placeholderColor: "#b4b4b4"
                        inputMethodHints: Qt.ImhEmailCharactersOnly
                        text: userEmail
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
                        color: verdeMassa
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
                        cursorColor: verdeMassa
                        showClearButton: true
                        borderColor: amareloMassa
                        borderWidth: 1
                        placeholderColor: "#b4b4b4"
                        echoMode: TextInput.Password
                        text: userSenha
                    }
                }

                Item {
                    id: botaoLogin
                    width: parent.width
                    height: botaoEntrarLogin.height
                    anchors.top: senhaLogin.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    AppButton {
                        id: botaoEntrarLogin
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        flat: false

                        backgroundColor: verdeMassa
                        text: "Entrar"
                        textColor: "white"

                        onClicked: {
                            loginPage.forceActiveFocus()
                            stack.push(mainView)
                        }
                    }
                }

                Item {
                    id: botaoCadastro
                    width: parent.width
                    height: btnCriarCadastro.height + dp(5)

                    anchors.top: botaoLogin.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: txt1
                        text: "Ainda não possui conta?"
                        leftPadding: userTxtPadding
                        topPadding: userTxtPadding
                        anchors.left: parent.left
                        anchors.top: parent.top
                        color: verdeMassa
                        font.pointSize: sp(4)
                    }

                    Rectangle {
                        id: btnCriarCadastro
                        color: "transparent"
                        width: txt2.width
                        height: dp(15)

                        anchors.bottom: txt1.bottom
                        anchors.left: txt1.right

                        MouseArea {
                            id: btnCadastroMA
                            anchors.fill: parent

                            onClicked: {
                                entrarStack.push(cadastroView)
                            }
                        }
                    }

                    Text {
                        id: txt2
                        text: "Crie uma aqui."
                        color: btnCadastroMA.pressed ? amareloMassa : verdeMassa
                        font.pointSize: sp(4)
                        anchors.left: txt1.right
                        anchors.top: txt1.top
                        leftPadding: dp(2)
                        topPadding: userTxtPadding
                        font.underline: true
                    }
                }

                Item {
                    id: botaoEsqueceuSenha
                    width: parent.width
                    anchors.top: botaoCadastro.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: txt3
                        text: "Esqueceu a senha? "
                        leftPadding: userTxtPadding
                        topPadding: userTxtPadding
                        anchors.left: parent.left
                        anchors.top: parent.top
                        color: verdeMassa
                        font.pointSize: sp(4)
                    }

                    Rectangle {
                        id: btnEsqueceuSenha
                        color: "transparent"
                        width: txt4.width
                        height: dp(15)

                        anchors.bottom: txt3.bottom
                        anchors.left: txt3.right

                        MouseArea {
                            id: btnSenhaMA
                            anchors.fill: parent
                            onClicked: {
                                firebaseAuth.sendPasswordResetEmail(
                                            emailUserTxtLogin.text)
                            }
                        }
                    }

                    Text {
                        id: txt4
                        text: "Recupere aqui."
                        color: btnSenhaMA.pressed ? amareloMassa : verdeMassa
                        font.pointSize: sp(4)
                        anchors.left: txt3.right
                        anchors.top: txt3.top
                        leftPadding: dp(2)
                        topPadding: userTxtPadding
                        font.underline: true
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
