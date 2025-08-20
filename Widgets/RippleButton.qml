import QtQuick
import QtQuick.Controls

import qs.Common

Button {
    id: root

    property bool toggled
    property real buttonHeight
    property real buttonWidth
    property string buttonText
    property real buttonRadius: Theme.cornerRadius

    property color backgroundColor: Theme.surfaceVariant
    property color backgroundHover: Theme.secondary
    property color backgroundToggled: Theme.secondary
    property color backgroundToggledHover: Theme.secondary

    property color buttonColor: root.enabled ? (root.toggled ? (root.hovered ? backgroundToggledHover : backgroundToggled) : (root.hovered ? backgroundHover : backgroundColor)) : backgroundColor

    background: Rectangle {
        id: buttonBackground

        radius: root.buttonRadius
        implicitHeight: root.buttonHeight
        implicitWidth: root.buttonWidth

        color: root.buttonColor
    }

    contentItem: StyledText {
        text: root.buttonText
    }
}
