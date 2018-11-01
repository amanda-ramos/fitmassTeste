import VPlayApps 1.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2
import QtQuick.Controls.Material 2.0
import "../common"
import "../pages"

Page {
    title: "Fitmass"
    id: fitmassInfo
    height: 960
    width: 640

    property int titleFontSize: 6
    property var titleTopPadding: dp(15)
    property var titleBottomPadding: dp(15)
    property var titleLeftPadding: dp(5)
    property var textRightPadding: dp(15)
    property var textLeftPadding: dp(15)
    property color titleColor: verdeMassa
    property color textColor: "#4b4b4b"


    AppFlickable {
        id: scrollFitmass
        anchors.fill: parent
        contentHeight: content.height

        // remove focus from controls if clicked outside
        MouseArea {
            anchors.fill: parent
            onClicked: scrollFitmass.forceActiveFocus()
        }

        Column {
            id: contentFitmass
            width: parent.width
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter

            Item {
                width: parent.width
                height: row1Fitmass.height

                Row {
                    id: row1Fitmass
                    width: parent.width
                    height: titleRowVersao.height + colVersao1.height
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: titleRowVersao
                        width: parent.width
                        text: "Fitmass 1.0"
                        color: titleColor
                        font.bold: true
                        font.pointSize: sp(titleFontSize)
                        horizontalAlignment: Text.AlignHCenter
                        topPadding: titleTopPadding
                        leftPadding: titleLeftPadding
                        bottomPadding: titleBottomPadding
                        anchors.left: parent.left
                    }

                    Column{
                        id: colVersao1
                        width: parent.width / 3
                        height: width / 2
                        anchors.verticalCenter: colVersao2.verticalCenter
                        anchors.left: parent.left

                        Image {
                            id: imageLogo
                            width: parent.width - dp(10)
                            source: "../../assets/fitmass_logo.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            fillMode: Image.PreserveAspectFit
                        }
                    }

                    Column {
                        id: colVersao2
                        width: parent.width * 2 / 3
                        height: colVersao1.height
                        anchors.top: titleRowVersao.bottom
                        anchors.right: parent.right

                        Text {
                            id: textRowAnaliseCompCorporal
                            width: parent.width
                            text: "Versão alfa\n\nAplicativo para acompanhamento de medidas corporais."
                            color: textColor
                            horizontalAlignment: Text.AlignJustify
                            rightPadding: textRightPadding
                            anchors.top: titleRowAnaliseCompCorporal.bottom
                            //anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            wrapMode: Text.WordWrap
                            font.pointSize: sp(4)
                        }
                    }
                }
            }
            Item{
                anchors.bottom: parent.bottom
                width: parent.width
                Text {
                    id: copyrights
                    width: parent.width
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Copyright 2018 Massa Pesagem e Automação\nTodos os direitos reservados\n\n"
                    horizontalAlignment: Text.AlignHCenter
                    color: "#d6d6d6"
                    font.pointSize: dp(4)
                }
            }
        } // column - conteúro info
    } // flickable

    ScrollIndicator {
        flickable: scrollFitmass
    } // scroll indicator
}
