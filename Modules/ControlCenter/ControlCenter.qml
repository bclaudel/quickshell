import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland

import qs.Common
import qs.Widgets

PanelWindow {
    id: root

    property int controlCenterWidth: 460

    visible: SessionData.isControlCenterOpen
    implicitWidth: controlCenterWidth
    exclusiveZone: 0
    color: "transparent"

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
        asynchronous: true
        active: SessionData.isControlCenterOpen

        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: parent.left
            topMargin: SettingsData.hyprlandGapsOut
            bottomMargin: SettingsData.hyprlandGapsOut
            rightMargin: SettingsData.hyprlandGapsOut
            leftMargin: SettingsData.hyprlandGapsOut
        }

        focus: SessionData.isControlCenterOpen
        Keys.onPressed: event => {
            if (event.key === Qt.Key_Escape) {
                root.closeControlCenter();
            }
        }

        sourceComponent: Item {
            Rectangle {
                id: controlCenterBackground
                anchors.fill: parent
                radius: Theme.cornerRadius
                color: Theme.popupBackground()

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: Theme.spacingL
                    RowLayout {
                        spacing: Theme.spacingL

                        MaterialIcon {
                            name: "home"
                            size: 50
                            color: Theme.surfaceText
                        }

                        StyledText {
                            text: "Uptime:"
                            color: Theme.surfaceText
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        MaterialIcon {
                            name: "restart_alt"
                            size: Theme.iconSize
                            color: Theme.surfaceText
                        }

                        MaterialIcon {
                            name: "settings"
                            size: Theme.iconSize
                            color: Theme.surfaceText
                        }

                        MaterialButton {
                            buttonSize: 40
                            iconName: "power_settings_new"
                            iconSize: Theme.iconSize
                            iconColor: Theme.surfaceText
                            onClicked: {
                                Hyprland.dispatch("global quickshell:sessionScreenOpen");
                            }
                        }
                    }

                    Item {
                        Layout.fillHeight: true
                    }
                }
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
