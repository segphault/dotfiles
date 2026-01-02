import QtQuick

Text {
    required property string codePoint
    font.family: "Material Icons"
    font.pixelSize: 22
    text: codePoint
}