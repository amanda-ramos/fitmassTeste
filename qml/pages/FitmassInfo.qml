import VPlayApps 1.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2
import QtQuick.Controls.Material 2.0
import "../common"
import "../pages"

Page {
    title: "Informações"
    id: fitmassInfo
    height: screenSizeY
    width: screenSizeX

    property int titleFontSize: root.sp(16)
    property var titleTopPadding: root.dp(15)
    property var titleBottomPadding: root.dp(15)
    property var titleLeftPadding: root.dp(5)
    property var textRightPadding: root.dp(15)
    property var textLeftPadding: root.dp(15)
    property color titleColor: greenDark
    property color textColor: white


    AppFlickable {
        id: scrollFitmass
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
            onClicked: scrollFitmass.forceActiveFocus()
        }

        Item {
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
                        font.pixelSize: titleFontSize
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
                            width: parent.width - root.dp(10)
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
                            id: textDetails
                            width: parent.width
                            text: "Versão alfa\n\nAplicativo para acompanhamento de medidas corporais."
                            color: textColor
                            horizontalAlignment: Text.AlignJustify
                            rightPadding: textRightPadding
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            wrapMode: Text.WordWrap
                            font.pixelSize: root.sp(12)
                        }
                    }
                }
            }

            Item{
                anchors.bottom: parent.bottom
                width: parent.width
                height: copyrights.height

                Text {
                    id: copyrights
                    width: parent.width
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Copyright 2018 Massa Pesagem e Automação\nTodos os direitos reservados\n\n"
                    horizontalAlignment: Text.AlignHCenter
                    color: grayLight
                    font.pixelSize: root.sp(8)
                }
            }
        } // column - conteúdo info
    } // flickable

    ScrollIndicator {
        flickable: scrollFitmass
    } // scroll indicator
}
