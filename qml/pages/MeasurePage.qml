import VPlayApps 1.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2
import QtQuick.Controls.Material 2.0

import "../common"
import "../pages"

Page {
    id: measurePage
    title: "Medida"
    height: screenSizeY
    width: screenSizeX

    property var teste2

    property var weightValor
    property var muscleValor
    property var bodyFatValor
    property var waterValor
    property alias dateValor: measurePage.title
    property var wantedWeightValor

    property var titleFontSize: root.sp(14)
    property var titleTopPadding: root.dp(15)
    property var titleBottomPadding: root.dp(15)
    property real titleHorizontalAlignment: Text.AlignHCenter
    property var textRightPadding: root.dp(15)
    property var textLeftPadding: root.dp(15)

    property color titleColor: greenDark
    property color textColor: greenLight

    // Ícones na barra de navegação superior
    rightBarItem:  NavigationBarRow {
      id: rightNavBarRowMeasure

      // Ícone para compartilhar resultados
      IconButtonBarItem {
          title: "Compartilhar"
          icon: IconType.sharealt

          onClicked: {
            var teste = contentMeasure.grabToImage(function(result){
                    teste2 = result.saveToFile("medida2.jpg")
                    nativeUtils.share("Link da imagem: " + result.url, "")
                    console.log("SAVE IMAGE: " + teste2)
            })
             console.log("GRAB IMAGE: " + teste)
        }
      }

      // Ícone para deletar a medida
      IconButtonBarItem {
          title: "Deletar"
          icon: IconType.trash

          onClicked: {
              console.log("DELETAR Dialog - key: " + keyCard)
              nativeUtils.displayAlertDialog("Atenção", "Tem certeza que deseja deletar essa medida? Os dados serão perdidos.", "Sim", "Não")
          }

          Connections {
              target: nativeUtils

              onAlertDialogFinished: {
                  if(accepted){
                      // Código para deletar medida
                      //
                      //
                  }
              }
          }
        }
    }

    AppFlickable {
        id: scrollMeasure
        anchors.fill: parent
        contentHeight: contentMeasure.height

        MouseArea {
            anchors.fill: parent
            onClicked: {
                scrollMeasure.forceActiveFocus()
            }
        }

        Item {
            id: contentMeasure
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            height: measureItemSource.height

            Item {
                id: measureItemSource
                width: parent.width
                height: titleRowAnaliseCompCorporal.height + analiseCompCorporal.height + titleRowAnaliseMusculoGordura.height +
                        analiseMusculoGordura_peso.height + analiseMusculoGordura_Magra.height + analiseMusculoGordura_Gorda.height
                        + titleRowAnaliseObesidade.height + analiseObesidade1.height
                        + analiseObesidade2.height + titleRowAnaliseSegmentarMagra.height
                        + analiseSegmentarMagra.height + titleRowAnaliseSegmentarGorda.height + analiseSegmentarGorda.height
                        + titleRowControlePeso.height + controlePeso.height + info.height

                Text {
                    id: titleRowAnaliseCompCorporal
                    width: parent.width
                    text: "Análise da Composição Corporal"
                    color: titleColor
                    font.bold: true
                    font.pixelSize: titleFontSize
                    horizontalAlignment: titleHorizontalAlignment
                    topPadding: titleTopPadding
                    bottomPadding: titleBottomPadding
                } // Análise da Composição Corporal - Título

                Item {
                    id: analiseCompCorporal
                    width: parent.width
                    height: peso.height
                    anchors.top: titleRowAnaliseCompCorporal.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    Item {
                        id: peso
                        height: iconPeso.height + txtPeso1.height + weightValue.height + root.dp(20)
                        width: parent.width / 4
                        anchors.left: parent.left

                        Text {
                            id: txtPeso1
                            width: parent.width / 4
                            text: "\npeso"
                            horizontalAlignment: Text.AlignHCenter
                            color: white
                            font.pixelSize: root.dp(10)
                            topPadding: root.dp(10)
                            anchors.horizontalCenter: iconPeso.horizontalCenter
                            anchors.bottom: iconPeso.top
                            bottomPadding: root.dp(5)
                        }
                        Image {
                            id: iconPeso
                            source: "../../assets/icon_weight2.png"
                            height: root.dp(50)
                            width: height
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            id: weightValue
                            width: parent.width / 4
                            text: ""
                            color: white
                            font.pixelSize: root.dp(12)
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: iconPeso.horizontalCenter
                            anchors.top: iconPeso.bottom
                            topPadding: root.dp(10)
                        }
                    } // Peso

                    Item {
                        id: massaMagra
                        height: peso.height
                        width: parent.width / 4
                        anchors.left: peso.right

                        Text {
                            id: txtMagra1
                            width: parent.width / 4
                            text: "massa\nmagra"
                            horizontalAlignment: Text.AlignHCenter
                            color: white
                            font.pixelSize: root.dp(10)
                            topPadding: root.dp(10)
                            anchors.horizontalCenter: iconMassaMagra.horizontalCenter
                            anchors.bottom: iconMassaMagra.top
                            bottomPadding: root.dp(5)
                        }
                        Image {
                            id: iconMassaMagra
                            source: "../../assets/icon_muscle2.png"
                            height: root.dp(50)
                            width: height
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            id: muscleValue
                            width: parent.width / 4
                            text: ""
                            color: white
                            font.pixelSize: root.dp(12)
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: iconMassaMagra.horizontalCenter
                            anchors.top: iconMassaMagra.bottom
                            topPadding: root.dp(10)
                        }
                    } // Massa Magra

                    Item {
                        id: massaGorda
                        height: peso.height
                        width: parent.width / 4
                        anchors.left: massaMagra.right

                        Text {
                            text: "massa de\ngordura"
                            width: parent.width / 4
                            horizontalAlignment: Text.AlignHCenter
                            color: white
                            font.pixelSize: root.dp(10)
                            topPadding: root.dp(10)
                            anchors.horizontalCenter: iconMassaGorda.horizontalCenter
                            anchors.bottom: iconMassaGorda.top
                            bottomPadding: root.dp(5)
                        }
                        Image {
                            id: iconMassaGorda
                            source: "../../assets/icon_body_fat2.png"
                            height: root.dp(50)
                            width: height
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            id: bodyFatValue
                            width: parent.width / 4
                            text: ""
                            color: white
                            font.pixelSize: root.dp(12)
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: iconMassaGorda.horizontalCenter
                            anchors.top: iconMassaGorda.bottom
                            topPadding: root.dp(10)
                        }
                    } // Massa de Gordura

                    Item {
                        id: agua
                        height: peso.height
                        width: parent.width / 4
                        anchors.left: massaGorda.right

                        Text {
                            text: "água no\ncorpo"
                            width: parent.width / 4
                            horizontalAlignment: Text.AlignHCenter
                            color: white
                            font.pixelSize: root.dp(10)
                            topPadding: root.dp(10)
                            anchors.horizontalCenter: iconAgua.horizontalCenter
                            anchors.bottom: iconAgua.top
                            bottomPadding: root.dp(5)
                        }
                        Image {
                            id: iconAgua
                            source: "../../assets/icon_water2.png"
                            height: root.dp(50)
                            width: height
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            id: waterValue
                            width: parent.width / 4
                            text: ""
                            color: white
                            font.pixelSize: root.dp(12)
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: iconAgua.horizontalCenter
                            anchors.top: iconAgua.bottom
                            topPadding: root.dp(10)
                        }
                    } // Água no Corpo
                } // Análise da Composição Corporal - Conteúdo

                Text {
                    id: titleRowAnaliseMusculoGordura
                    width: parent.width
                    text: "Análise Músculo - Gordura"
                    color: titleColor
                    font.bold: true
                    font.pixelSize: titleFontSize
                    horizontalAlignment: titleHorizontalAlignment
                    topPadding: titleTopPadding
                    bottomPadding: titleBottomPadding
                    anchors.top: analiseCompCorporal.bottom
                } // Análise Músculo - Gordura - Título

                Item {
                    id: analiseMusculoGordura_peso
                    width: parent.width
                    height: weightBar.height
                    anchors.top: titleRowAnaliseMusculoGordura.bottom

                    BarraProgressoSimples {
                        id: weightBar
                        height: root.dp(60)
                        title: "Peso"
                        subtitle: ""
                        titleValue: value + " kg"
                        anchors.top: parent.top
                        min: 0
                        max: 180
                        value: 0
                    }
                } // Análise Músculo - Gordura - Peso

                Item {
                    id: analiseMusculoGordura_Magra
                    width: parent.width
                    height: weightBar.height
                    anchors.top: analiseMusculoGordura_peso.bottom

                    BarraProgressoSimples {
                        id: muscleBar
                        height: root.dp(60)
                        title: "Massa Magra"
                        subtitle: ""
                        titleValue: value + " kg"
                        anchors.top: weightBar.bottom
                        min: 0
                        max: 80
                        value: 0
                    }
                } // Análise Músculo - Gordura - Massa Magra

                Item {
                    id: analiseMusculoGordura_Gorda
                    width: parent.width
                    height: muscleBar.height
                    anchors.top: analiseMusculoGordura_Magra.bottom

                    BarraProgressoSimples {
                        id: bodyFatBar
                        height: root.dp(60)
                        title: "Massa de Gordura"
                        subtitle: ""
                        titleValue: value + " kg"
                        anchors.top: muscleBar.bottom
                        min: 0
                        max: 80
                        value: 0
                    }
                } // Análise Músculo - Gordura - Massa de Gordura

                Text {
                    id: titleRowAnaliseObesidade
                    width: parent.width
                    text: "Análise de Obesidade"
                    color: titleColor
                    font.bold: true
                    font.pixelSize: titleFontSize
                    horizontalAlignment: titleHorizontalAlignment
                    topPadding: titleTopPadding
                    bottomPadding: titleBottomPadding
                    anchors.top: analiseMusculoGordura_Gorda.bottom
                } // Análise de Obesidade - Título

                Item {
                    id: analiseObesidade1
                    width: parent.width
                    height: imcBar.height
                    anchors.top: titleRowAnaliseObesidade.bottom

                    BarraProgresso {
                        id: imcBar
                        height: root.dp(80)
                        title: "IMC"
                        subtitle: "(índice de massa corporal)"
                        titleValue: value + " km/m²"
                        anchors.top: parent.top
                        min: 0
                        max: 50
                        value: 0
                        lowValue: 18.5
                        highValue: 25
                    }
                } // Análise de Obesidade - IMC

                Item {
                    id: analiseObesidade2
                    width: parent.width
                    height: pgcBar.height
                    anchors.top: analiseObesidade1.bottom

                    BarraProgresso {
                        id: pgcBar
                        height: root.dp(80)
                        title: "PGC"
                        subtitle: "(porcentual de gordura corporal)"
                        titleValue: value + " %"
                        anchors.top: imcBar.bottom
                        min: 0
                        max: 100
                        value: 0
                        lowValue: lowValueCalculate ()
                        highValue: highValueCalculate ()

                        function lowValueCalculate () {
                            if (userGender === "Feminino") {
                                if (userAge < 30)
                                    return 20;
                                if (userAge > 29 && userAge < 40)
                                    return 21;
                                if (userAge > 39 && userAge < 50)
                                    return 22;
                                if (userAge > 49)
                                    return 23;
                            }
                            if (userGender === "Masculino") {
                                if (userAge < 30)
                                    return 14;
                                if (userAge > 29 && userAge < 40)
                                    return 15;
                                if (userAge > 39 && userAge < 50)
                                    return 17;
                                if (userAge > 49)
                                    return 18;
                            }
                        }

                        function highValueCalculate () {
                            if (userGender === "Feminino") {
                                if (userAge < 30)
                                    return 28;
                                if (userAge > 29 && userAge < 40)
                                    return 29;
                                if (userAge > 39 && userAge < 50)
                                    return 30;
                                if (userAge > 49)
                                    return 31;
                            }
                            if (userGender === "Masculino") {
                                if (userAge < 30)
                                    return 20;
                                if (userAge > 29 && userAge < 40)
                                    return 21;
                                if (userAge > 39 && userAge < 50)
                                    return 23;
                                if (userAge > 49)
                                    return 24;
                            }
                        }
                    }
                } // Análise de Obesidade - PGC

                Text {
                    id: titleRowAnaliseSegmentarMagra
                    width: parent.width
                    text: "Análise Segmentar de Massa Magra"
                    color: titleColor
                    font.bold: true
                    font.pixelSize: titleFontSize
                    horizontalAlignment: titleHorizontalAlignment
                    topPadding: titleTopPadding
                    bottomPadding: titleBottomPadding
                    anchors.top: analiseObesidade2.bottom
                } // Análise Segmentar de Massa Magra - Título

                Item {
                    id: analiseSegmentarMagra
                    width: parent.width
                    height: segmentarMagra.height
                    anchors.top: titleRowAnaliseSegmentarMagra.bottom

                    SegmentarCard {
                        id: segmentarMagra

                        imgSource: (userGender === "Feminino") ? "../../assets/silhueta_mulherMagra.png" : "../../assets/silhueta_homemMagro.png"

                        membSupEsqTitle: "Membros Superiores"
                        membSupEsqSubtitle: "Esquerdo"
                        membSupEsqValor: "2.5 kg | 123.1 %"
                        membSupEsqAnalise: "Acima da média"

                        abdTitle: "Região Abdominal"
                        abdSubtitle: ""
                        abdValor: "21.4 kg | 95.2 %"
                        abdAnalise: "Normal"

                        membInfEsqTitle: "Membros Inferiores"
                        membInfEsqSubtitle: "Esquerdo"
                        membInfEsqValor: "7.51 kg | 97.6 %"
                        membInfEsqAnalise: "Normal"

                        membSupDirTitle: "Membros Superiores"
                        membSupDirSubtitle: "Direito"
                        membSupDirValor: "2.5 kg | 120.6 %"
                        membSupDirAnalise: "Acima da média"

                        membInfDirTitle: "Membros Inferiores"
                        membInfDirSubtitle: "Direito"
                        membInfDirValor: "7.31 kg | 95.1 %"
                        membInfDirAnalise: "Normal"
                    }
                } // Análise Segmentar de Massa Magra - Conteúdo

                Text {
                    id: titleRowAnaliseSegmentarGorda
                    width: parent.width
                    text: "Análise Segmentar de Massa de Gordura"
                    color: titleColor
                    font.bold: true
                    font.pixelSize: titleFontSize
                    horizontalAlignment: titleHorizontalAlignment
                    topPadding: titleTopPadding
                    bottomPadding: titleBottomPadding
                    anchors.top: analiseSegmentarMagra.bottom
                } // Análise Segmentar de Massa de Gordura - Título

                Item {
                    id: analiseSegmentarGorda
                    width: parent.width
                    height: segmentarMagra.height
                    anchors.top: titleRowAnaliseSegmentarGorda.bottom

                    SegmentarCard {
                        id: segmentarGorda

                        imgSource: (userGender === "Feminino") ? "../../assets/silhueta_mulherGorda.png" : "../../assets/silhueta_homemGordo.png"

                        membSupEsqTitle: "Membros Superiores"
                        membSupEsqSubtitle: "Esquerdo"
                        membSupEsqValor: "1.7 kg | 174.1 %"
                        membSupEsqAnalise: "Acima da média"

                        abdTitle: "Região Abdominal"
                        abdSubtitle: ""
                        abdValor: "12.5 kg | 224.8 %"
                        abdAnalise: "Acima da média"

                        membInfEsqTitle: "Membros Inferiores"
                        membInfEsqSubtitle: "Esquerdo"
                        membInfEsqValor: "3.7 kg | 145.9 %"
                        membInfEsqAnalise: "Normal"

                        membSupDirTitle: "Membros Superiores"
                        membSupDirSubtitle: "Direito"
                        membSupDirValor: "1.8 kg | 176.5 %"
                        membSupDirAnalise: "Acima da média"

                        membInfDirTitle: "Membros Inferiores"
                        membInfDirSubtitle: "Direito"
                        membInfDirValor: "3.7 kg | 145.4 %"
                        membInfDirAnalise: "Normal"
                    }
                } // Análise Segmentar de Massa de Gordura - Conteúdo

                Text {
                    id: titleRowControlePeso
                    width: parent.width
                    text: "Controle de Peso"
                    color: titleColor
                    font.bold: true
                    font.pixelSize: titleFontSize
                    horizontalAlignment: titleHorizontalAlignment
                    topPadding: titleTopPadding
                    bottomPadding: titleBottomPadding
                    anchors.top: analiseSegmentarGorda.bottom
                } // Controle de Peso - Título

                Item {
                    id: controlePeso
                    width: parent.width
                    height: balanca.height + space2.height
                    anchors.top: titleRowControlePeso.bottom

                    Rectangle {
                        id: space3
                        height: root.dp(15)
                        width: parent.width
                        color: "transparent"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                    }

                        Image {
                            id: balanca
                            height: root.dp(140)
                            width: height
                            source: (weightValor >= wantedWeightValor) ? "../../assets/image_comparison_more.png" : "../../assets/im‎age_comparison_less.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: space3.bottom
                        }

                        Item {
                            id: controlePeso1
                            width: parent.width / 4
                            height: balanca.height
                            anchors.left: parent.left
                        }

                        Item {
                            id: controlePeso2
                            width: parent.width / 4
                            height: balanca.height
                            anchors.left: controlePeso1.right

                            Text {
                                id: pesoAtual
                                text: "Peso atual"
                                color: grayLight2
                                font.bold: true
                                anchors.horizontalCenter: parent.horizontalCenter
                                topPadding: (weightValor >= wantedWeightValor) ? root.dp(35) : root.dp(10)
                                font.pixelSize: root.sp(10)
                            }

                            Text {
                                id: pesoAtualValor
                                text: ""
                                color: contrastColor3
                                font.bold: true
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: pesoAtual.bottom
                                font.pixelSize: root.sp(12)
                            }
                        }

                        Item {
                            id: controlePeso3
                            width: parent.width / 4
                            height: balanca.height
                            anchors.left: controlePeso2.right

                            Text {
                                id: pesoDesejado
                                text: "Peso desejado"
                                color: grayLight2
                                font.bold: true
                                anchors.horizontalCenter: parent.horizontalCenter
                                topPadding: (weightValor >= wantedWeightValor) ? root.dp(10) : root.dp(35)
                                font.pixelSize: root.sp(10)
                            }

                            Text {
                                id: pesoDesejadoValor
                                text: wantedWeightValor + " kg"
                                color: contrastColor3
                                font.bold: true
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: pesoDesejado.bottom
                                font.pixelSize: root.sp(12)
                            }
                        }
                } // Controle de Peso - Conteúdo

                Item {
                    id: info
                    width: parent.width
                    height: iconInfo.height + space2.height
                    anchors.top: controlePeso.bottom

                    Item {
                        width: parent.width
                        height: iconInfo.height+ space2.height

                        Image {
                            id: iconInfo
                            height: dp(30)
                            width: height
                            source: "../../assets/icon_info.png"
                            anchors.right: space1.left
                            anchors.bottom: space2.top

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    var infopage = infoView.createObject()
                                    fitmassStack.push(infopage)
                                }
                            }
                        }

                        Rectangle {
                            id: space1
                            height: iconInfo.height
                            width: dp(20)
                            color: "transparent"
                            anchors.right: parent.right
                        }
                    }

                    Rectangle {
                        id: space2
                        anchors.bottom: parent.bottom
                        height: dp(20)
                        width: iconInfo.height
                        color: "transparent"
                    }
                } // Informações - Conteúdo
            }
        }

        Component.onCompleted: {
            console.log(keyCard)

            // Código para recuperar dados do banco de dados
            //
            //

            // Temporário: pega os valores de um vetor fixo no Main.qml

            if(keyCard == 0){
                keyCard = medida0
                keyCard2 = medida0Magra
                keyCard3 = medida0Gorda
            }
            if(keyCard == 1){
                keyCard = medida1
                keyCard2 = medida1Magra
                keyCard3 = medida1Gorda
            }
            if(keyCard == 2){
                keyCard = medida2
                keyCard2 = medida2Magra
                keyCard3 = medida2Gorda
            }

            console.log("MEDIDA CARD - keycard: " + keyCard[0])

                    weightValue.text = keyCard[1]+ " kg"
                    muscleValue.text = keyCard[2] + " kg"
                    bodyFatValue.text = keyCard[3] + " kg"
                    waterValue.text = keyCard[4] + " L"

                    weightBar.value = parseFloat(keyCard[1])
                    muscleBar.value = parseFloat(keyCard[2])
                    bodyFatBar.value = parseFloat(keyCard[3])

                    imcBar.value = parseFloat(keyCard[5])
                    pgcBar.value = parseFloat(keyCard[6])

                    pesoAtualValor.text = keyCard[1] + " kg"

                    segmentarMagra.membSupEsqValor = keyCard2[0] + " kg"
                    segmentarMagra.membSupDirValor = keyCard2[1] + " kg"
                    segmentarMagra.abdValor = keyCard2[2] + " kg"
                    segmentarMagra.membInfEsqValor = keyCard2[3] + " kg"
                    segmentarMagra.membInfDirValor = keyCard2[4] + " kg"

                    segmentarGorda.membSupEsqValor = keyCard3[0] + " kg"
                    segmentarGorda.membSupDirValor = keyCard3[1] + " kg"
                    segmentarGorda.abdValor = keyCard3[2] + " kg"
                    segmentarGorda.membInfEsqValor = keyCard3[3] + " kg"
                    segmentarGorda.membInfDirValor = keyCard3[4] + " kg"
        }

    } // flickable

    ScrollIndicator {
        flickable: scrollMeasure
    } // scroll indicator
}
