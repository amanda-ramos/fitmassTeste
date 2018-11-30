import VPlayApps 1.0
import QtQuick 2.9

import "../common"
import "../pages"

Page {
    title: "Instruções"
    id: antropoInfoPage
    height: screenSizeY
    width: screenSizeX

    property int titleFontSize: root.sp(14)
    property int textFontSize: root.sp(12)
    property var titleTopPadding: root.dp(15)
    property var titleBottomPadding: root.dp(15)
    property var titleLeftPadding: root.dp(5)
    property var textRightPadding: root.dp(15)
    property var textLeftPadding: root.dp(15)
    property color titleColor: greenDark
    property color textColor: grayLight2

    AppFlickable {
        id: flickableInfo
        anchors.fill: parent
        contentHeight: content.height

        // remove focus from controls if clicked outside
        MouseArea {
            anchors.fill: parent
            onClicked: flickableInfo.forceActiveFocus()
        }

        Item {
            id: content
            width: parent.width
            height: row1.height + row2.height + row3.height + row4.height + row5.height + row6.height + row7.height + row8.height + root.dp(50)
            anchors.horizontalCenter: parent.horizontalCenter

            Item {
                id: row1
                width: parent.width
                height: introducao.height + antropo1.height
                anchors.top: parent.top

                Image {
                    id: antropo1
                    source: "../../assets/antropo-1.jpg"
                    width: parent.width - root.dp(20)
                    fillMode: Image.PreserveAspectFit
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                }

                Text {
                    id: introducao
                    width: parent.width
                    text: "Aprenda aqui como fazer todas as medidas corporais."
                    color: white
                    font.pixelSize: titleFontSize
                    horizontalAlignment: Text.AlignJustify
                    leftPadding: textLeftPadding
                    rightPadding: textRightPadding
                    topPadding: titleTopPadding
                    anchors.top: antropo1.bottom
                    anchors.left: parent.left
                    wrapMode: Text.WordWrap
                } // texto de introdução
            }

            Item {
                id: row2
                width: parent.width
                height: titleRowBiceps.height + columnBiceps.height
                anchors.top: row1.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: titleRowBiceps
                    width: parent.width
                    text: "Bíceps"
                    color: titleColor
                    font.bold: true
                    font.pixelSize: titleFontSize
                    horizontalAlignment: Text.AlignHCenter
                    anchors.top: parent.top
                    topPadding: titleTopPadding
                    leftPadding: titleLeftPadding
                    bottomPadding: titleBottomPadding
                } // Biceps - Título

                Item {
                    id: columnBiceps
                    width: parent.width / 2
                    height: ( antropo2.height > textRowBiceps.height) ? antropo2.height : textRowBiceps.height
                    anchors.top: titleRowBiceps.bottom
                    anchors.left: parent.left

                    Image {
                        id: antropo2
                        source: "../../assets/antropo-7.jpg"
                        width: parent.width - root.dp(20)
                        fillMode: Image.PreserveAspectFit
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Item {
                    width: parent.width / 2
                    height: ( antropo2.height > textRowBiceps.height) ? antropo2.height : textRowBiceps.height
                    anchors.top: titleRowBiceps.bottom
                    anchors.right: parent.right

                    Text {
                        id: textRowBiceps
                        width: parent.width
                        text: "Para essa medida pode-se aproveitar aquela marquinha da vacina BCG para facilitar sua vida.\n\nNormalmente essa medida é tirada com o braço esticado (músculo relaxado), porém, para quem visa à hipertrofia é normal que a mensuração seja feita com o músculo contraído."
                        color: textColor
                        font.pixelSize: textFontSize
                        horizontalAlignment: Text.AlignJustify
                        leftPadding: textLeftPadding
                        rightPadding: textRightPadding
                        anchors.top: parent.top
                        anchors.left: parent.left
                        wrapMode: Text.WordWrap
                    } // Biceps - Descrição
                }
            } // Row 2

            Item {
                id: row3
                width: parent.width
                height: titleRowForearm.height + columnForearm.height
                anchors.top: row2.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: titleRowForearm
                    width: parent.width
                    text: "Antebraço"
                    color: titleColor
                    font.bold: true
                    font.pixelSize: titleFontSize
                    horizontalAlignment: Text.AlignHCenter
                    anchors.top: parent.top
                    topPadding: titleTopPadding
                    leftPadding: titleLeftPadding
                    bottomPadding: titleBottomPadding
                } // Antebraço - Título

                Item {
                    id: columnForearm
                    width: parent.width / 2
                    height: ( antropo3.height > textRowForearm.height) ? antropo3.height : textRowForearm.height
                    anchors.top: titleRowForearm.bottom
                    anchors.left: parent.left

                    Text {
                        id: textRowForearm
                        width: parent.width
                        text: "Medir na maior circunferência, que geralmente fica a uns 2 ou 3 dedos abaixo do cotovelo."
                        color: textColor
                        font.pixelSize: textFontSize
                        horizontalAlignment: Text.AlignJustify
                        leftPadding: textLeftPadding
                        rightPadding: textRightPadding
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        wrapMode: Text.WordWrap
                    } // Antebraço - Descrição
                }

                Item {
                    width: parent.width / 2
                    height: ( antropo3.height > textRowForearm.height) ? antropo3.height : textRowForearm.height
                    anchors.top: titleRowForearm.bottom
                    anchors.right: parent.right

                    Image {
                        id: antropo3
                        source: "../../assets/antropo-8.jpg"
                        width: parent.width - root.dp(20)
                        fillMode: Image.PreserveAspectFit
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    } // Antebraço - Imagem
                }
            } // Row 3

            Item {
                id: row4
                width: parent.width
                height: titleRowChest.height + columnChest.height
                anchors.top: row3.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: titleRowChest
                    width: parent.width
                    text: "Peitoral"
                    color: titleColor
                    font.bold: true
                    font.pixelSize: titleFontSize
                    horizontalAlignment: Text.AlignHCenter
                    anchors.top: parent.top
                    topPadding: titleTopPadding
                    leftPadding: titleLeftPadding
                    bottomPadding: titleBottomPadding
                } // Peitoral - Título

                Item {
                    id: columnChest
                    width: parent.width / 2
                    height: ( antropo4.height > textRowChest.height) ? antropo4.height : textRowChest.height
                    anchors.top: titleRowChest.bottom
                    anchors.left: parent.left

                    Image {
                        id: antropo4
                        source: "../../assets/antropo-2.jpg"
                        width: parent.width - root.dp(20)
                        fillMode: Image.PreserveAspectFit
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    } // Peitoral - Imagem
                }

                Item {
                    width: parent.width / 2
                    height: ( antropo4.height > textRowChest.height) ? antropo4.height : textRowChest.height
                    anchors.top: titleRowChest.bottom
                    anchors.right: parent.right

                    Text {
                        id: textRowChest
                        width: parent.width
                        text: "Para essa região você deve estar em pé, ereto e com caixa toráxica relaxada.\nNormalmente a maior circunferência se dá com a fita mais próxima às axilas no caso dos homens, e passando pelos mamilos no caso das mulheres."
                        color: textColor
                        font.pixelSize: textFontSize
                        horizontalAlignment: Text.AlignJustify
                        leftPadding: textLeftPadding
                        rightPadding: textRightPadding
                        anchors.top: parent.top
                        anchors.left: parent.left
                        wrapMode: Text.WordWrap
                    } // Peitoral - Descrição
                }
            } // Row 4

            Item {
                id: row5
                width: parent.width
                height: titleRowWaist.height + columnWaist.height
                anchors.top: row4.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: titleRowWaist
                    width: parent.width
                    text: "Cintura"
                    color: titleColor
                    font.bold: true
                    font.pixelSize: titleFontSize
                    horizontalAlignment: Text.AlignHCenter
                    anchors.top: parent.top
                    topPadding: titleTopPadding
                    leftPadding: titleLeftPadding
                    bottomPadding: titleBottomPadding
                } // Cintura - Título

                Item {
                    id: columnWaist
                    width: parent.width / 2
                    height: ( antropo5.height > textRowWaist.height) ? antropo5.height : textRowWaist.height
                    anchors.top: titleRowWaist.bottom
                    anchors.left: parent.left

                    Text {
                        id: textRowWaist
                        width: parent.width
                        text: "Para medir a cintura devemos posicionar a fita métrica no “meio do caminho” entre a última costela e o osso ilíaco (aquele do quadril, sabe?). Normalmente essa posição é com a fita a um ou dois dedos acima do umbigo. Assim como para o peito, você deve estar em pé, ereto e com a respiração relaxada."
                        color: textColor
                        font.pixelSize: textFontSize
                        horizontalAlignment: Text.AlignJustify
                        leftPadding: textLeftPadding
                        rightPadding: textRightPadding
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        wrapMode: Text.WordWrap
                    } // Cintura - Descrição
                }

                Item {
                    width: parent.width / 2
                    height: ( antropo5.height > textRowWaist.height) ? antropo5.height : textRowWaist.height
                    anchors.top: titleRowWaist.bottom
                    anchors.right: parent.right

                    Image {
                        id: antropo5
                        source: "../../assets/antropo-3.jpg"
                        width: parent.width - root.dp(20)
                        fillMode: Image.PreserveAspectFit
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    } // Cintura - Imagem
                }
            } // Row 5

            Item {
                id: row6
                width: parent.width
                height: titleRowHip.height + columnHip.height
                anchors.top: row5.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: titleRowHip
                    width: parent.width
                    text: "Quadril"
                    color: titleColor
                    font.bold: true
                    font.pixelSize: titleFontSize
                    horizontalAlignment: Text.AlignHCenter
                    anchors.top: parent.top
                    topPadding: titleTopPadding
                    leftPadding: titleLeftPadding
                    bottomPadding: titleBottomPadding
                } // Quadril - Título

                Item {
                    id: columnHip
                    width: parent.width / 2
                    height: ( antropo6.height > textRowHip.height) ? antropo6.height : textRowHip.height
                    anchors.top: titleRowHip.bottom
                    anchors.left: parent.left

                    Image {
                        id: antropo6
                        source: "../../assets/antropo-4.jpg"
                        width: parent.width - root.dp(20)
                        fillMode: Image.PreserveAspectFit
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    } // Quadril - Imagem
                }

                Item {
                    width: parent.width / 2
                    height: ( antropo6.height > textRowHip.height) ? antropo6.height : textRowHip.height
                    anchors.top: titleRowHip.bottom
                    anchors.right: parent.right

                    Text {
                        id: textRowHip
                        width: parent.width
                        text: "Novamente o que conta é a região de maior circunferência do quadril, geralmente localizada no meio das nádegas."
                        color: textColor
                        font.pixelSize: textFontSize
                        horizontalAlignment: Text.AlignJustify
                        leftPadding: textLeftPadding
                        rightPadding: textRightPadding
                        anchors.top: parent.top
                        anchors.left: parent.left
                        wrapMode: Text.WordWrap
                    } // Quadril - Descrição
                }
            } // Row 6

            Item {
                id: row7
                width: parent.width
                height: titleRowTight.height + columnTight.height
                anchors.top: row6.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: titleRowTight
                    width: parent.width
                    text: "Coxa"
                    color: titleColor
                    font.bold: true
                    font.pixelSize: titleFontSize
                    horizontalAlignment: Text.AlignHCenter
                    anchors.top: parent.top
                    topPadding: titleTopPadding
                    leftPadding: titleLeftPadding
                    bottomPadding: titleBottomPadding
                } // Coxa - Título

                Item {
                    id: columnTight
                    width: parent.width / 2
                    height: ( antropo7.height > textRowTight.height) ? antropo7.height : textRowTight.height
                    anchors.top: titleRowTight.bottom
                    anchors.left: parent.left

                    Text {
                        id: textRowTight
                        width: parent.width
                        text: "Como nas anteriores, a medição da coxa deve ser feita na região de maior circunferência da mesma. Mas nunca se esqueça de que o mais importante é manter a consistência nas medida. Portanto, se você tem alguma pinta ou marca permanente para se basear, use-a a seu favor."
                        color: textColor
                        font.pixelSize: textFontSize
                        horizontalAlignment: Text.AlignJustify
                        leftPadding: textLeftPadding
                        rightPadding: textRightPadding
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        wrapMode: Text.WordWrap
                    } // Coxa - Descrição
                }

                Item {
                    width: parent.width / 2
                    height: ( antropo7.height > textRowTight.height) ? antropo7.height : textRowTight.height
                    anchors.top: titleRowTight.bottom
                    anchors.right: parent.right

                    Image {
                        id: antropo7
                        source: "../../assets/antropo-5.jpg"
                        width: parent.width - root.dp(20)
                        fillMode: Image.PreserveAspectFit
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    } // Coxa - Imagem
                }
            } // Row 7

            Item {
                id: row8
                width: parent.width
                height: titleRowCalf.height + columnCalf.height
                anchors.top: row7.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: titleRowCalf
                    width: parent.width
                    text: "Panturrilha"
                    color: titleColor
                    font.bold: true
                    font.pixelSize: titleFontSize
                    horizontalAlignment: Text.AlignHCenter
                    anchors.top: parent.top
                    topPadding: titleTopPadding
                    leftPadding: titleLeftPadding
                    bottomPadding: titleBottomPadding
                } // Panturrilha - Título

                Item {
                    id: columnCalf
                    width: parent.width / 2
                    height: ( antropo8.height > textRowCalf.height) ? antropo8.height : textRowCalf.height
                    anchors.top: titleRowCalf.bottom
                    anchors.left: parent.left

                    Image {
                        id: antropo8
                        source: "../../assets/antropo-6.jpg"
                        width: parent.width - root.dp(20)
                        fillMode: Image.PreserveAspectFit
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    } // Panturrilha - Imagem
                }

                Item {
                    width: parent.width / 2
                    height: ( antropo8.height > textRowCalf.height) ? antropo8.height : textRowCalf.height
                    anchors.top: titleRowCalf.bottom
                    anchors.right: parent.right

                    Text {
                        id: textRowCalf
                        width: parent.width
                        text: "A maior circunferência normalmente fica a uns 4 ou 5 dedos abaixo do joelho."
                        color: textColor
                        font.pixelSize: textFontSize
                        horizontalAlignment: Text.AlignJustify
                        leftPadding: textLeftPadding
                        rightPadding: textRightPadding
                        anchors.top: parent.top
                        anchors.left: parent.left
                        wrapMode: Text.WordWrap
                    } // Panturrilha - Descrição
                }
            } // Row 8
        }
    }

    ScrollIndicator {
        flickable: flickableInfo
    } // scroll indicator
}
