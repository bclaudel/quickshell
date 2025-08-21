import QtQuick
import Quickshell.Hyprland

import qs.Common

Rectangle {
    id: root

    property int maxWorkspaces: SettingsData.maxWorkspaces
    property var workspaces: getWorkspaces()

    // Function to get the workspaces
    function getWorkspaces() {
        workspaces = Array.from({
                                    "length": maxWorkspaces
                                }, (_, i) => {
                                    return Hyprland.workspaces.values.find(ws => ws.id === i + 1);
                                });
    }

    anchors.verticalCenter: parent.verticalCenter
    color: {
        const baseColor = Theme.secondaryHover;
        return Qt.rgba(baseColor.r, baseColor.g, baseColor.b, baseColor.a
                       * Theme.widgetTransparency);

    }
    height: 30
    radius: Theme.cornerRadius
    width: workspacesRow.width + 2 * Theme.spacingM

    // Initialize the workspaces when the component is created
    Component.onCompleted: getWorkspaces()

    // Listen for changes in Hyprland.workspaces.values
    Connections {
        function onValuesChanged() {
            getWorkspaces();
        }

        target: Hyprland.workspaces
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

                color: isActive ? Theme.primary : isOccupied ? Theme.surfaceTextAlpha :
                                                               Theme.surfaceTextLight
                height: Theme.spacingL
                radius: height / 2
                width: isActive ? Theme.spacingXL + Theme.spacingM : Theme.spacingL
                                  + Theme.spacingXS
            }
        }
    }
}
