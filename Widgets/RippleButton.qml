import QtQuick
import QtQuick.Controls
import qs.Common

Button {
    id: root

    property color backgroundColor: Theme.surfaceVariant
    property color backgroundHover: Theme.secondary
    property color backgroundToggled: Theme.secondary
    property color backgroundToggledHover: Theme.secondary
    property color buttonColor: root.enabled ? (root.toggled ? (root.hovered ? backgroundToggledHover :
                                                                               backgroundToggled) : (root.hovered
                                                                                                     ? backgroundHover :
                                                                                                       backgroundColor)) :
                                               backgroundColor
    property real buttonHeight
    property real buttonRadius: Theme.cornerRadius
    property string buttonText
    property real buttonWidth
    property bool toggled

    background: Rectangle {
        id: buttonBackground

        color: root.buttonColor
        implicitHeight: root.buttonHeight
        implicitWidth: root.buttonWidth
        radius: root.buttonRadius
    }
    contentItem: StyledText {
        text: root.buttonText
    }
}
