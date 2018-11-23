import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2
import VPlayPlugins 1.0

import "../common"
import "../pages"

Page {
    id: loginPage
    height: screenSizeY
    width: screenSizeX

    Component.onCompleted: {
        content.forceActiveFocus()
    }

    property alias textoEmail: emailUserTxtLogin.text
    property alias textoSenha: senhalUserTxtLogin.text

    AppFlickable {
        id: scrollProfile
        anchors.fill: parent
        contentHeight: contentProfile.height

        MouseArea {
            anchors.fill: parent
            onClicked: {
                scrollProfile.forceActiveFocus()
            }
        }

        Column {
            id: contentProfile
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter

            Item {
                id: content
                width: parent.width
                height: root.dp(100)
                focus: true

                Item {
                    id: imageLogoFitmass
                    width: parent.width
                    height: width / 2

                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"

                        AppImage {
                            source: logoFitmassSource
                            fillMode: Image.PreserveAspectFit
                            height: root.dp(60)
                            anchors.centerIn: parent
                        }
                    }
                }

                Item {
                    id: emailLogin
                    width: parent.width
                    height: emailTxtLogin.height + emailUserTxtLogin.height + root.dp(20)
                    anchors.top: imageLogoFitmass.bottom

                    Text {
                        id: emailTxtLogin
                        text: "E-mail"
                        color: white
                        font.bold: true
                        font.pixelSize: root.sp(14)
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
                        text: userEmail
                        textColor: greenDark
                        font.pixelSize: root.sp(14)
                        backgroundColor: bgColor
                        inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText | Qt.ImhPreferLowercase | Qt.ImhEmailCharactersOnly

                        CustomBorderRec {
                                commonBorder: false
                                lBorderwidth: 0
                                rBorderwidth: 0
                                tBorderwidth: 0
                                bBorderwidth: 2
                                borderColor: grayLight
                        }
                    }
                } // Campo de E-mail

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
                        font.pixelSize: root.sp(14)
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
                        inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhNoPredictiveText | Qt.ImhPreferLowercase | Qt.ImhHiddenText
                        text: userSenha
                        textColor: greenDark
                        font.pixelSize: root.sp(14)
                        backgroundColor: bgColor

                        CustomBorderRec {
                                commonBorder: false
                                lBorderwidth: 0
                                rBorderwidth: 0
                                tBorderwidth: 0
                                bBorderwidth: 2
                                borderColor: grayLight
                        }
                    }
                } // Campo de Senha

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

                                indicatorLogin.visible = true
                                indicatorLogin.startAnimating()
                                botaoEntrarLogin.visible = false
                                botaoCadastro.visible = false

                                firebaseAuth.loginUser(emailUserTxtLogin.text, senhalUserTxtLogin.text)
                            }
                        }
                    }
                } // Botão para realizar login


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
                                botaoEntrarLogin.visible = false
                                botaoCadastro.visible = false

                                entrarStack.push(cadastroView)
                                indicator.stopAnimating()
                                indicator.visible = false
                            }
                        }
                    }
                } // Botão para realizar cadastro

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
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: root.sp(14)
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
                                // Utilizar código fonte do FirebaseAuth

                                firebaseAuth.sendPasswordResetEmail(emailUserTxtLogin.text)
                            }
                        }
                    }
                } // Botão para recuperação de senha (não funcional)

                AppActivityIndicator {
                    id: indicatorLogin
                    z: 1
                    animating: false
                    visible: false
                    anchors.horizontalCenter: botaoLogin.horizontalCenter
                    anchors.verticalCenter: botaoLogin.verticalCenter
                    hidesWhenStopped: true
                    color: greenDark
                }

            }
        }
    }
}
