import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.UPower
import Quickshell.Services.SystemTray
import Quickshell.Services.Pipewire
import Quickshell.I3
import "theme" as Theme
import "components" as Components

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  Rectangle {
    color: Theme.Color.blue
    height: 1.5

    anchors {
      bottom: parent.bottom
      left: parent.left
      right: parent.right
    }
  }

  color: Theme.Color.bg
  implicitHeight: 34

  RowLayout {
    anchors.left: parent.left
    anchors.leftMargin: 10
    anchors.verticalCenter: parent.verticalCenter
    spacing: 10

    Components.FontIcon {
      codePoint: "\ue5c3"
      color: Theme.Color.blue

      MouseArea {
        anchors.fill: parent
        onPressed: {
          Quickshell.execDetached(["/home/segphault/Applications/vicinae", "toggle"])
        }
      }
    }

    Components.FontIcon {
      codePoint: "\uf088"
      color: Theme.Color.blue

      MouseArea {
        anchors.fill: parent
        onPressed: {
          Quickshell.execDetached(["/home/segphault/Applications/vicinae", "deeplink", "vicinae://extensions/vicinae/wm/switch-windows"])
        }
      }
    }

    Components.WorkspaceIndicator {
      radius: 4
    }
  }

  RowLayout {
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    anchors.rightMargin: 10
    spacing: 20

    RowLayout {
      spacing: 5

      Repeater {
        model: SystemTray.items.values

        delegate: IconImage {
          required property var modelData
          source: modelData.icon
          width: 22
          height: 22

          MouseArea {
            anchors.fill: parent
            onClicked: {
              modelData.activate()
            }
          }
        }
      }
    }

    Components.AudioIndicator {
      sink: audio.sink
    }

    Components.BatteryIndicator {
      charging: !UPower.onBattery
      percentage: UPower.displayDevice.percentage
    }

    Text {
      text: Qt.formatDateTime(clock.date, "h:mm A")
      color: Theme.Color.fg
    }

    Components.FontIcon {
      codePoint: "\ue8ac"
      color: Theme.Color.blue

      MouseArea {
        anchors.fill: parent
        onPressed: {
          console.log(SystemTray.items.values)
        }
      }
    }
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds  
  }

  QtObject {
    id: audio
    readonly property var sink: Pipewire.defaultAudioSink
  }

  PwObjectTracker {
    objects: [audio.sink]
  }
}