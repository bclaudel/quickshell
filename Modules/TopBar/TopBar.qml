import QtQuick
import Quickshell

import qs.Common

PanelWindow {
    id: root

    property real backgroundTransparency: SettingsData.topBarTransparency

    color: Theme.popupBackground()

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: Theme.barHeight - 4

    Item {
        id: barContent
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8

        Row {
            id: leftSection

            height: parent.height
            spacing: Theme.spacingXS
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            Workspaces {}
        }

        Row {
            id: rightSection

            height: parent.height
            spacing: Theme.spacingXS
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            ControlCenterButton {}
        }
    }
}
