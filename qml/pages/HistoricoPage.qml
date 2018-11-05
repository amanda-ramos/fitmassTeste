import VPlayApps 1.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2
import Qt.labs.settings 1.0 as QtLabs
import QtQuick.Controls.Material 2.0
import QtCharts 2.2

import "../common"
import "../pages"

Page {
    title: "Fitmass"
    id: historicoPage
    height: screenSizeY
    width: screenSizeX

    backgroundColor: bgColor

    property bool initial: true
    property bool dateFilter: false
    property bool novato: true

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

    function cardModel(parent) {

        var s = 'import QtQuick 2.0; ListModel {\n'
        s += s2
        s += "}\n"
        console.log("DADOS: " + s)

        return Qt.createQmlObject(s, parent, "mainModel")
    }

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

    function buscaDadosUser() {

        qtdeMedida = user[7];
        graficosConfig();
        userGender = user[3];

        var age = user[2];

        userAge = calculateAge(
                    Date.fromLocaleString(
                        Qt.locale(), age,
                        "dd/MM/yyyy"));

        pesoDesejado = user[5];

        console.log("HISTORICO 1 - idade: " + userAge)
        console.log("HISTORICO 1 - qtde de medidas: " + qtdeMedida)

        if (qtdeMedida == 0) {
            novato = true
            console.log("NOVATO")
        } else {
            novato = false
            filterIcon.visible = true
            console.log("NÃO NOVATO")
        }
    }

    function buscaMedidas() {
        for(var i=0; i<qtdeMedida; i++){
            keyMeasure = i

            buscaDadosMedida(keyMeasure)
        }
    }

    function buscaDadosMedida(keyMedida) {
        var indiceX
        measureIdDB = keyMedida

        console.log("busca da Medida " + keyMedida)

        if(keyMedida == 0)
            keyMedida = medida0
        if(keyMedida == 1)
            keyMedida = medida1
        if(keyMedida == 2)
            keyMedida = medida2
        console.log("busca da Medida " + keyMedida)


        console.log("medida ID: " + keyMedida)
        if (initial) {
            indiceX = k + 1
            line.append(indiceX, keyMedida[1])
            line2.append(indiceX, pesoDesejado)
            line3.append(indiceX, keyMedida[2])
            line4.append(indiceX, keyMedida[3])

            axisX1.max = indiceX
            axisX2.max = indiceX
            axisX3.max = indiceX

            axisY1.min = parseFloat(pesoDesejado) - 20
            axisY2.min = parseFloat(keyMedida[2]) - 5
            axisY3.min = parseFloat(keyMedida[3]) - 10

            axisY1.max = parseFloat(pesoDesejado) + 20
            axisY2.max = parseFloat(keyMedida[2]) + 5
            axisY3.max = parseFloat(keyMedida[3]) + 10

            axisX1.tickCount = k + 1
            axisX2.tickCount = k + 1
            axisX3.tickCount = k + 1

            k++

            if (k >= qtdeMedida) {
                initial = false
            }
        }

        s2 += "ListElement {measureIdDB: \"" + measureIdDB
                + "\"; weight: \"" + keyMedida[1] + " kg" + "\"; leanMass: \""
                + keyMedida[2] + " kg" + "\"; bodyFat: \"" + keyMedida[3]
                + " kg" + "\"; date: \"" + keyMedida[7] + "\" }\n"
    }

    function graficosConfig() {
        line = weightChart.createSeries(ChartView.SeriesTypeSpline,
                                        "Histórico de Peso", axisX1, axisY1)
        line2 = weightChart.createSeries(ChartView.SeriesTypeSpline,
                                         "Peso Desejado", axisX1, axisY1)
        line3 = leanMassChart.createSeries(ChartView.SeriesTypeSpline,
                                           "Histórico de Massa Magra",
                                           axisX2, axisY2)
        line4 = bodyFatChart.createSeries(ChartView.SeriesTypeSpline,
                                          "Histórico de Massa de Gordura",
                                          axisX3, axisY3)

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

        axisX1.min = 1
        axisX2.min = 1
        axisX3.min = 1

        axisY1.tickCount = 4
        axisY2.tickCount = 4
        axisY3.tickCount = 4
    }

    rightBarItem: NavigationBarRow {
        id: rightNavBarRowHostorico

        IconButtonBarItem {
            title: "Filtro por data"
            icon: IconType.filter
            id: filterIcon
            visible: false
            iconSize: root.dp(25)

            onClicked: {
                nativeUtils.displayDatePicker()
                dateFilter = true
            }

            Connections {
                target: nativeUtils
                onDatePickerFinished: {
                    var pickedDate
                    if (accepted) {

                        if(dateFilter){

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
                            nativeUtils.displayAlertDialog(
                                        "Data escolhida",
                                        "Data: " + Qt.formatDate(date,
                                                                 "dd/MM"), "ok")
                        } else {
                            Date.prototype.addDays = function (days) {
                                var date = new Date(this.valueOf())
                                date.setDate(date.getDate() + days)
                                return date
                            }

                            Date.prototype.addHours = function (h) {
                                this.setTime(this.getTime(
                                                 ) + (h * 60 * 60 * 1000))
                                return this
                            }
                            pickedDate = Qt.formatDate(date.addHours(
                                                           24 - hour),
                                                       "dd/MM/yyyy")

                            s2 = ""
                            databaseFitmass.getValue("medidas", {
                                                         orderByChild: "user_date",
                                                         equalTo: userID + "_" + pickedDate
                                                     },
                                                     function (success5, key5, value5) {
                                                         if (success5) {
                                                             for (var prop5 in value5) {
                                                                 console.log("FILTRO - VALUE - " + prop5)
                                                                 keyCardFilter = prop5

                                                                 databaseFitmass.getValue(
                                                                             "medidas/" + keyCardFilter,
                                                                             {
                                                                                 orderByValue: true
                                                                             },
                                                                             function (success4, key4, value4) {
                                                                                 if (success4) {
                                                                                     console.debug("HISTORICO FILTRO - Read value " + value4 + " for key " + key4)

                                                                                     console.log("Data card: " + Qt.formatDate(value4.dateMedida, "dd/MM/yyyy") + " Data escolhida: " + pickedDate)
                                                                                     s2 += "ListElement {measureIdDB: \"" + value4.measureID + "\"; weight: \"" + value4.weight + "\"; leanMass: \"" + value4.leanMass + "\"; bodyFat: \"" + value4.bodyFat + "\"; date: \"" + value4.dateMedida + "\" }\n"
                                                                                     console.log("s2: " + s2)
                                                                                 } else {
                                                                                     console.debug("HISTORICO FILTRO - Error with message: " + value4)
                                                                                     nativeUtils.displayAlertDialog("Error!", value4, "OK")
                                                                                 }
                                                                             })
                                                             }
                                                         } else {
                                                             msgFilter.visible = true
                                                             graphics.visible = false
                                                             console.log("Não possui card nessa data")
                                                         }
                                                     })
                        }
                        dateFilter = false;
                    }
                    }
                }
            }
        }

        IconButtonBarItem {
            id: closeIcon
            title: "Voltar"
            icon: IconType.close
            visible: false
            iconSize: root.dp(25)

            onClicked: {
                closeIcon.visible = false
                filterIcon.visible = true
                graphics.visible = true
                msgFilter.visible = false
                s2 = ""
                buscaMedidas()
            }
        }

        IconButtonBarItem {
            title: "Sair"
            icon: IconType.signout
            iconSize: root.dp(25)

            onClicked: {
                stack.pop()
            }
        }
    }

    Item {
        id: content
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        height: listCards.height + graphics.height + tabIcons.height

        Item {
            id: tabIcons
            width: parent.width
            height: root.dp(50)
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
                }

                Image {
                    id: historicoIcon
                    height: root.dp(30)
                    width: height
                    anchors.centerIn: parent
                    source: "../../assets/icon_history.png"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            listCards.visible = true
                            graphics.visible = false
                            historicoRec.color = grayLight
                            graficosRec.color = bgColor
                            filterIcon.visible = true
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
                }

                Image {
                    id: graficosIcon
                    height: root.dp(30)
                    width: height
                    anchors.centerIn: parent
                    source: "../../assets/icon_analytics.png"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            listCards.visible = false
                            graphics.visible = true
                            historicoRec.color = bgColor
                            graficosRec.color = grayLight
                            filterIcon.visible = false
                        }
                    }
                }
            }
        }

        Item {
            id: cardsHistorico
            width: parent.width
            height: listCards.height
            anchors.top: tabIcons.bottom
            z: -1

        ListView {
                    id: listCards
                    width: parent.width
                    height: root.dp(450)
                    anchors.top: parent.top
                    visible: true //novato ? false : true

                    model: cardModel(historicoPage)
                    delegate: AppCard {
                        id: cardView
                        width: parent.width
                        margin: dp(15)
                        paper.radius: dp(5)

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                keyCard = measureId.text
                                var meapage = measureView.createObject()
                                meapage.dateValor = Qt.formatDate(
                                            actionsRow.dateCard) //).split(" ")[0]
                                meapage.wantedWeightValor = 60

                                fitmassStack.push(meapage)
                            }
                        }

                        media: Rectangle {
                            id: mediaRec
                            width: parent.width
                            height: width * 4 / 7
                            color: grayLight
                            radius: dp(5)

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
                                            height: dp(80)
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
                                            topPadding: dp(5)
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
                                            height: dp(80)
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
                                            topPadding: dp(5)
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
                                            height: dp(80)
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
                                            topPadding: dp(5)
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
        }

        Item {
            id: graphics
            width: parent.width
            height: imgSwipeView.height + pageControl.height
            visible: false //novato ? false : true
            anchors.top: tabIcons.bottom

            Quick2.SwipeView {
                id: imgSwipeView
                width: parent.width
                height: width / 1.5
                anchors.bottom: parent.bottom

                Item {
                    ChartView {
                        id: weightChart
                        title: ""
                        width: parent.width
                        height: width / 1.5
                        antialiasing: true
                        backgroundColor: grayLight
                        titleColor: white
                        legend.font.pixelSize: root.sp(12)
                        legend.labelColor: white

                        ValueAxis {
                            id: axisY1
                            gridVisible: true
                            tickCount: 0
                            min: 0
                            max: 1
                            labelsColor: white
                            labelsFont: Qt.font({ pixelSize: root.sp(8)})
                        }

                        ValueAxis {
                            id: axisX1
                            min: 0
                            max: 1
                            gridVisible: true
                            tickCount: 5
                            labelsColor: white
                            labelsFont: Qt.font({ pixelSize: root.sp(8)})
                        }
                    }
                }

                Item {
                    ChartView {
                        id: leanMassChart
                        title: ""
                        width: parent.width
                        height: width / 1.5
                        antialiasing: true
                        backgroundColor: grayLight
                        legend.font.pixelSize: root.sp(12)
                        legend.labelColor: white

                        ValueAxis {
                            id: axisY2
                            gridVisible: true
                            tickCount: 5
                            min: 0
                            max: 1
                            labelsColor: white
                            labelsFont: Qt.font({ pixelSize: root.sp(10)})
                        }

                        ValueAxis {
                            id: axisX2
                            min: 0
                            max: 1
                            gridVisible: true
                            tickCount: 0
                            labelsColor: white
                            labelsFont: Qt.font({ pixelSize: root.sp(10)})
                        }
                    }
                }

                Item {
                    ChartView {
                        id: bodyFatChart
                        title: ""
                        width: parent.width
                        height: width / 1.5
                        antialiasing: true
                        backgroundColor: grayLight
                        legend.font.pixelSize: root.sp(12)
                        legend.labelColor: white

                        ValueAxis {
                            id: axisY3
                            gridVisible: true
                            tickCount: 5
                            min: 0
                            max: 1
                            labelsColor: white
                            labelsFont: Qt.font({ pixelSize: root.sp(10)})
                        }

                        ValueAxis {
                            id: axisX3
                            min: 0
                            max: 1
                            gridVisible: true
                            tickCount: 0
                            labelsColor: white
                            labelsFont: Qt.font({ pixelSize: root.sp(10)})
                        }
                    }
                }
            }

            PageControl {
                id: pageControl
                height: 30 + root.dp(5)
                pages: 3
                currentPage: imgSwipeView.currentIndex
                clickableIndicator: true
                spacing: root.dp(10)
                onPageSelected: imgSwipeView.currentIndex = index
                tintColor: grayLight
                activeTintColor: greenDark
            }
        } // gráficos histórico

        Text {
            id: msgFilter
            text: qsTr("Não há medidas nessa data.")
            visible: false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: graphics.verticalCenter
        }

        Text {
            id: msgMedidas
            text: qsTr("Você ainda não possui medidas.")
            visible: novato ? true : false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: graphics.verticalCenter
        }
    }

    Component.onCompleted: {
        buscaDadosUser()

        buscaMedidas()
    }
}
