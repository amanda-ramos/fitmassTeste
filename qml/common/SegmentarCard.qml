import QtQuick 2.0

Item {
    id: segmentarCard
    width: parent.width
    height: imageWomen.height

    property alias imgSource: imageWomen.source

    property color titleColor: verdeMassa
    property color subtitleColor: amareloMassa
    property color textColor: "black"
    property color detailColor: "#b4b4b4"

    property var titleFontSize: sp(4)
    property var subtitleFontSize: sp(4)
    property var textFontSize: sp(4)

    property var horizontalAlignmentText: Text.AlignHCenter

    property alias membSupEsqTitle: membrosSuperioresEsq.title
    property alias membSupEsqSubtitle: membrosSuperioresEsq.subtitle
    property alias membSupEsqValor: membrosSuperioresEsq.valor
    property alias membSupEsqAnalise: membrosSuperioresEsq.analise

    property alias abdTitle: regiaoAbdominal.title
    property alias abdSubtitle: regiaoAbdominal.subtitle
    property alias abdValor: regiaoAbdominal.valor
    property alias abdAnalise: regiaoAbdominal.analise

    property alias membInfEsqTitle: membrosInferioresEsq.title
    property alias membInfEsqSubtitle: membrosInferioresEsq.subtitle
    property alias membInfEsqValor: membrosInferioresEsq.valor
    property alias membInfEsqAnalise: membrosInferioresEsq.analise

    property alias membSupDirTitle: membrosSuperioresDir.title
    property alias membSupDirSubtitle: membrosSuperioresDir.subtitle
    property alias membSupDirValor: membrosSuperioresDir.valor
    property alias membSupDirAnalise: membrosSuperioresDir.analise

    property alias membInfDirTitle: membrosInferioresDir.title
    property alias membInfDirSubtitle: membrosInferioresDir.subtitle
    property alias membInfDirValor: membrosInferioresDir.valor
    property alias membInfDirAnalise: membrosInferioresDir.analise

    Image {
        id: imageWomen
        source: ""
        height: dp(250)
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Row {
        width: parent.width
        height: columnEsq.height
        anchors.top: imageWomen.top
        anchors.left: segmentarCard.left

        Column {
            id: columnEsq
            width: parent.width / 2
            height: imageWomen.height
            anchors.left: parent.left

            SegmentarCardDados {
                id: membrosSuperioresEsq

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top

                title: ""
                subtitle: ""
                valor: ""
                analise: ""
            }

            SegmentarCardDados {
                id: regiaoAbdominal

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                title: ""
                subtitle: ""
                valor: ""
                analise: ""
            }

            SegmentarCardDados {
                id: membrosInferioresEsq

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom

                title: ""
                subtitle: ""
                valor: ""
                analise: ""
            }
        }

        Column {
            id: columnDir
            width: parent.width / 2
            height: imageWomen.height
            anchors.right: parent.right

            SegmentarCardDados {
                id: membrosSuperioresDir

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top

                title: ""
                subtitle: ""
                valor: ""
                analise: ""
            }

            SegmentarCardDados {
                id: membrosInferioresDir

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom

                title: ""
                subtitle: ""
                valor: ""
                analise: ""
            }
        }
    }
}
