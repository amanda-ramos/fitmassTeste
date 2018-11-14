import VPlayApps 1.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2
import QtQuick.Controls.Material 2.0
import "../common"
import "../pages"

Page {
    title: "Informações"
    id: infoPage
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
        id: scrollInfo
        anchors.fill: parent
        contentHeight: content.height

        // remove focus from controls if clicked outside
        MouseArea {
            anchors.fill: parent
            onClicked: scrollInfo.forceActiveFocus()
        }

        Item {
            id: content
            width: parent.width
            height: row1.height + row2.height + row3.height + row4.height + row5.height + root.dp(50)
            anchors.horizontalCenter: parent.horizontalCenter

            Item {
                width: parent.width
                height: row1.height + row2.height + row3.height + row4.height + row5.height + root.dp(50)

                Item {
                    id: row1
                    width: parent.width
                    height: titleRowAnaliseCompCorporal.height + textRowAnaliseCompCorporal.height
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: titleRowAnaliseCompCorporal
                        width: parent.width
                        text: "Análise da Composição Corporal"
                        color: titleColor
                        font.bold: true
                        font.pixelSize: titleFontSize
                        horizontalAlignment: Text.AlignJustify
                        topPadding: titleTopPadding
                        leftPadding: titleLeftPadding
                        bottomPadding: titleBottomPadding
                        anchors.left: parent.left
                    } // Análise da Composição Corporal - Título

                    Text {
                        id: textRowAnaliseCompCorporal
                        width: parent.width
                        text: "O peso do corpo é a soma da Água Corporal Total, Proteínas, Minerais e Massa de Gordura. Mantenha uma composição corporal equilibrada para se manter saudável."
                        color: textColor
                        font.pixelSize: textFontSize
                        horizontalAlignment: Text.AlignJustify
                        leftPadding: textLeftPadding
                        rightPadding: textRightPadding
                        anchors.top: titleRowAnaliseCompCorporal.bottom
                        anchors.left: parent.left
                        wrapMode: Text.WordWrap
                    } // Análise da Composição Corporal - Descrição
                } // Row 1

                Item {
                    id: row2
                    width: parent.width
                    height: titleRowAnaliseMuscGord.height + textRowAnaliseMuscGord.height
                    anchors.top: row1.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: titleRowAnaliseMuscGord
                        width: parent.width
                        text: "Análise Músculo - Gordura"
                        color: titleColor
                        font.bold: true
                        font.pixelSize: titleFontSize
                        horizontalAlignment: Text.AlignJustify
                        anchors.top: parent.top
                        topPadding: titleTopPadding
                        leftPadding: titleLeftPadding
                        bottomPadding: titleBottomPadding
                    } // Análise Músculo - Gordura - Título

                    Text {
                        id: textRowAnaliseMuscGord
                        width: parent.width
                        text: "Compare os comprimentos das barras da massa muscular esquelética e massa de gordura. Quanto maior a barra da massa muscular esquelética comparada com a barra de massa de gordura corporal, mais forte o corpo está. Massa muscular esquelética é a quantidade de músculo ligado aos ossos. A Massa de gordura corporal é a soma de gordura subcutânea, gordura visceral, gordura em volta dos músculos. A gordura subcutânea é encontrada sob a pele, enquanto a gordura visceral encontra-se em torno dos órgãos internos do abdômen."
                        color: textColor
                        font.pixelSize: textFontSize
                        horizontalAlignment: Text.AlignJustify
                        leftPadding: textLeftPadding
                        rightPadding: textRightPadding
                        anchors.top: titleRowAnaliseMuscGord.bottom
                        anchors.left: parent.left
                        wrapMode: Text.WordWrap
                    } // Análise Músculo - Gordura - Descrição
                } // Row 2

                Item {
                    id: row3
                    width: parent.width
                    height: titleRowAnaliseObes.height + textRowAnaliseObes.height
                    anchors.top: row2.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: titleRowAnaliseObes
                        width: parent.width
                        text: "Análise de Obesidade"
                        color: titleColor
                        font.bold: true
                        font.pixelSize: titleFontSize
                        horizontalAlignment: Text.AlignJustify
                        anchors.top: parent.top
                        topPadding: titleTopPadding
                        leftPadding: titleLeftPadding
                        bottomPadding: titleBottomPadding
                    } // Análise de Obesidade - Título

                    Text {
                        id: textRowAnaliseObes
                        width: parent.width
                        text: "O IMC é um índice utilizado para determinar a obesidade, através da altura e peso.\n\nIMC = peso/altura² (kg/m²).\n\nO PGC é a porcentual de gordura corporal em relação ao peso corporal."
                        color: textColor
                        font.pixelSize: textFontSize
                        horizontalAlignment: Text.AlignJustify
                        leftPadding: textLeftPadding
                        rightPadding: textRightPadding
                        anchors.top: titleRowAnaliseObes.bottom
                        anchors.left: parent.left
                        wrapMode: Text.WordWrap
                    } // Análise de Obesidade - Descrição
                } // Row 3

                Item {
                    id: row4
                    width: parent.width
                    height: titleRowAnaliseSegMagra.height + textRowAnaliseSegMagra.height
                    anchors.top: row3.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: titleRowAnaliseSegMagra
                        width: parent.width
                        text: "Análise Segmentar da Massa Magra"
                        color: titleColor
                        font.bold: true
                        font.pixelSize: titleFontSize
                        horizontalAlignment: Text.AlignJustify
                        anchors.top: parent.top
                        topPadding: titleTopPadding
                        leftPadding: titleLeftPadding
                        bottomPadding: titleBottomPadding
                    } // Análise Segmentar da Massa Magra - Título

                    Text {
                        id: textRowAnaliseSegMagra
                        width: parent.width
                        text: "Avalia se a quantidade de músculos está distribuída de maneira adequada em todas as partes do corpo. Compara a massa muscular atual em relação à ideal."
                        color: textColor
                        font.pixelSize: textFontSize
                        horizontalAlignment: Text.AlignJustify
                        leftPadding: textLeftPadding
                        rightPadding: textRightPadding
                        anchors.top: titleRowAnaliseSegMagra.bottom
                        anchors.left: parent.left
                        wrapMode: Text.WordWrap
                    } // Análise Segmentar da Massa Magra - Descrição
                } // Row 4

                Item {
                    id: row5
                    width: parent.width
                    height: titleRowAnaliseSegGorda.height + titleRowAnaliseSegMagra.height
                    anchors.top: row4.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: titleRowAnaliseSegGorda
                        width: parent.width
                        text: "Análise Segmentar da Massa de Gordura"
                        color: titleColor
                        font.bold: true
                        font.pixelSize: titleFontSize
                        horizontalAlignment: Text.AlignJustify
                        anchors.top: parent.top
                        topPadding: titleTopPadding
                        leftPadding: titleLeftPadding
                        bottomPadding: titleBottomPadding
                    } // Análise Segmentar da Massa de Gordura - Título

                    Text {
                        id: textRowAnaliseSegGorda
                        width: parent.width
                        text: "Avalia se a quantidade de gordura é distribuída de maneira adequada em todas as partes do corpo. Compara a massa gorda ao ideal."
                        color: textColor
                        font.pixelSize: textFontSize
                        horizontalAlignment: Text.AlignJustify
                        leftPadding: textLeftPadding
                        rightPadding: textRightPadding
                        anchors.top: titleRowAnaliseSegGorda.bottom
                        anchors.left: parent.left
                        wrapMode: Text.WordWrap
                    } // Análise Segmentar da Massa de Gordura - Descrição
                } // Row 5
            }
        }
    }

    ScrollIndicator {
        flickable: scrollInfo
    } // scroll indicator
}
