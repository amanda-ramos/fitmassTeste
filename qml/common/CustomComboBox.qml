import VPlayApps 1.0
import QtQuick 2.5
import QtQuick.Controls 2.0 as Quick2

Quick2.ComboBox {
  id: comboBox
  implicitWidth: dp(90) + 20
  implicitHeight: dp(24) + topPadding + bottomPadding
  padding: dp(5)

  // overwrite style for density independent sizes
  delegate: Quick2.ItemDelegate {
    width: comboBox.implicitWidth
    height: comboBox.implicitHeight
    padding: dp(5)

    contentItem: AppText {
      text: modelData
      color: highlighted ? verdeMassa : "#4b4b4b"
      wrapMode: Text.NoWrap
    }

    highlighted: comboBox.highlightedIndex == index
  }

  contentItem: AppText {
    width: comboBox.width - comboBox.indicator.width - comboBox.spacing
    text: comboBox.displayText
    wrapMode: Text.NoWrap
  }
}
