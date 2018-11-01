import VPlayApps 1.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2
import QtQuick.Controls.Material 2.0

import "../common"
import "../pages"

Page {
    id: measurePage
    title: "Medida"
    height: 960
    width: 640

    property var weightValor
    property var muscleValor
    property var bodyFatValor
    property var waterValor
    property alias dateValor: measurePage.title
    property var wantedWeightValor

    property int titleFontSize: 6
    property var titleTopPadding: dp(15)
    property var titleBottomPadding: dp(15)
    property var titleHorizontalAlignment: Text.AlignHCenter
    property var textRightPadding: dp(15)
    property var textLeftPadding: dp(15)
    property color titleColor: verdeMassa
    property color textColor: "#4b4b4b"

    rightBarItem:  NavigationBarRow {
      id: rightNavBarRowMeasure

      IconButtonBarItem {
          title: "Compartilhar"
          icon: IconType.sharealt

          onClicked: {
            measureItemSource.grabToImage(function(result){
                result.saveToFile("medida.png")
                nativeUtils.share("Link da imagem: " + result.url, "")
            })
        }
      }

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
                      console.log("DELETAR aceito - key: " + keyCard)
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
                    font.pointSize: sp(titleFontSize)
                    horizontalAlignment: titleHorizontalAlignment
                    topPadding: titleTopPadding
                    bottomPadding: titleBottomPadding
                }

                Item {
                    id: analiseCompCorporal
                    width: parent.width
                    height: peso.height
                    anchors.top: titleRowAnaliseCompCorporal.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    Item {
                        id: peso
                        height: iconPeso.height + txtPeso1.height + weightValue.height + dp(20)
                        width: parent.width / 4
                        anchors.left: parent.left

                        Text {
                            id: txtPeso1
                            width: parent.width / 4
                            text: "\npeso"
                            horizontalAlignment: Text.AlignHCenter
                            color: "black"
                            topPadding: dp(10)
                            anchors.horizontalCenter: iconPeso.horizontalCenter
                            anchors.bottom: iconPeso.top
                            bottomPadding: dp(5)
                        }
                        Image {
                            id: iconPeso
                            source: "../../assets/icon_weight.png"
                            height: dp(50)
                            width: height
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            id: weightValue
                            width: parent.width / 4
                            text: ""
                            color: "black"
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: iconPeso.horizontalCenter
                            anchors.top: iconPeso.bottom
                            topPadding: dp(10)
                        }
                    }

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
                            color: "black"
                            topPadding: dp(10)
                            anchors.horizontalCenter: iconMassaMagra.horizontalCenter
                            anchors.bottom: iconMassaMagra.top
                            bottomPadding: dp(5)
                        }
                        Image {
                            id: iconMassaMagra
                            source: "../../assets/icon_muscle.png"
                            height: dp(50)
                            width: height
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            id: muscleValue
                            width: parent.width / 4
                            text: ""
                            color: "black"
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: iconMassaMagra.horizontalCenter
                            anchors.top: iconMassaMagra.bottom
                            topPadding: dp(10)
                        }
                    }

                    Item {
                        id: massaGorda
                        height: peso.height
                        width: parent.width / 4
                        anchors.left: massaMagra.right

                        Text {
                            text: "massa de\ngordura"
                            width: parent.width / 4
                            horizontalAlignment: Text.AlignHCenter
                            color: "black"
                            topPadding: dp(10)
                            anchors.horizontalCenter: iconMassaGorda.horizontalCenter
                            anchors.bottom: iconMassaGorda.top
                            bottomPadding: dp(5)
                        }
                        Image {
                            id: iconMassaGorda
                            source: "../../assets/icon_body_fat.png"
                            height: dp(50)
                            width: height
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            id: bodyFatValue
                            width: parent.width / 4
                            text: ""
                            color: "black"
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: iconMassaGorda.horizontalCenter
                            anchors.top: iconMassaGorda.bottom
                            topPadding: dp(10)
                        }
                    }

                    Item {
                        id: agua
                        height: peso.height
                        width: parent.width / 4
                        anchors.left: massaGorda.right

                        Text {
                            text: "água no\ncorpo"
                            width: parent.width / 4
                            horizontalAlignment: Text.AlignHCenter
                            color: "black"
                            topPadding: dp(10)
                            anchors.horizontalCenter: iconAgua.horizontalCenter
                            anchors.bottom: iconAgua.top
                            bottomPadding: dp(5)
                        }
                        Image {
                            id: iconAgua
                            source: "../../assets/icon_water.png"
                            height: dp(50)
                            width: height
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            id: waterValue
                            width: parent.width / 4
                            text: ""
                            color: "black"
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: iconAgua.horizontalCenter
                            anchors.top: iconAgua.bottom
                            topPadding: dp(10)
                        }
                    }
                }

                Text {
                    id: titleRowAnaliseMusculoGordura
                    width: parent.width
                    text: "Análise Músculo - Gordura"
                    color: titleColor
                    font.bold: true
                    font.pointSize: sp(titleFontSize)
                    horizontalAlignment: titleHorizontalAlignment
                    topPadding: titleTopPadding
                    bottomPadding: titleBottomPadding
                    anchors.top: analiseCompCorporal.bottom
                }

                Item {
                    id: analiseMusculoGordura_peso
                    width: parent.width
                    height: weightBar.height
                    anchors.top: titleRowAnaliseMusculoGordura.bottom

                    BarraProgressoSimples {
                        id: weightBar
                        height: dp(60)
                        title: "Peso"
                        subtitle: ""
                        titleValue: value + " kg"
                        anchors.top: parent.top
                        min: 0
                        max: 180
                        value: 0
                    }
                }

                Item {
                    id: analiseMusculoGordura_Magra
                    width: parent.width
                    height: weightBar.height
                    anchors.top: analiseMusculoGordura_peso.bottom

                    BarraProgressoSimples {
                        id: muscleBar
                        height: dp(60)
                        title: "Massa Magra"
                        subtitle: ""
                        titleValue: value + " kg"
                        anchors.top: weightBar.bottom
                        min: 0
                        max: 80
                        value: 0
                    }
                }

                Item {
                    id: analiseMusculoGordura_Gorda
                    width: parent.width
                    height: muscleBar.height
                    anchors.top: analiseMusculoGordura_Magra.bottom

                    BarraProgressoSimples {
                        id: bodyFatBar
                        height: dp(60)
                        title: "Massa de Gordura"
                        subtitle: ""
                        titleValue: value + " kg"
                        anchors.top: muscleBar.bottom
                        min: 0
                        max: 80
                        value: 0
                    }
                }

                Text {
                    id: titleRowAnaliseObesidade
                    width: parent.width
                    text: "Análise de Obesidade"
                    color: titleColor
                    font.bold: true
                    font.pointSize: sp(titleFontSize)
                    horizontalAlignment: titleHorizontalAlignment
                    topPadding: titleTopPadding
                    bottomPadding: titleBottomPadding
                    anchors.top: analiseMusculoGordura_Gorda.bottom
                }

                Item {
                    id: analiseObesidade1
                    width: parent.width
                    height: imcBar.height
                    anchors.top: titleRowAnaliseObesidade.bottom

                    BarraProgresso {
                        id: imcBar
                        height: dp(80)
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
                }

                Item {
                    id: analiseObesidade2
                    width: parent.width
                    height: pgcBar.height
                    anchors.top: analiseObesidade1.bottom

                    BarraProgresso {
                        id: pgcBar
                        height: dp(80)
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
                }

                Text {
                    id: titleRowAnaliseSegmentarMagra
                    width: parent.width
                    text: "Análise Segmentar de Massa Magra"
                    color: titleColor
                    font.bold: true
                    font.pointSize: sp(titleFontSize)
                    horizontalAlignment: titleHorizontalAlignment
                    topPadding: titleTopPadding
                    bottomPadding: titleBottomPadding
                    anchors.top: analiseObesidade2.bottom
                }

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
                }

                Text {
                    id: titleRowAnaliseSegmentarGorda
                    width: parent.width
                    text: "Análise Segmentar de Massa de Gordura"
                    color: titleColor
                    font.bold: true
                    font.pointSize: sp(titleFontSize)
                    horizontalAlignment: titleHorizontalAlignment
                    topPadding: titleTopPadding
                    bottomPadding: titleBottomPadding
                    anchors.top: analiseSegmentarMagra.bottom
                }

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
                }

                Text {
                    id: titleRowControlePeso
                    width: parent.width
                    text: "Controle de Peso"
                    color: titleColor
                    font.bold: true
                    font.pointSize: sp(titleFontSize)
                    horizontalAlignment: titleHorizontalAlignment
                    topPadding: titleTopPadding
                    bottomPadding: titleBottomPadding
                    anchors.top: analiseSegmentarGorda.bottom
                }

                Item {
                    id: controlePeso
                    width: parent.width
                    height: balanca.height + space2.height
                    anchors.top: titleRowControlePeso.bottom

                    Rectangle {
                        id: space3
                        height: dp(15)
                        width: parent.width
                        color: "transparent"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                    }

                        Image {
                            id: balanca
                            height: dp(140)
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
                                color: "#b4b4b4"
                                font.bold: true
                                anchors.horizontalCenter: parent.horizontalCenter
                                topPadding: (weightValor >= wantedWeightValor) ? dp(35) : dp(10)
                            }

                            Text {
                                id: pesoAtualValor
                                text: ""
                                color: amareloMassa
                                font.bold: true
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: pesoAtual.bottom
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
                                color: "#b4b4b4"
                                font.bold: true
                                anchors.horizontalCenter: parent.horizontalCenter
                                topPadding: (weightValor >= wantedWeightValor) ? dp(10) : dp(35)
                            }

                            Text {
                                id: pesoDesejadoValor
                                text: wantedWeightValor + " kg"
                                color: amareloMassa
                                font.bold: true
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: pesoDesejado.bottom
                            }
                        }
                } // row Controle de Peso

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
                } // row Info icon
            } // item
        } // column - medidas

        Component.onCompleted: {
            console.log(keyCard)

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
