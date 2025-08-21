import QtQuick
import qs.Common
import qs.Widgets

StyledRect {
    id: root

    property color backgroundColor: "transparent"
    property int buttonSize: 32
    property bool circular: true
    property color iconColor: Theme.surfaceText
    property string iconName: ""
    property int iconSize: Theme.iconSize - 4

    signal clicked

    color: backgroundColor
    height: buttonSize
    radius: circular ? buttonSize / 2 : Theme.cornerRadius
    width: buttonSize

    MaterialIcon {
        anchors.centerIn: parent
        color: root.iconColor
        name: root.iconName
        size: root.iconSize
    }

    StateLayer {
        cornerRadius: root.radius
        stateColor: Theme.primary

        onClicked: {
            root.clicked();
        }
    }
}
