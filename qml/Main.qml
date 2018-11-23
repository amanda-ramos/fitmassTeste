import VPlayApps 1.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2
import Qt.labs.settings 1.0 as QtLabs
import QtQuick.Controls.Material 2.0
import QtCharts 2.2
import QtQuick.Controls 2.0
import VPlayPlugins 1.0

import "common"
import "pages"

// App com identidade Visual da Massa

App {
    id: root
    height: 960
    width: 640

    //Variáveis de id Visual
    property color verdeMassa: "#008f7d"
    property color amareloMassa: "#f9ba48"

    property color grayDark: "#111111"
    property color grayLight: "#343434"
    property color grayLight2: "#a3a3a3"
    property color greenDark: "#00ff85"
    property color greenLight: "#bbfdd2"
    property color white: "#ffffff"
    property color contrastColor1: "#ff00ff" // Rosa
    property color contrastColor2: "#ffff00" // Amarelo
    property color contrastColor3: "#00dbee" // Azul
    property color cardColor: "#242524"
    property color cardText: "#afffc7"

    property color bgColor: grayDark // Cor de fundo (background color)
    property color tfColor: grayLight // Cor de fundo de text fields

    property int screenSizeX: root.dp(640)
    property int screenSizeY: root.dp(960)

    property var logoFitmassBrancaSource: "../../assets/fitmass_new_logo_branca.png"
    property var logoFitmassSource: "../../assets/fitmass_new_logo.png"

    property var txtPadding: dp(10)
    property var userTxtPadding: dp(20)
    property var editTextMargin: root.dp(20)
    property var radiusText: root.dp(30)
    property var indicatorHor
    property var indicatorVer

    property int axisFontSize: 10
    property var userID
    property var userGender
    property var userAge
    property var pesoDesejado
    property var userEmail: "alc.ramos@yahoo.com.br"//"teste@teste.com.br"
    property var userSenha: "123456"//"teste123"
    property var qtdeMedida: 0
    property var qtdeMedidaCorp: 0
    property bool novato: true

    property var keyUser: "users/" + root.userID
    property var keyMeasure: ""
    property var keyMeasureCorp: ""

    property var keyCard: ""
    property var keyCard2: ""
    property var keyCard3: ""

    property var userTotalMeasures: ""
    property var userDesiredWeight: ""

    property bool profile: false
    property bool cadastro: false
    property bool editProfile: false
    property bool card: false

    onInitTheme: {
        if(system.desktopPlatform)
          Theme.platform = "ios"

        // Para todos os sistemas operacionais
        Theme.colors.tintColor = "black"
        Theme.colors.statusBarStyle = Theme.colors.statusBarStyleHidden
        Theme.colors.backgroundColor = bgColor
        Theme.colors.scrollbarColor = grayLight2

        // Configurações de tema para o sistema iOS
        if(Theme.isIos){
            Theme.navigationBar.backgroundColor = grayDark
            Theme.navigationBar.titleColor = white
            Theme.navigationBar.dividerColor = grayDark
            Theme.navigationBar.itemColor = white
            Theme.navigationBar.defaultIconSize = root.dp(20)
            Theme.tabBar.backgroundColor = grayLight
            Theme.tabBar.dividerColor = grayLight
            Theme.tabBar.titleColor = greenDark
            Theme.tabBar.titlePressedColor = greenDark
            Theme.tabBar.titleOffColor = grayDark
        }

        // Configurações de tema para o sistema Android
        if(Theme.isAndroid){
            Theme.navigationAppDrawer.backgroundColor = grayDark
            Theme.navigationAppDrawer.textColor = grayLight2
            Theme.navigationAppDrawer.activeTextColor = greenDark
            Theme.navigationAppDrawer.selectedTextColor = greenDark
            Theme.navigationAppDrawer.itemBackgroundColor = grayDark
            Theme.navigationAppDrawer.itemSelectedBackgroundColor = grayLight
            Theme.navigationAppDrawer.itemActiveBackgroundColor = grayLight
            Theme.navigationAppDrawer.dividerColor = grayLight
        }
    }

    // Stack View Principal
    StackView {
        id: stack
        anchors.fill: parent
        initialItem: splashScreenView
    }

    // SplashScreen
    Component {
        id: splashScreenView

        SplashScreen {
            id: splashScreenPage
        }
    }

    // Login e Cadastro
    Component {
        id: entrarView

        NavigationStack {
            id: entrarStack
            anchors.fill: parent
            initialPage: loginView

            // Login
            Component {
                id: loginView
                LoginPage {
                    id: loginPage
                }
            }

            // Cadastro
            Component {
                id: cadastroView
                CadastroPage {
                    id: cadastroPage
                }
            }
        }
    }

    // Página principal após o login
    Component {
        id: mainView

        Navigation {
            headerView: Component {
                AppImage {
                    id: logoFitmass
                    source: "../assets/fitmass_logo.png"
                    width: parent.width
                    fillMode: Image.PreserveAspectFit
                }
            }

            // Fitmass e sub páginas
           NavigationItem {
                id: fitmassHistorico
                title: "Medidas Fitmass"
                icon: IconType.barchart

                NavigationStack {
                    id: fitmassStack
                    anchors.fill: parent
                    initialPage: historicoView

                    // Histórico Fitmass
                    Component {
                        id: historicoView

                        HistoricoPage {
                            id: historicoPage
                        }
                    }

                    // Página de uma medida
                    Component {
                        id: measureView

                        MeasurePage {
                            id: measurePage
                        }
                    }

                    // Página de Informações das medidas
                    Component {
                        id: infoView

                        InfoPage {
                            id: infoPage
                        }
                    }
                }
            }

           // Medidas Corporais e sub paginas
            NavigationItem {
               id: fitmassAntropo
               title: "Medidas Corporais"
               icon: IconType.linechart

               NavigationStack {
                   id: antropoStack
                   anchors.fill: parent
                   initialPage: antropoView

                   // Histórico de medidas corporais
                   Component {
                       id: antropoView

                       AntropoPage {
                           id: antropoPage
                       }
                   }

                   // Página para cadastro de nova medida corporal
                   Component {
                       id: antropoNewView

                       AntropoNew {
                           id: antropoNewPage
                       }
                   }
               }
            }

            // Perfil e sub página
            NavigationItem {
                id: fitmassPerfil
                title: "Meus Dados"
                icon: IconType.user

                NavigationStack {
                    id: profileStack
                    anchors.fill: parent
                    initialPage: profileView

                    // Perfil
                    Component {
                        id: profileView

                        ProfilePage {
                            id: profilePage
                        }
                    }

                    // Editar Perfil
                    Component {
                        id: editProfileView

                        EditProfile {
                            id: editProfilePage
                        }
                    }
                }
            }

            // Informações do Fitmass App
            NavigationItem {
                id: fitmassSobre
                title: "Sobre o Fitmass"
                icon: IconType.info

                NavigationStack {
                    id: infoStack
                    anchors.fill: parent
                    initialPage: infoView

                    // Informações Fitmass App
                    Component {
                        id: infoView

                        FitmassInfo {
                            id: fitmassInfo
                        }
                    }
                }
            }
        }
    }

    AppActivityIndicator {
        id: indicator
        z: 1
        animating: false
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        hidesWhenStopped: true
        color: greenDark
    }

    // Banco de dados para autenticação
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
            indicator.stopAnimating()
            indicator.visible = false

            if(success){
                    console.log("LOGIN - Sucesso ao fazer o login!");
                    root.userID = firebaseAuth.userId;
                    console.log("LOGIN - UserID: " + root.userID)
                    userEmail = ""
                    userSenha = ""

                    stack.push(mainView)
            } else {
                console.log("LOGIN - Error: " + message);
                nativeUtils.displayAlertDialog("Erro no login", "Erro ao realizar o login.\n\nErro: " + message, "OK")
            }
        }

        onPasswordResetEmailSent: {
            indicator.stopAnimating()

            if(success){
                console.log("LOGIN - Link para recuperação de senha enviado ao seu e-mail.");
            } else {
                console.log("LOGIN - Error: " + message);
            }
        }
    }

    FirebaseStorage {
        id: storageFitmass

        config: FirebaseConfig {
             //get these values from the firebase console
             projectId: "fitmass-2018"
             databaseUrl: "https://fitmassapp.firebaseio.com/"

             storageBucket: "fitmassapp.appspot.com"

             //platform dependent - get these values from the google-services.json / GoogleService-info.plist
             apiKey:        Qt.platform.os === "android" ? "AIzaSyBh6Kb12xUnOsQDTP2XEbSKtuGsBfmCyic" : "AIzaSyBh6Kb12xUnOsQDTP2XEbSKtuGsBfmCyic"
             applicationId: Qt.platform.os === "android" ? "1:519505351771:android:28365556727f1ea3" : "1:519505351771:ios:28365556727f1ea3"
           }
    }

}
