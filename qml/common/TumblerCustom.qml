import QtQuick.Controls 2.4
import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2

Tumbler {

    property var minimo: 0
    property var maximo: 100
    property var passo: 1
    property bool decimos: false

    id: tumbler
    implicitWidth: dp(120) + 30
    model: vector(minimo, maximo, passo)
    implicitHeight: visibleItemCount * 80

    function vector(min, max, step){
        var j = 0;
        var i = 0;
        var valores = [];

        for (i = min; i <=max; i = i + step) {
            if(decimos)
                valores[j] = i.toFixed(2);
            else
                valores[j] = i.toFixed(0);
            j++;

        }
        return valores;

    }
}
