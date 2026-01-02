import QtQuick
import QtQuick.Layouts
import "." as Components
import "../theme" as Theme

RowLayout {
    required property bool charging
    required property real percentage
    spacing: 2

    function getIconCodePoint(percentage) {
        if (charging) return "\uec1c"
        if (percentage >= 0.9) return "\uebd2"
        if (percentage >= 0.7) return "\uebd4"
        if (percentage >= 0.6) return "\uebe2"
        if (percentage >= 0.5) return "\uebdd"
        if (percentage >= 0.3) return "\uebe0"
        if (percentage >= 0.2) return "\uebd9"
        return "\uebdc"
    }

    Components.FontIcon {
        font.pixelSize: 18
        codePoint: getIconCodePoint(percentage)
        color: percentage > 0.5 ? Theme.Color.green : Theme.Color.red
    }

    Text {
        text: "%1%".arg(percentage.toFixed(2) * 100)
        color: Theme.Color.fg
    }
}