import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire

import "../components" as Components
import "../theme" as Theme

RowLayout {
  property var sink

  function getIconCodePoint() {
    console.log(sink.audio)
    if (sink.audio.muted || sink.audio.volume === 0) return "\ue04e"
    if (sink.audio.volume < 0.5) return "\ue04d"
    return "\ue050"
  }

  Components.FontIcon {
      font.pixelSize: 18
      codePoint: getIconCodePoint()
      color: Theme.Color.fg
  }

  Text {
      text: "%1%".arg(sink.audio.volume.toFixed(2) * 100)
      color: Theme.Color.fg
  }

  MouseArea {
    anchors.fill: parent
    onClicked: sink.audio.muted = !sink.audio.muted
    onWheel: {
      if (wheel.angleDelta.y > 0) {
        sink.audio.volume = Math.min(sink.audio.volume + 0.05, 1.0)
      } else {
        sink.audio.volume = Math.max(sink.audio.volume - 0.05, 0.0)
      }
    }
  }
}