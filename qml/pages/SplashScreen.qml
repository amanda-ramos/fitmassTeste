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

    backgroundColor: bgColor

    Rectangle {
        id: backgroundSplash
        width: splashScreenPage.width
        height: splashScreenPage.height
        anchors.centerIn: parent
        color: bgColor

        AppImage{
            id:logoFitmass
            source: "../../assets/fitmass_new_logo_branca.png"
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
        interval: 4000; running: true; repeat: false
        onTriggered: {
            stack.push(entrarView)
        }
    }
}
