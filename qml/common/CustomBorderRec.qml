import QtQuick 2.0

Rectangle
{

    property bool commonBorder : true

    property int lBorderwidth : dp(5)
    property int rBorderwidth : dp(5)
    property int tBorderwidth : dp(5)
    property int bBorderwidth : dp(5)

    property int commonBorderWidth : dp(5)

    z : -2

    property string borderColor : "green"

    color: borderColor

    anchors
    {
        left: parent.left
        right: parent.right
        top: parent.top
        bottom: parent.bottom

        topMargin    : commonBorder ? -commonBorderWidth : -tBorderwidth
        bottomMargin : commonBorder ? -commonBorderWidth : -bBorderwidth
        leftMargin   : commonBorder ? -commonBorderWidth : -lBorderwidth
        rightMargin  : commonBorder ? -commonBorderWidth : -rBorderwidth
    }
}
