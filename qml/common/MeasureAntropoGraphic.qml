import QtQuick 2.11
import VPlayApps 1.0
import QtCharts 2.2
import VPlayPlugins 1.0

Item {
    id: measure
    height: measureHeight
    width: measureWidth

    property real measureHeight: 960
    property real measureWidth: 640
    property int j: 0
    property bool leftSideBool: true
    property bool rightSideBool: true
    property bool centralBool: false
    property real valorMaxE: 0
    property real valorMinE: 0
    property real valorMedE: 0
    property real valorMaxD: 0
    property real valorMinD: 0
    property real valorMedD: 0
    property real valorAtualE: 0
    property real valorAtualD: 0
    property real valorMax: 0
    property real valorMin: 0

    function buscaDadosMedidasCorporais(musculo) {

        console.log("ANTROPO - Quantidade de medidas: " + qtdeMedidaCorp)
        console.log("ANTROPO - user id: " + userID)

        dbFitmass.getValue("medidasCorp", {
                                 orderByChild: "userCorp",
                                 equalTo: userID
                             },
                             function (success, key, value) {
                                 if (success) {

                                     graficoMuscle.visible = true
                                     footer.visible = true
                                     muscleSelect.visible = true
                                     dates.visible = true
                                     noContent.visible = false

                                     //console.debug("HISTORICO 2 - Read value " + value + " for key " + key)
                                     for (var prop in value) {
                                         console.log("ANTROPO - VALUE - " + prop)
                                         keyMeasureCorp = prop
                                            buscaMedidasCorporais(musculo, keyMeasureCorp);
                                     }
                                 } else {
                                     console.log("Usuário não possui medidas corporais")

                                     if(qtdeMedidaCorp === "0") {
                                         graficoMuscle.visible = false
                                         footer.visible = false
                                         muscleSelect.visible = false
                                         dates.visible = false
                                         noContent.visible = true

                                     } else {
                                         console.log("ERRO: Não foi possível carregar as medidas corporais dos usuários")
                                         nativeUtils.displayAlertDialog("Erro", "Não foi possível carregar as suas medidas corporais. Tente novamente mais tarde", "OK")
                                     }
                                 }
                                 indicator.stopAnimating()
                             })
    }

    function buscaMedidasCorporais(musculo, keyMedidaCorp) {
        var mediaValores = 0;
        var valor1 = 0;
        var valor2 = 0;

        dbFitmass.getValue("medidasCorp/" + keyMedidaCorp, {
                                 orderByValue: true
                             }, function (success2, key2, value2) {
                                 if (success2) {

                                     if(centralBool) {
                                         switch (muscleSelectUser.cbTextSelected) {
                                             case "Peitoral": {
                                                 valor1 = parseFloat(value2.peitoral)
                                                 break;
                                             }
                                             case "Cintura": {
                                                 valor1 = parseFloat(value2.cintura)
                                                 break;
                                             }
                                             case "Quadril": {
                                                 valor1 = parseFloat(value2.quadril)
                                                 break;
                                             }
                                             case "Relação Cintura-Quadril": {
                                                 valor1 = (parseFloat(value2.cintura)/parseFloat(value2.quadril))
                                                 break;
                                             }
                                         }

                                         central.append(Date.fromLocaleString(locale, Qt.formatDate(value2.dateCorp, "dd/MM/yyyy"), "dd/MM/yyyy"), valor1)

                                         if(j === 0) {
                                             valorMaxE = valor1
                                             valorMinE = valor1
                                         }

                                         if (valor1 > valorMaxE)
                                             valorMaxE = valor1
                                         if (valor1 < valorMinE)
                                             valorMinE = valor1

                                         valorMedE = valorMedE + valor1

                                         if (valorMinE < 1)
                                            axisY1.min = 0;
                                         else
                                            axisY1.min = valorMinE - 1;

                                         axisY1.max = valorMaxE + 1;

                                         valorAtualE = valor1

                                     } else {
                                         switch (muscleSelectUser.cbTextSelected) {
                                             case "Bíceps": {
                                                 valor1 = parseFloat(value2.bicepsEsq)
                                                 valor2 = parseFloat(value2.bicepsDir)
                                                 break;
                                             }
                                             case "Antebraço": {
                                                 valor1 = parseFloat(value2.antebracoEsq)
                                                 valor2 = parseFloat(value2.antebracoDir)
                                                 break;
                                             }
                                             case "Coxa": {
                                                 valor1 = parseFloat(value2.coxaEsq)
                                                 valor2 = parseFloat(value2.coxaDir)
                                                 break;
                                             }
                                             case "Panturrilha": {
                                                 valor1 = parseFloat(value2.panturrilhaEsq)
                                                 valor2 = parseFloat(value2.panturrilhaDir)
                                                 break;
                                             }
                                         }

                                         leftSide.append(Date.fromLocaleString(locale, Qt.formatDate(value2.dateCorp, "dd/MM/yyyy"), "dd/MM/yyyy"), valor1)
                                         rightSide.append(Date.fromLocaleString(locale, Qt.formatDate(value2.dateCorp, "dd/MM/yyyy"), "dd/MM/yyyy"), valor2)

                                         if(j === 0) {
                                             valorMaxE = valor1
                                             valorMinE = valor1
                                             valorMaxD = valor2
                                             valorMinD = valor2                                             
                                         }

                                         if (valor1 > valorMaxE)
                                             valorMaxE = valor1
                                         if (valor1 < valorMinE)
                                             valorMinE = valor1
                                         if (valor2 > valorMaxD)
                                             valorMaxD = valor2
                                         if (valor2 < valorMinD)
                                             valorMinD = valor2

                                         if (valorMinD < valorMinE)
                                             valorMin = valorMinD
                                         else
                                             valorMin = valorMinE

                                         if (valorMaxD > valorMaxE)
                                             valorMax = valorMaxD
                                         else
                                             valorMax = valorMaxE

                                         valorMedE = valorMedE + valor1
                                         valorMedD = valorMedD + valor2

                                         if (valorMin < 1)
                                            axisY1.min = 0;
                                         else
                                            axisY1.min = valorMin - 1;

                                         axisY1.max = valorMax + 1.0;

                                         valorAtualE = valor1
                                         valorAtualD = valor2
                                     }

                                     axisX1.tickCount = j + 1;

                                         j++;

                                         if(j >= qtdeMedidaCorp){
                                            valorMedD = (valorMedD / (j)).toFixed(2)
                                            valorMedE = (valorMedE / (j)).toFixed(2)

                                            indicator.stopAnimating()
                                            indicator.visible = false
                                     }
                                 } else {
                                     console.debug(
                                                 "HISTORICO3 - Error with message: " + value3)
                                     nativeUtils.displayAlertDialog(
                                                 "Error! 1", value3, "OK")
                                     indicator.stopAnimating()
                                 }
                             })
    }

    AppFlickable {
        id: scrollAntropoPageSecao
        anchors.fill: parent
        contentHeight: content.height

        MouseArea {
            anchors.fill: parent
            onClicked: {
                scrollAntropoPageSecao.forceActiveFocus()
            }
        }

        Rectangle {
            id: spacer
            height: root.dp(5)
            width: parent.width
            anchors.top: parent.top
            color: bgColor
        }

        // Spinner para seleção do grupo muscular
        Item {
            id: muscleSelect
            width: parent.width
            height: root.dp(70)
            anchors.top: spacer.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false

            CustomComboBox {
                id: muscleSelectUser
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                cbTextTitle: ""
                cbTitleColor: white
                cbTextColor: greenLight
                cbColor: grayLight
                cbRadius: root.dp(30)
                cbTextSelected: muscles[0]

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        muscleSelectUser.forceActiveFocus()

                        nativeUtils.displayAlertSheet("Selecione o grupo muscular", muscles, true)
                    }
                }
            }
        }

        Item {
            id: spacer4
            width: dates.width
            height: root.dp(35)
            anchors.top: muscleSelect.bottom
            anchors.left: muscleSelect.left
        }

        // Seletor de datas para produção do gráfico
        Item {
            id: dates
            width: parent.width - root.dp(40)
            height: dateFromSelect.height
            anchors.top: spacer4.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false

            // Seleciona data inicial
            Item {
                width: parent.width / 2
                height: parent.height
                anchors.left: parent.left

                Text {
                    text: "De: "
                    color: white
                    anchors.bottom: dateFromSelect.top
                    anchors.left: dateFromSelect.left
                }

                CustomButtom {
                    id: dateFromSelect
                    btnColor: grayLight
                    btnBorderColor: grayLight
                    btnRadius: root.dp(30)
                    btnText: diaHoje + "/" + mesPassado + "/" + anoHoje
                    btnBorderWidth: root.dp(1)
                    btnTextColor: greenLight
                    btnTextSize: root.sp(14)

                    anchors.horizontalCenter: parent.horizontalCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            dateFrom = true;
                            nativeUtils.displayDatePicker(Qt.formatDate(Date.fromLocaleString(Qt.locale(), dateFromSelect.btnText, "dd/MM/yyyy"), "yyyy-MM-dd"), "2000-01-01", dateMax1)
                        }
                    }
                }
            }

            // Seleciona data final
            Item {
                width: parent.width / 2
                height: parent.height
                anchors.right: parent.right

                Text {
                    text: "Até: "
                    color: white
                    anchors.bottom: dateToSelect.top
                    anchors.left: dateToSelect.left
                }

                CustomButtom {
                    id: dateToSelect
                    btnColor: grayLight
                    btnBorderColor: grayLight
                    btnRadius: root.dp(30)
                    btnText: Qt.formatDate(new Date(), "dd/MM/yyyy")
                    btnBorderWidth: root.dp(1)
                    btnTextColor: greenLight
                    btnTextSize: root.sp(14)

                    anchors.horizontalCenter: parent.horizontalCenter

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            dateTo = true;
                            nativeUtils.displayDatePicker(Qt.formatDate(Date.fromLocaleString(Qt.locale(), dateToSelect.btnText, "dd/MM/yyyy"), "yyyy-MM-dd"), "2000-01-01", dateMax2)
                        }
                    }
                }
            }
        }

        Rectangle {
            id: spacer3
            height: root.dp(3)
            width: parent.width
            anchors.top: dates.bottom
            anchors.left: parent.left
            color: "transparent"
        }

        // Gráficos de evolução
        Item {
            id: graficoMuscle
            width: parent.width
            height: grafico.height
            anchors.top: spacer3.bottom
            visible: false

            Item {
                id: grafico
                width: parent.width - root.dp(10)
                height: width * 2 / 3
                anchors.horizontalCenter: parent.horizontalCenter

                ChartView {
                    id: muscleChart
                    title: ""
                    width: parent.width
                    height: parent.height
                    antialiasing: true
                    backgroundColor: bgColor
                    legend.font.pixelSize: root.sp(14)
                    legend.labelColor: white                    

                    ValueAxis {
                        id: axisY1
                        min: 25
                        max: 31
                        labelsVisible: true
                        gridVisible: false
                        lineVisible: false
                        tickCount: 3
                        labelsColor: grayLight
                        labelsFont.pixelSize: root.sp(12)
                        labelFormat: "%0.1f"
                    }

                    DateTimeAxis {
                        id: axisX1
                        format: "dd/MM"
                        labelsVisible: true
                        gridVisible: false
                        lineVisible: false
                        tickCount: 3
                        labelsColor: grayLight
                        labelsFont.pixelSize: root.sp(12)
                        min: Date.fromLocaleString(Qt.locale(), dateFromSelect.btnText, "dd/MM/yyyy")
                        max: Date.fromLocaleString(Qt.locale(), dateToSelect.btnText, "dd/MM/yyyy")
                    }

                    LineSeries {
                        id: leftSide
                        width: root.dp(3)
                        color: greenDark
                        name: "esquerdo"
                        axisX: axisX1
                        axisY: axisY1
                        visible: leftSideBool ? true : false
                    }

                    LineSeries {
                        id: rightSide
                        width: root.dp(3)
                        color: contrastColor3
                        name: "direito"
                        axisX: axisX1
                        axisY: axisY1
                        visible: rightSideBool ? true : false
                    }

                    LineSeries {
                        id: central
                        width: root.dp(3)
                        color: contrastColor3
                        name: muscleSelectUser.cbTextSelected
                        axisX: axisX1
                        axisY: axisY1
                        visible: centralBool ? true : false
                    }
                }
            }
        }

        // Descrição dos dados
        Item {
        id: footer
        width: muscleSelect.width
        height: txtItem.height + valueNowItem.height + valueMaxItem.height + valueMinItem.height + valueMedItem.height
        visible: false

        anchors.top: graficoMuscle.bottom
        anchors.left: muscleSelect.left

            // Componete para quando o grupo muscular exige duas colunas de dados
            Item {
                id: direitoesquerdo
                anchors.fill: parent
                visible: rightSideBool ? true : false

                Item {
                    id: txtItem
                    height: root.dp(20)
                    width: parent.width
                    anchors.top: parent.top
                    anchors.left: parent.left

                    Text {
                        id: txt1
                        width: parent.width / 2
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter

                        text: "esquerdo"
                        color: greenDark
                        font.bold: true
                        topPadding: root.dp(2)
                        font.pixelSize: root.sp(16)
                    }

                    Text {
                        id: txt2
                        width: parent.width / 2
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "direito"
                        color: contrastColor3
                        font.bold: true
                        font.pixelSize: root.sp(16)
                    }
                }

                // Valor atual da medida
                Item {
                    id: valueNowItem
                    height: root.dp(20)
                    width: parent.width
                    anchors.top: txtItem.bottom
                    anchors.left: parent.left

                    Text {
                        id: valueNowLeft
                        width: parent.width / 2
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter

                        text: "Atual: " + valorAtualE.toFixed(2) + " cm"
                        color: greenDark
                        font.pixelSize: root.sp(14)
                    }

                    Text {
                        id: valueNowRight
                        width: parent.width / 2
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "Atual: " + valorAtualD.toFixed(2) + " cm"
                        color: contrastColor3
                        font.pixelSize: root.sp(14)
                    }
                }

                // Valor máximo das medidas realizadas para o grupo muscular em questão
                Item {
                    id: valueMaxItem
                    height: root.dp(20)
                    width: parent.width
                    anchors.top: valueNowItem.bottom
                    anchors.left: parent.left

                    Text {
                        id: valueMaxLeft
                        width: parent.width / 2
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter

                        text: "máx: " + valorMaxE.toFixed(2) + " cm"
                        font.pixelSize: root.sp(12)
                        color: white
                    }

                    Text {
                        id: valueMaxRight
                        width: parent.width / 2
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "máx: " + valorMaxD.toFixed(2) + " cm"
                        font.pixelSize: root.sp(12)
                        color: white
                    }
                }

                // Valor mínimo das medidas realizadas para o grupo muscular em questão
                Item {
                    id: valueMinItem
                    height: root.dp(20)
                    width: parent.width
                    anchors.top: valueMaxItem.bottom
                    anchors.left: parent.left

                    Text {
                        id: valueMinLeft
                        width: parent.width / 2
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter

                        text: "min: " + valorMinE.toFixed(2) + " cm"
                        font.pixelSize: root.sp(12)
                        color: white
                    }

                    Text {
                        id: valueMinRight
                        width: parent.width / 2
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "min: " + valorMinD.toFixed(2) + " cm"
                        font.pixelSize: root.sp(12)
                        color: white
                    }
                }

                // Valor médio das medidas realizadas para o grupo muscular em questão
                Item {
                    id: valueMedItem
                    height: root.dp(20)
                    width: parent.width
                    anchors.top: valueMinItem.bottom
                    anchors.left: parent.left

                    Text {
                        id: valueMedLeft
                        width: parent.width / 2
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter

                        text: "méd: " + valorMedE.toFixed(2) + " cm"
                        font.pixelSize: root.sp(12)
                        color: white
                    }

                    Text {
                        id: valueMedRight
                        width: parent.width / 2
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "méd: " + valorMedD.toFixed(2) + " cm"
                        font.pixelSize: root.sp(12)
                        color: white
                    }
            }
            }

            // Componete para quando o grupo muscular exige uma coluna de dados
            Item {
                id: centro
                anchors.fill: parent
                visible: centralBool ? true : false

                Item {
                    id: txtCentroItem
                    height: root.dp(20)
                    width: parent.width
                    anchors.top: parent.top
                    anchors.left: parent.left

                    Text {
                        id: txtCentro1
                        width: parent.width
                        anchors.left: parent.left
                        horizontalAlignment: Text.AlignHCenter

                        text: muscleSelectUser.cbTextSelected
                        color: contrastColor3
                        font.bold: true
                        topPadding: root.dp(2)
                        font.pixelSize: root.sp(16)
                    }
                }

                // Valor atual da medida
                Item {
                    id: valueNowCentroItem
                    height: root.dp(20)
                    width: parent.width
                    anchors.top: txtCentroItem.bottom
                    anchors.left: parent.left

                    Text {
                        id: valueNow
                        width: parent.width
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "Atual: " + valorAtualE.toFixed(2) + " cm"
                        color: contrastColor3
                        font.pixelSize: root.sp(14)
                    }
                }

                // Valor máximo das medidas realizadas para o grupo muscular em questão
                Item {
                    id: valueMaxCentroItem
                    height: root.dp(20)
                    width: parent.width
                    anchors.top: valueNowCentroItem.bottom
                    anchors.left: parent.left

                    Text {
                        id: valueMax
                        width: parent.width
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "máx: " + valorMaxE.toFixed(2) + " cm"
                        font.pixelSize: root.sp(12)
                        color: white
                    }
                }

                // Valor mínimo das medidas realizadas para o grupo muscular em questão
                Item {
                    id: valueMinCentroItem
                    height: root.dp(20)
                    width: parent.width
                    anchors.top: valueMaxCentroItem.bottom
                    anchors.left: parent.left

                    Text {
                        id: valueMin
                        width: parent.width
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "min: " + valorMinE.toFixed(2) + " cm"
                        font.pixelSize: root.sp(12)
                        color: white
                    }
                }

                // Valor médio das medidas realizadas para o grupo muscular em questão
                Item {
                    id: valueMedCentroItem
                    height: root.dp(20)
                    width: parent.width
                    anchors.top: valueMinCentroItem.bottom
                    anchors.left: parent.left

                    Text {
                        id: valueMed
                        width: parent.width
                        anchors.right: parent.right
                        horizontalAlignment: Text.AlignHCenter

                        text: "méd: " + valorMedE.toFixed(2) + " cm"
                        font.pixelSize: root.sp(12)
                        color: white
                    }
            }
            }
        }
    }

    Item {
        id: noContent
        anchors.fill: parent
        visible: false

        Text {
            id: noMeasure
            text: "Você ainda não possui medidas corporais."
            anchors.centerIn: parent
            color: greenDark
            font.pixelSize: root.dp(14)
        }
    }

    Connections {
        target: nativeUtils

        onDatePickerFinished: {
            var pickedDate
            var dateFormated
            if(accepted){

                var hour = ""
                var dateStr = ""
                var timeShift = ""

                dateStr = date.toLocaleTimeString(Qt.locale("pt_BR"))
                hour = parseInt(dateStr.split(":")[0])
                timeShift = Qt.formatDateTime(date, "t")

                if (hour === 00) {
                    dateFormated = Qt.formatDate(date, "dd/MM/yyyy")
                    pickedDate = date
                } else {
                    Date.prototype.addHours = function (h) {
                        this.setTime(this.getTime() + (h * 60 * 60 * 1000))
                        return this
                    }

                    dateFormated = Qt.formatDate(date.addHours(24 - hour), "dd/MM/yyyy")
                    pickedDate = date.addHours(24 - hour)
                }

                if(dateTo){
                    dateTo = false;
                    dateToSelect.btnText = dateFormated;
                    axisX1.max = Date.fromLocaleString(Qt.locale(), dateFormated, "dd/MM/yyyy")
                }

                if(dateFrom){
                    dateFrom = false;
                    dateFromSelect.btnText = dateFormated;
                    axisX1.min = Date.fromLocaleString(Qt.locale(), dateFormated, "dd/MM/yyyy")
                }
            }
        }

        onAlertSheetFinished: {
            if(index>=0) {
                muscleSelectUser.cbTextSelected = muscles[index]

                if(index === 0 || index === 1 || index === 5 || index === 6){
                    leftSideBool = true
                    rightSideBool = true
                    centralBool = false
                    leftSide.removePoints(0, j)
                    rightSide.removePoints(0, j)
                } else {
                    leftSideBool = false
                    rightSideBool = false
                    centralBool = true
                    central.removePoints(0, j)
                }

                j = 0
                valorMedD = 0
                valorMedE = 0
                valorMin = 0
                valorMax = 0
                valorMinD = 0
                valorMinE = 0
                valorMaxD = 0
                valorMaxE = 0
                valorAtualD = 0
                valorAtualE = 0

                buscaDadosMedidasCorporais(muscleSelectUser.cbTextSelected)
            }
        }
    }

    ScrollIndicator {
        flickable: scrollAntropoPageSecao
    } // scroll indicator

    Component.onCompleted: {
        indicator.visible = true
        indicator.startAnimating()
        // leitura das medidas corporais no banco de dados para tal usuário para o grupo muscular biceps
        buscaDadosMedidasCorporais()
    }

    FirebaseDatabase {
        id: dbFitmass

        config: FirebaseConfig {
             //get these values from the firebase console
             projectId: "fitmass-2018"
             databaseUrl: "https://fitmassapp.firebaseio.com/"

             //platform dependent - get these values from the google-services.json / GoogleService-info.plist
             apiKey:        Qt.platform.os === "android" ? "AIzaSyBh6Kb12xUnOsQDTP2XEbSKtuGsBfmCyic" : "AIzaSyBh6Kb12xUnOsQDTP2XEbSKtuGsBfmCyic"
             applicationId: Qt.platform.os === "android" ? "1:519505351771:android:28365556727f1ea3" : "1:519505351771:ios:28365556727f1ea3"
           }
    }
}
