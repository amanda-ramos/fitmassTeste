import VPlayApps 1.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2
import Qt.labs.settings 1.0 as QtLabs
import QtQuick.Controls.Material 2.0
import QtCharts 2.2
import QtQuick.Controls 2.0

import "common"
import "pages"

//teste

App {
    id: root
    height: 960
    width: 640

    //variáveis de teste
    property var user: ["Amanda Ramos", "alc.ramos@yahoo.com.br", "28/12/1992", "Feminino", "1.66", "65", "https://firebasestorage.googleapis.com/v0/b/fitmassapp.appspot.com/o/userPhoto1540304322552.png?alt=media&token=276c9688-2899-4cae-8a5d-d4af25066895", "3"]
    //                      nome                    peso    magra   gorda   agua    imc      pgc      data da medida
    property var medida0: ["fitmass20180912083026", "74.0", "27.2", "24.6", "36.2", "26.9", "33.2", "2018-09-12T00:00:00.000"]
    //                           SE      SD       ABD      IE      ID
    property var medida0Magra: ["2.50", "2.50", "21.40", "7.51", "7.31"]
    property var medida0Gorda: ["1.70", "1.80", "12.50", "3.70", "3.70"]

    //                      nome                    peso    magra   gorda   agua    imc      pgc      data da medida
    property var medida1: ["fitmass20181004121555", "70.8", "26.4", "22.9", "35.0", "25.7", "32.4", "2018-19-04T00:00:00.000"]
    //                           SE      SD       ABD      IE      ID
    property var medida1Magra: ["2.50", "2.30", "21.00", "7.41", "7.41"]
    property var medida1Gorda: ["1.50", "1.60", "11.70", "3.50", "3.50"]

    property var medida2: ["fitmass20181024083026", "75.0", "27.2", "24.6", "36.2", "26.9", "33.2", "2018-10-24T00:00:00.000"]
    //                           SE      SD       ABD      IE      ID
    property var medida2Magra: ["2.50", "2.50", "21.40", "7.51", "7.31"]
    property var medida2Gorda: ["1.70", "1.80", "12.50", "3.70", "3.70"]

    property int axisFontSize: 10
    property var userID
    property var userGender
    property var userAge
    property var pesoDesejado
    property var userEmail: "alc.ramos@yahoo.com.br"
    property var userSenha: "123456"

    property var keyUser: "users/" + root.userID
    property var keyMeasure: ""

    property var keyCard: ""
    property var keyCard2: ""
    property var keyCard3: ""

    property var userTotalMeasures: ""
    property var userDesiredWeight: ""

    property bool profile: false
    property bool cadastro: false
    property bool editProfile: false
    property bool card: false

    property color verdeMassa: "#008f7d"
    property color amareloMassa: "#f9ba48"

    property var qtdeMedida: 0

    onInitTheme: {
        Theme.colors.tintColor = "gray"
    }

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: splashScreenView
    }

    Component {
        id: splashScreenView
        SplashScreen {
            id: splashScreenPage
        }
    }

    Component {
        id: entrarView

        NavigationStack {
            id: entrarStack
            anchors.fill: parent
            initialPage: loginView

            Component {
                id: loginView
                LoginPage {
                    id: loginPage
                }
            }

            Component {
                id: cadastroView
                CadastroPage {
                    id: cadastroPage
                }
            }
        }
    }

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

            NavigationItem {
                id: fitmassHistorico
                title: "Medidas Fitmass"
                icon: IconType.barchart

                NavigationStack {
                    id: fitmassStack
                    anchors.fill: parent
                    initialPage: historicoView

                    Component {
                        id: historicoView

                        HistoricoPage {
                            id: historicoPage
                        }
                    } // historicoPage

                    Component {
                        id: measureView

                        MeasurePage {
                            id: measurePage
                        }
                    } // measurePage

                    Component {
                        id: infoView

                        InfoPage {
                            id: infoPage
                        }
                    } // infoMeasurePage
                }
            }

            NavigationItem {
                id: fitmassAntropo
                title: "Medidas Antropométricas"
                icon: IconType.linechart

                NavigationStack {
                    id: antropoStack
                    anchors.fill: parent
                    initialPage: antropoView

                    Component {
                        id: antropoView

                        AntropoPage {
                            id: antropoPage
                        }
                    } // antropoPage

                    Component {
                        id: antropoNewView

                        AntropoNew {
                            id: antropoNewPage
                        }
                    } // antropoNewPage
                }
            }

            NavigationItem {
                id: fitmassPerfil
                title: "Meus Dados"
                icon: IconType.user

                NavigationStack {
                    id: profileStack
                    anchors.fill: parent
                    initialPage: profileView

                    Component {
                        id: profileView
                        ProfilePage {
                            id: profilePage
                        }
                    }

                    Component {
                        id: editProfileView

                        EditProfile {
                            id: editProfilePage
                        }
                    }
                }
            }

            NavigationItem {
                id: fitmassSobre
                title: "Sobre o Fitmass"
                icon: IconType.info

                NavigationStack {
                    id: infoStack
                    anchors.fill: parent
                    initialPage: infoView

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
}
