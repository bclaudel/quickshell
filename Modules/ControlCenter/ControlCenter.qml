import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland

import qs.Common

PanelWindow {
    id: root

    property int controlCenterWidth: 460

    visible: SessionData.isControlCenterOpen
    implicitWidth: controlCenterWidth
    exclusiveZone: 0

    anchors {
        top: true
        right: true
        bottom: true
    }

    function openControlCenter() {
        SessionData.isControlCenterOpen = true;
    }

    function closeControlCenter() {
        SessionData.isControlCenterOpen = false;
    }

    function toggleControlCenter() {
        SessionData.isControlCenterOpen = !SessionData.isControlCenterOpen;
    }

    HyprlandFocusGrab {
        id: grab
        active: SessionData.isControlCenterOpen
        windows: [root]
        onCleared: () => {
            closeControlCenter();
        }
    }

    Loader {
        id: controlCenterLoader
        active: SessionData.isControlCenterOpen
        focus: SessionData.isControlCenterOpen

        Keys.onPressed: event => {
            if (event.key === Qt.Key_Escape) {
                root.closeControlCenter();
            }
        }
    }

    GlobalShortcut {
        name: "controlCenterOpen"
        description: "Open the control center"

        onPressed: {
            root.openControlCenter();
        }
    }

    GlobalShortcut {
        name: "controlCenterClose"
        description: "Close the control center"

        onPressed: {
            root.closeControlCenter();
        }
    }

    GlobalShortcut {
        name: "controlCenterToggle"
        description: "Toggle the control center"

        onPressed: {
            root.toggleControlCenter();
        }
    }
}
