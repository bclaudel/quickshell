import QtQuick

import qs.Common
import qs.Widgets

StyledRect {
    id: root

    property alias text: input.text
    property string iconName: ""
    property int iconSize: Theme.iconSize
    property color iconColor: Theme.surfaceVariantText
    property color iconFocusedColor: Theme.primary

    property color backgroundColor: Qt.rgba(Theme.surfaceContainer.r, Theme.surfaceContainer.g,
                                            Theme.surfaceContainer.b, 0.9)
    property color focusedBorderColor: Theme.primary
    property color normalBorderColor: Theme.outlineStrong
    property color placeholderColor: Theme.outlineButton
    property int borderWidth: 1
    property int focusedBorderWidth: 2
    property real cornerRadius: Theme.cornerRadius

    property real topPadding: Theme.spacingM
    property real bottomPadding: Theme.spacingM
    readonly property real leftPadding: Theme.spacingM + (iconName ? iconSize + Theme.spacingM : 0)
    readonly property real rightPadding: Theme.spacingM

    signal textEdited

    width: 200
    height: 48
    radius: Theme.cornerRadius
    color: backgroundColor
    border.color: input.activeFocus ? focusedBorderColor : normalBorderColor
    border.width: input.activeFocus ? focusedBorderWidth : borderWidth

    MaterialIcon {
        id: icon

        anchors.left: parent.left
        anchors.leftMargin: Theme.spacingM
        anchors.verticalCenter: parent.verticalCenter
        name: root.iconName
        size: root.iconSize
        color: root.iconColor
        visible: root.iconName !== ""
    }

    TextInput {
        id: input

        anchors.fill: parent
        anchors.leftMargin: root.leftPadding
        anchors.rightMargin: root.rightPadding
        anchors.topMargin: root.topPadding
        anchors.bottomMargin: root.bottomPadding
        verticalAlignment: TextInput.AlignVCenter
        font.pixelSize: Theme.fontSizeMedium
        color: Theme.surfaceText
        onTextChanged: root.textEdited()
    }
}
