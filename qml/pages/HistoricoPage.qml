import VPlayApps 1.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2
import Qt.labs.settings 1.0 as QtLabs
import QtQuick.Controls.Material 2.0
import QtCharts 2.2
import VPlayPlugins 1.0
import QtQuick.Window 2.2

import "../common"
import "../pages"

Page {
    title: "Fitmass"
    id: historicoPage
    height: screenSizeY
    width: screenSizeX

    property bool initial: true
    property bool dateFilter: false

    property var keyCardFilter
    property var weightDB: ""
    property var bodyFatDB: ""
    property var leanMassDB: ""
    property var dateDB: ""
    property var measureIdDB: ""

    property var s2: ""
    property var k: 0

    property var line
    property var line2
    property var line3
    property var line4

    property var dataMin: ""

    property int indMenor
    property int indMaior

    property var maiorPeso
    property var menorPeso
    property var maiorMagra
    property var menorMagra
    property var maiorGorda
    property var menorGorda

    function dataMesPassado(){
        var diaHoje =  Qt.formatDate(new Date(), "dd")
        var mesPassado
        var anoHoje = Qt.formatDate(new Date(), "yyyy")

        if (parseInt(Qt.formatDate(new Date(), "MM")) == 01) {
            mesPassado = 12
            anoHoje = anoHoje - 1
        } else {
            mesPassado = parseInt(Qt.formatDate(new Date(), "MM") - 1)
        }

        dataMin = diaHoje + "/" + mesPassado + "/" + anoHoje

        dataMin = Date.fromLocaleString(locale, dataMin, "dd/MM/yyyy")

        return dataMin
    }

    // modelo de dados para ListView
    function cardModel(parent) {

        var s = 'import QtQuick 2.0; ListModel {\n'
        s += s2
        s += "}\n"
        // console.log("DADOS: " + s)

        return Qt.createQmlObject(s, parent, "mainModel")
    }

    // calcula a idade do usuário
    function calculateAge(birthday) {
        var yearUser = Qt.formatDateTime(birthday, "yyyy")
        var monthUser = Qt.formatDateTime(birthday, "MM")
        var dayUser = Qt.formatDateTime(birthday, "dd")

        var dateNow = new Date()
        var year = Qt.formatDateTime(dateNow, "yyyy")
        var month = Qt.formatDateTime(dateNow, "MM")
        var day = Qt.formatDateTime(dateNow, "dd")

        var age = parseInt(year) - parseInt(yearUser)
        if (month < monthUser) {
            age--
        } else if (month == monthUser) {
            if (dayUser > day) {
                age--
            }
        }
        return age
    }

    // Busca os dados do usuário no banco de dados
    function buscaDadosUser() {

        dbFitmass.getValue(keyUser, {
                                 orderByValue: true
                             }, function (success3, key3, value3) {
                                 if (success3) {

                                     if(initial){
                                         qtdeMedida = value3.totalMeasure
                                         qtdeMedidaCorp = value3.totalMeasureCorp
                                        graficosConfig();
                                     }

                                     userGender = value3.gender
                                     var age = value3.birthday

                                     userAge = calculateAge(
                                                 Date.fromLocaleString(
                                                     Qt.locale(), age,
                                                     "dd/MM/yyyy"))

                                     pesoDesejado = value3.desiredWeight

                                     if(qtdeMedida == 0){
                                         novato = true;
                                     }else{
                                         novato = false;
                                         filterIcon.visible = true;
                                     }
                                 } else {
                                     console.debug(
                                                 "ERRO: Não foi possível encontrar dados do usuário " + userID)
                                     nativeUtils.displayAlertDialog("Erro",
                                                 "ERRO: Não foi possível carregar os dados do usuário. Tente novamente mais tarde.", "OK")
                                     firebaseAuth.logoutUser()
                                     stack.pop()
                                     console.log("ERRO: Logout forçado")
                                     indicator.stopAnimating()
                                 }
                             })
    }

    // Busca as medidas deste usuário no banco de dados
    function buscaMedidas() {

        // indicadores para limitar em 10 medidas para os gráficos
        indMaior = qtdeMedida

        if(indMaior > 10)
            indMenor = indMaior - 10
        else
            indMenor = 0

        // busca de medidas para cada usuário
        dbFitmass.getValue("medidas", {
                                 orderByChild: "userId",
                                 equalTo: userID
                             },
                             function (success, key, value) {
                                 if (success) {

                                     graphics.visible = false
                                     cardsHistorico.visible = true
                                     msgMedidas.visible = false
                                     novato = false

                                     console.debug("O usuário " + userID + " possui medidas Fitmass.")
                                     for (var prop in value) {
                                         keyMeasure = prop
                                            buscaDadosMedida(keyMeasure);
                                     }
                                 } else {
                                     if(qtdeMedida === 0) {
                                         novato = true
                                         graphics.visible = false
                                         cardsHistorico.visible = false
                                         msgMedidas.visible = true
                                         indicator.stopAnimating()
                                         indicator.visible = false

                                         cosole.log("O usuário " + userID + " não possui medidas Fitmass ainda")
                                     } else {
                                         cosole.log("ERRO: Não foi possível ler as medidas Fitmass do usuário " + userID)
                                     }
                                     indicator.stopAnimating()
                                     indicator.visible = false
                                 }
                             })
    }

    function buscaDadosMedida(keyMedida) {

        // busca de medidas de um usuário específico
        dbFitmass.getValue("medidas/" + keyMedida, {
                                 orderByValue: true
                             }, function (success2, key2, value2) {
                                 if (success2) {

                                     measureIdDB = value2.measureID

                                     if(k>=indMenor){

                                         if(initial) {

                                             // primeira vez que gera o gráfico
                                             line.append(Date.fromLocaleString(locale, Qt.formatDate(value2.dateMedida, "dd/MM"), "dd/MM"), value2.weight)
                                             line2.append(Date.fromLocaleString(locale, Qt.formatDate(value2.dateMedida, "dd/MM"), "dd/MM"), pesoDesejado)
                                             line3.append(Date.fromLocaleString(locale, Qt.formatDate(value2.dateMedida, "dd/MM"), "dd/MM"), value2.leanMass)
                                             line4.append(Date.fromLocaleString(locale, Qt.formatDate(value2.dateMedida, "dd/MM"), "dd/MM"), value2.bodyFat)

                                             // definição dos eixos
                                             if(k === 0) {
                                                 axisX1.min = Date.fromLocaleString(locale, Qt.formatDate(value2.dateMedida, "dd/MM"), "dd/MM")
                                                 axisX2.min = Date.fromLocaleString(locale, Qt.formatDate(value2.dateMedida, "dd/MM"), "dd/MM")
                                                 axisX3.min = Date.fromLocaleString(locale, Qt.formatDate(value2.dateMedida, "dd/MM"), "dd/MM")

                                                 menorPeso = parseFloat(pesoDesejado) - 10;
                                                 menorMagra = parseFloat(value2.leanMass) - 5
                                                 menorGorda = parseFloat(value2.bodyFat) - 5;
                                                 maiorPeso = parseFloat(pesoDesejado) + 10;
                                                 maiorMagra = parseFloat(value2.leanMass) + 5;
                                                 maiorGorda = parseFloat(value2.bodyFat) + 5;
                                             }

                                             axisX1.max = Date.fromLocaleString(locale, Qt.formatDate(value2.dateMedida, "dd/MM"), "dd/MM")
                                             axisX2.max = Date.fromLocaleString(locale, Qt.formatDate(value2.dateMedida, "dd/MM"), "dd/MM");
                                             axisX3.max = Date.fromLocaleString(locale, Qt.formatDate(value2.dateMedida, "dd/MM"), "dd/MM");

                                             // atualização dos máximos e mínimos dos eixos
                                             if (value2.weight < menorPeso)
                                                 menorPeso = parseFloat(value2.weight) - 2;

                                             if (value2.leanMass < menorMagra)
                                                 menorMagra = parseFloat(value2.leanMass) - 2;

                                             if (value2.bodyFat < (parseFloat(value2.bodyFat) - 2))
                                                 menorGorda = parseFloat(value2.bodyFat) - 2;

                                             if (value2.weight > maiorPeso)
                                                 maiorPeso = parseFloat(value2.weight) + 2;

                                             if (value2.leanMass > maiorMagra)
                                                 maiorMagra = parseFloat(value2.leanMass) + 2;

                                             if (value2.bodyFat > maiorGorda)
                                                 maiorGorda = parseFloat(value2.bodyFat) + 2;

                                             axisY1.min = menorPeso
                                             axisY2.min = menorMagra
                                             axisY3.min = menorGorda

                                             axisY1.max = maiorPeso
                                             axisY2.max = maiorMagra
                                             axisY3.max = maiorGorda

                                             axisX1.tickCount = k + 1 - indMenor;
                                             axisX2.tickCount = k + 1 - indMenor;
                                             axisX3.tickCount = k + 1 - indMenor;

                                             if(k >= (qtdeMedida-1)){
                                                initial = false;
                                                indicator.stopAnimating()
                                                indicator.visible = false
                                             }
                                         } else {
                                             // apenas a apartir da segunda vez que gerar o gráfico
                                             indicator.stopAnimating()
                                             indicator.visible = false
                                         }
                                     }
                                     k++;
                                     s2 += "ListElement {measureIdDB: \"" + value2.measureID + "\"; weight: \"" + value2.weight + " kg" + "\"; leanMass: \"" + value2.leanMass + " kg" + "\"; bodyFat: \"" + value2.bodyFat + " kg" + "\"; date: \"" + value2.dateMedida + "\" }\n"
                                 } else {
                                     console.debug("Não foi possível ler a medida " + keyMedida + " do usuário " + userID)
                                     nativeUtils.displayAlertDialog("Não foi possível carregar a medida. Tente novamente mais tarde.", "OK")
                                     indicator.stopAnimating()
                                     indicator.visible = false
                                 }
                             })

    }

    // Configurações dos gráficos
    function graficosConfig() {

        line = weightChart.createSeries(ChartView.SeriesTypeLine,
                                        "Pesso medido", axisX1, axisY1)

        line2 = weightChart.createSeries(ChartView.SeriesTypeLine,
                                         "Peso desejado", axisX1, axisY1)

        line3 = leanMassChart.createSeries(ChartView.SeriesTypeSpline,
                                           "", axisX2, axisY2)

        line4 = bodyFatChart.createSeries(ChartView.SeriesTypeSpline,
                                          "Histórico de Massa de Gordura", axisX3, axisY3)

        line.pointsVisible = true
        line.width = root.dp(3)
        line.color = greenDark

        line2.width = root.dp(3)
        line2.color = contrastColor3

        line3.pointsVisible = true
        line3.width = root.dp(3)
        line3.color = greenDark

        line4.pointsVisible = true
        line4.width = root.dp(3)
        line4.color = greenDark

        axisY1.tickCount = 4
        axisY2.tickCount = 4
        axisY3.tickCount = 4
    }

    // Ícones na barra de navegação superior
    rightBarItem: NavigationBarRow {
        id: rightNavBarRowHostorico

        // Ícone de filtro
        IconButtonBarItem {
            title: "Filtro por data"
            icon: IconType.filter
            id: filterIcon
            visible: false

            onClicked: {
                dateFilter = true
                // Apresenta o datePicker padrão do OS
                nativeUtils.displayDatePicker()
            }

            Connections {
                target: nativeUtils

                onDatePickerFinished: {
                    if(dateFilter){
                        var pickedDate

                        if (accepted) {

                            indicator.visible = true
                            indicator.startAnimating()

                            closeIcon.visible = true
                            filterIcon.visible = false
                            msgFilter.visible = false

                            var hour = ""
                            var dateStr = ""
                            var timeShift = ""

                            dateStr = date.toLocaleTimeString(Qt.locale("pt_BR"))
                            hour = parseInt(dateStr.split(":")[0])
                            timeShift = Qt.formatDateTime(date, "t")

                            if (hour === 00) {
                                pickedDate = Qt.formatDate(date,
                                                           "yyyyMMdd")
                            } else {
                                Date.prototype.addHours = function (h) {
                                    this.setTime(this.getTime(
                                                     ) + (h * 60 * 60 * 1000))
                                    return this
                                }
                                pickedDate = Qt.formatDate(date.addHours(
                                                               24 - hour),
                                                           "yyyyMMdd")
                            }

                            s2 = ""

                            dbFitmass.getValue("medidas", {
                                                         orderByChild: "user_date",
                                                         equalTo: userID + "_" + pickedDate
                                                     },
                                                     function (success5, key5, value5) {
                                                         if (success5) {
                                                             for (var prop5 in value5) {
                                                                 keyCardFilter = prop5

                                                                 dbFitmass.getValue(
                                                                             "medidas/" + keyCardFilter, {
                                                                                 orderByValue: true
                                                                             },
                                                                             function (success4, key4, value4) {
                                                                                 if (success4) {
                                                                                         s2 += "ListElement {measureIdDB: \"" + value4.measureID + "\"; weight: \"" + value4.weight +
                                                                                         "\"; leanMass: \"" + value4.leanMass + "\"; bodyFat: \"" + value4.bodyFat + "\"; date: \"" +
                                                                                         value4.dateMedida + "\" }\n"

                                                                                     indicator.stopAnimating()
                                                                                     indicator.visible = false
                                                                                 } else {
                                                                                     console.debug("Não foi possível ler a medida " + keyMedida + " do usuário " + userID)
                                                                                     nativeUtils.displayAlertDialog("Não foi possível carregar a medida. Tente novamente mais tarde.", "OK")
                                                                                 }
                                                                             })
                                                             }
                                                         } else {
                                                             msgFilter.visible = true
                                                             graphics.visible = false
                                                             indicator.stopAnimating()
                                                             indicator.visible = false
                                                             console.log("Filtro por data - Não possui medida Fitmass nessa data")
                                                         }
                                                     })
                        }
                        dateFilter = false;
                    }
                }
            }
        }

        // Ícone para voltar da seleção de cards filtrados para todos os cards
        IconButtonBarItem {
            id: closeIcon
            title: "Voltar"
            icon: IconType.close
            visible: false

            onClicked: {
                closeIcon.visible = false
                filterIcon.visible = true
                msgFilter.visible = false
                dateFilter = false
                s2 = ""
                indicator.visible = true
                indicator.startAnimating()

                console.log("Limpar filtro por data - Medidas Fitmass")

                buscaMedidas()
            }
        }

        // Ícone para realizar logout
        IconButtonBarItem {
            id: logoutIcon
            title: "Sair"
            icon: IconType.signout

            onClicked: {
                Theme.colors.statusBarStyle = Theme.colors.statusBarStyleHidden
                firebaseAuth.logoutUser()
                stack.pop()
                indicator.stopAnimating()
                indicator.visible = false
                console.log("Usuário realizou logout")
            }
        }
    }

    Item {
        id: content
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height//listCards.height + graphics.height + tabIcons.height

        // Menu de Tab para alternar entre o histórico e os gráficos
        Item {
            id: tabIcons
            width: parent.width
            height: root.dp(40)
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            Item {
                id: historico
                width: parent.width / 2
                height: parent.height
                anchors.left: parent.left
                anchors.top: parent.top

                Rectangle {
                    id: historicoRec
                    anchors.fill: parent
                    color: grayLight

                    Rectangle {
                        id: historicoGreenRec
                        width: parent.width
                        height: root.dp(4)
                        color: greenDark
                        anchors.bottom: historicoRec.bottom
                    }

                    Text {
                        anchors.centerIn: parent
                        color: white
                        text: "Histórico"
                        font.pixelSize: root.sp(12)
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(!novato) {
                                listCards.visible = true
                                graphics.visible = false
                                filterIcon.visible = true
                            }
                            historicoRec.color = grayLight
                            historicoGreenRec.visible = true
                            graficosGreenRec.visible = false
                            graficosRec.color = bgColor
                        }
                    }
                }
            }

            Item {
                id: graficos
                width: parent.width / 2
                height: parent.height
                anchors.right: parent.right
                anchors.top: parent.top

                Rectangle {
                    id: graficosRec
                    anchors.fill: parent
                    color: bgColor

                    Rectangle {
                        id: graficosGreenRec
                        width: parent.width
                        height: root.dp(4)
                        color: greenDark
                        anchors.bottom: graficosRec.bottom
                        visible: false
                    }

                    Text {
                        anchors.centerIn: parent
                        color: white
                        text: "Gráficos"
                        font.pixelSize: root.sp(12)
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(!novato) {
                                listCards.visible = false
                                graphics.visible = true
                                filterIcon.visible = false
                            }
                            historicoRec.color = bgColor
                            historicoGreenRec.visible = false
                            graficosGreenRec.visible = true
                            graficosRec.color = grayLight
                        }
                    }
                }
            }
        } // tab Menu

        // Lista de cards com as medidas já realizadas pelo usuário
        Item {
            id: cardsHistorico
            width: parent.width
            height: listCards.height
            anchors.top: tabIcons.bottom
            visible: false
            z: -1

            ListView {
                id: listCards
                    width: parent.width
                    height: root.dp(450)
                    anchors.top: parent.top

                    model: cardModel(historicoPage)
                    delegate: AppCard {
                        id: cardView
                        width: parent.width
                        margin: root.dp(10)
                        paper.radius: root.dp(5)//radiusText
                        paper.background.color: cardColor

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                keyCard = measureId.text
                                var meapage = measureView.createObject()
                                meapage.dateValor = Qt.formatDate(
                                            actionsRow.dateCard)

                                fitmassStack.push(meapage)
                                indicator.stopAnimating()
                                indicator.visible = false
                            }
                        }

                        media: Rectangle {
                            id: mediaRec
                            width: parent.width
                            height: width / 2
                            color: cardColor
                            radius: root.dp(5)//radiusText
                            border.color: cardColor
                            border.width: root.dp(1)

                            Item {
                                height: parent.height
                                anchors.top: parent.top
                                anchors.left: parent.left
                                anchors.right: parent.right

                                Text {
                                    id: measureId
                                    text: measureIdDB
                                    visible: false
                                }

                                Item {
                                    width: parent.width / 3
                                    height: parent.height
                                    anchors.left: parent.left

                                    Rectangle {
                                        color: "transparent"
                                        anchors.verticalCenter: parent.verticalCenter
                                        height: iconWeight.height + weightTxt.height
                                        width: parent.width

                                        AppImage {
                                            id: iconWeight
                                            height: root.dp(60)
                                            width: height
                                            source: "../../assets/icon_weight.png"
                                            fillMode: Image.PreserveAspectFit
                                            anchors.bottom: weightTxt.top
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }

                                        Text {
                                            id: weightTxt
                                            color: white
                                            text: weight
                                            anchors.top: iconWeight.bottom
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            topPadding: root.dp(5)
                                            font.bold: true
                                        }
                                    }
                                } // weight icon

                                Item {
                                    width: parent.width / 3
                                    height: parent.height
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    Rectangle {
                                        color: "transparent"
                                        anchors.verticalCenter: parent.verticalCenter
                                        height: iconMuscle.height + musclesTxt.height
                                        width: parent.width

                                        AppImage {
                                            id: iconMuscle
                                            height: root.dp(60)
                                            width: height
                                            source: "../../assets/icon_muscle.png"
                                            fillMode: Image.PreserveAspectFit
                                            anchors.bottom: musclesTxt.top
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }

                                        Text {
                                            id: musclesTxt
                                            color: white
                                            text: leanMass
                                            anchors.top: iconMuscle.bottom
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            topPadding: root.dp(5)
                                            font.bold: true
                                        }
                                    }
                                } // leanmass icon

                                Item {
                                    width: parent.width / 3
                                    height: parent.height
                                    anchors.right: parent.right

                                    Rectangle {
                                        color: "transparent"
                                        anchors.verticalCenter: parent.verticalCenter
                                        height: iconBodyFat.height + bodyFatTxt.height
                                        width: parent.width

                                        AppImage {
                                            id: iconBodyFat
                                            height: root.dp(60)
                                            width: height
                                            source: "../../assets/icon_body_fat.png"
                                            fillMode: Image.PreserveAspectFit
                                            anchors.bottom: bodyFatTxt.top
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }

                                        Text {
                                            id: bodyFatTxt
                                            color: white
                                            text: bodyFat
                                            anchors.top: iconBodyFat.bottom
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            topPadding: root.dp(5)
                                            font.bold: true
                                        }
                                    }
                                } // bodyfat icon
                            }
                        }

                        actions: CardActionsRow {
                            id: actionsRow
                            dateCard: date
                        }
                    }
                }
        } // cards histórico

        // Gráficos para apresentação visual de resultados
        Item {
            id: graphics
            width: parent.width
            height: Screen.height - 3 * tabIcons.height
            visible: false
            anchors.top: tabIcons.bottom

            AppFlickable {
                id: flickableGraphics
                anchors.fill: parent
                contentHeight: contentGraphics.height

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        flickableGraphics.forceActiveFocus()
                    }
                }

                Item {
                    id: contentGraphics
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: weightChartItem.height + leanMassChartItem.height + bodyFatChartItem.height + root.dp(30)

                    Item {
                        id: weightChartItem
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width
                        height: width / 1.5

                        ChartView {
                            id: weightChart
                            title: "Histórico de peso"
                            anchors.fill: parent
                            antialiasing: true
                            backgroundColor: grayLight
                            titleColor: white
                            legend.font.pixelSize: root.sp(12)
                            legend.labelColor: white

                            ValueAxis {
                                id: axisY1
                                gridVisible: false
                                tickCount: 0
                                min: 0
                                max: 1
                                labelsColor: white
                                labelsFont.pixelSize: root.sp(8)
                                color: grayDark
                            }

                            DateTimeAxis {
                                id: axisX1
                                format: "dd/MM"
                                labelsVisible: true
                                gridVisible: true
                                gridLineColor: grayDark
                                lineVisible: true
                                tickCount: 4
                                labelsColor: white
                                labelsFont.pixelSize: root.sp(8)
                                color: grayDark
                            }
                        }
                    }

                    Item {
                        id: leanMassChartItem
                        anchors.top: weightChartItem.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width
                        height: width / 1.5

                        ChartView {
                            id: leanMassChart
                            title: "Histórico de Massa Magra"
                            titleColor: white
                            anchors.fill: parent
                            antialiasing: true
                            backgroundColor: grayLight
                            legend.visible: false

                            ValueAxis {
                                id: axisY2
                                gridVisible: false
                                tickCount: 5
                                min: 0
                                max: 1
                                labelsColor: white
                                labelsFont.pixelSize: root.sp(10)
                                color: grayDark
                            }

                            DateTimeAxis {
                                id: axisX2
                                format: "dd/MM"
                                labelsVisible: true
                                gridVisible: true
                                gridLineColor: grayDark
                                lineVisible: true
                                tickCount: 4
                                labelsColor: white
                                labelsFont.pixelSize: root.sp(8)
                                color: grayDark
                            }
                        }
                    }

                    Item {
                        id: bodyFatChartItem
                        anchors.top: leanMassChartItem.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width
                        height: width / 1.5

                        ChartView {
                            id: bodyFatChart
                            title: "Histórico de Massa de Gordura"
                            titleColor: white
                            anchors.fill: parent
                            antialiasing: true
                            backgroundColor: grayLight
                            legend.visible: false

                            ValueAxis {
                                id: axisY3
                                gridVisible: false
                                tickCount: 5
                                min: 0
                                max: 1
                                labelsColor: white
                                labelsFont.pixelSize: root.sp(10)
                                color: grayDark
                            }

                            DateTimeAxis {
                                id: axisX3
                                format: "dd/MM"
                                labelsVisible: true
                                gridVisible: true
                                gridLineColor: grayDark
                                lineVisible: true
                                tickCount: 4
                                labelsColor: white
                                labelsFont.pixelSize: root.sp(8)
                                color: grayDark
                            }
                        }
                    }
                }
            }

            ScrollIndicator {
                flickable: flickableGraphics
            }

        } // gráficos histórico
    }

    // Mensagem caso não possua medidas
    Text {
        id: msgMedidas
        text: qsTr("Você ainda não possui medidas na Fitmass.")
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: greenDark
        font.pixelSize: root.dp(14)
    }

    // Mensagem para o filtro de cards por data
    Text {
        id: msgFilter
        text: qsTr("Não há medidas nessa data.")
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: greenDark
        font.pixelSize: root.dp(14)
    }

    Component.onCompleted: {
        Theme.colors.statusBarStyle = Theme.colors.statusBarStyleWhite

        indicator.visible = true
        indicator.startAnimating()

        buscaDadosUser()
        buscaMedidas()
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
