import QtQuick
import Quickshell
import qs.Common

PanelWindow {
    id: root

    property real backgroundTransparency: SettingsData.topBarTransparency

    color: Theme.popupBackground()
    implicitHeight: Theme.barHeight - 4

    anchors {
        left: true
        right: true
        top: true
    }

    Item {
        id: barContent

        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8

        Row {
            id: leftSection

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height
            spacing: Theme.spacingXS

            Workspaces {
            }
        }

        Row {
            id: rightSection

            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height
            spacing: Theme.spacingXS

            ControlCenterButton {
            }
        }
    }
}
