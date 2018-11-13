import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2

import "../common"
import "../pages"

Page {
    id: splashScreenPage
    height: screenSizeY
    width: screenSizeX

    Rectangle {
        id: backgroundSplash
        width: splashScreenPage.width
        height: splashScreenPage.height
        anchors.centerIn: parent
        color: bgColor

        AppImage{
            id:logoFitmass
            source: logoFitmassBrancaSource
            fillMode: Image.PreserveAspectFit
            height: dp(30)
            anchors.centerIn: parent
        }
    }

    BusyIndicatorFitmass {
        id: busyIndication
        width: logoFitmass.width + dp(50)
        height: width
        anchors.centerIn: parent
        running: true
    }

    Timer {
        interval: 4000;
        running: true; repeat: false
        onTriggered: {
            // Código para direcionar para página principal caso já esteja logado
            //
            //

            // Temporário: direciona para página de login
            stack.push(entrarView)
        }
    }
}
