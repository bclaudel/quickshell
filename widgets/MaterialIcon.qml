import QtQuick
import qs.common

StyledText {
    id: icon

    property alias name: icon.text
    property alias size: icon.font.pixelSize
    property alias color: icon.color
    property bool filled: false
    property real fill: filled ? 1 : 0
    property int grade: -25
    property int weight: filled ? 500 : 400

    font.family: "Material Symbols Rounded"
    font.pixelSize: 14
    font.weight: weight
    // color: Theme.surfaceText
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    font.variableAxes: ({
            "FILL": fill.toFixed(1),
            "GRAD": grade,
            "opsz": 24,
            "wght": weight
        })
}
