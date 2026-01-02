import QtQuick
import QtQuick.Layouts
import Quickshell.I3
import "../theme" as Theme

RowLayout {
  property int radius: 0

  id: layout
  spacing: 1

  Repeater {
    id: repeater
    model: I3.workspaces.values
    delegate: Rectangle {
      required property var modelData
      required property int index

      readonly property bool first: index === 0
      readonly property bool last: index === repeater.count - 1
      
      color: modelData.focused ? Theme.Color.blue : Theme.Color.bgLight

      topLeftRadius: first ? layout.radius : 0
      bottomLeftRadius: first ? layout.radius : 0
      topRightRadius: last ? layout.radius : 0
      bottomRightRadius: last ? layout.radius : 0

      anchors.margins: 0
      width: 20
      height: 20

      Text {
        font.pixelSize: 12
        anchors.centerIn: parent
        text: modelData.name
        color: modelData.active ? Theme.Color.fg : Theme.Color.fgDarker
      }

      MouseArea {
        anchors.fill: parent
        onClicked: modelData.activate()
      }
    }
  }
}