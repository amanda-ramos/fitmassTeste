import QtQuick.Controls 2.4
import VPlayApps 1.0
import VPlay 2.0
import QtQuick 2.9
import QtQuick.Controls 2.0 as Quick2

Tumbler {
    property var val

    id: tumbler
    implicitWidth: dp(120) + 30
    model: val
    implicitHeight: visibleItemCount * 80
}
