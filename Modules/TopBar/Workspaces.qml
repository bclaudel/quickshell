import QtQuick
import Quickshell.Hyprland

import qs.Common

Rectangle {
    id: root

    property int maxWorkspaces: Settings.maxWorkspaces
    property var workspaces: getWorkspaces()

    height: 30
    width: workspacesRow.width + 2 * Theme.spacingM
    anchors.verticalCenter: parent.verticalCenter
    radius: Theme.cornerRadius
    color: {
        const baseColor = Theme.secondaryHover;
        return Qt.rgba(baseColor.r, baseColor.g, baseColor.b, baseColor.a * Theme.widgetTransparency);
    }

    // Function to get the workspaces
    function getWorkspaces() {
        workspaces = Array.from({
            length: maxWorkspaces
        }, (_, i) => {
            return Hyprland.workspaces.values.find(ws => ws.id === i + 1);
        });
    }

    // Initialize the workspaces when the component is created
    Component.onCompleted: getWorkspaces()

    // Listen for changes in Hyprland.workspaces.values
    Connections {
        target: Hyprland.workspaces
        function onValuesChanged() {
            getWorkspaces();
        }
    }

    Row {
        id: workspacesRow

        anchors.centerIn: parent
        spacing: Theme.spacingS

        Repeater {
            model: root.maxWorkspaces

            Rectangle {
                required property int index
                property bool isActive: workspaces[index]?.active ?? false
                property bool isOccupied: workspaces[index] !== undefined

                width: isActive ? Theme.spacingXL + Theme.spacingM : Theme.spacingL + Theme.spacingXS

                height: Theme.spacingL
                radius: height / 2
                color: isActive ? Theme.primary : isOccupied ? Theme.surfaceTextAlpha : Theme.surfaceTextLight
            }
        }
    }
}
