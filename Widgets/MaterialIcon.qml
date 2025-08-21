import QtQuick
import qs.Common

StyledText {
    id: icon

    property alias color: icon.color
    property real fill: filled ? 1 : 0
    property bool filled: false
    property int grade: -25
    property alias name: icon.text
    property alias size: icon.font.pixelSize
    property int weight: filled ? 500 : 400

    font.family: "Material Symbols Rounded"
    font.pixelSize: 14
    font.variableAxes: ({
                            "FILL": fill.toFixed(1),
                            "GRAD": grade,
                            "opsz": 24,
                            "wght": weight
                        })
    font.weight: weight
    horizontalAlignment: Text.AlignHCenter
    // color: Theme.surfaceText
    verticalAlignment: Text.AlignVCenter
}
