import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland

import qs.Common
import qs.Widgets

Scope {
    id: root

    property var focusedScreen: Quickshell.screens.find(s => s.name === Hyprland.focusedMonitor
                                                        ?.name)

    function closeLockScreen() {
        lockScreenLoader.active = false;
    }

    function openLockScreen() {
        lockScreenLoader.active = true;
    }

    function toggleLockScreen() {
        lockScreenLoader.active = !lockScreenLoader.active;
    }

    Loader {
        id: lockScreenLoader

        active: false

        sourceComponent: PanelWindow {
            id: lockScreen

            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.namespace: "quickshell:lockScreen"
            color: Qt.rgba(Theme.surfaceContainer.r, Theme.surfaceContainer.g,
                           Theme.surfaceContainer.b, Theme.opacityMedium)
            exclusionMode: ExclusionMode.Ignore
            implicitHeight: root.focusedScreen?.height ?? 0
            implicitWidth: root.focusedScreen?.width ?? 0
            visible: lockScreenLoader.active

            anchors {
                left: true
                right: true
                top: true
            }

            MouseArea {
                id: sessionMouseArea

                anchors.fill: parent

                onClicked: {
                    root.closeLockScreen();
                }
            }

            ColumnLayout {
                id: lockScreenContent

                anchors.centerIn: parent
                spacing: Theme.spacingXL

                Keys.onPressed: event => {
                                    if (event.key === Qt.Key_Escape) {
                                        root.closeLockScreen();
                                    }
                                }

                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 0

                    StyledText {
                        Layout.alignment: Qt.AlignHCenter
                        color: Theme.surfaceText
                        font.pixelSize: Theme.fontSizeXXLarge
                        font.weight: Font.DemiBold
                        horizontalAlignment: Text.AlignHCenter
                        text: "Session"
                    }

                    StyledText {
                        Layout.alignment: Qt.AlignHCenter
                        color: Theme.surfaceText
                        font.pixelSize: Theme.fontSizeLarge
                        horizontalAlignment: Text.AlignHCenter
                        text: "Arrow keys to navigate, Enter to select\nEsc or click anywhere to cancel"
                    }
                }

                GridLayout {
                    columnSpacing: Theme.spacingL + 4
                    columns: 3
                    rowSpacing: Theme.spacingL + 4

                    SessionButton {
                        id: sessionLock

                        KeyNavigation.down: sessionShutdown
                        KeyNavigation.right: sessionLogout
                        buttonIcon: "lock"
                        focus: lockScreen.visible

                        onClicked: {
                            console.log("Locking session");
                        }
                    }

                    SessionButton {
                        id: sessionLogout

                        KeyNavigation.down: sessionReboot
                        KeyNavigation.left: sessionLock
                        KeyNavigation.right: sessionHibernate
                        buttonIcon: "logout"

                        onClicked: {
                            console.log("Logging out");
                        }
                    }

                    SessionButton {
                        id: sessionHibernate

                        KeyNavigation.down: sessionFirmwareReboot
                        KeyNavigation.left: sessionLogout
                        buttonIcon: "downloading"

                        onClicked: {
                            console.log("Hibernating session");
                        }
                    }

                    SessionButton {
                        id: sessionShutdown

                        KeyNavigation.right: sessionReboot
                        KeyNavigation.up: sessionLock
                        buttonIcon: "power_settings_new"

                        onClicked: {
                            console.log("Powering off");
                        }
                    }

                    SessionButton {
                        id: sessionReboot

                        KeyNavigation.left: sessionShutdown
                        KeyNavigation.right: sessionFirmwareReboot
                        KeyNavigation.up: sessionLogout
                        buttonIcon: "restart_alt"

                        onClicked: {
                            console.log("Rebooting session");
                        }
                    }

                    SessionButton {
                        id: sessionFirmwareReboot

                        KeyNavigation.left: sessionReboot
                        KeyNavigation.up: sessionHibernate
                        buttonIcon: "settings_applications"

                        onClicked: {
                            console.log("Reboot to firmware settings");
                        }
                    }
                }
            }
        }
    }

    IpcHandler {
        function close(): void {
        root.closeLockScreen();
    }

        function open(): void {
                             root.openLockScreen();
                         }

        function toggle(): void {
        root.toggleLockScreen();
    }

        target: "lockScreen"
    }

    GlobalShortcut {
        description: "Open the session screen"
        name: "sessionScreenOpen"

        onPressed: {
            root.openLockScreen();
        }
    }

    GlobalShortcut {
        description: "Close the session screen"
        name: "sessionScreenClose"

        onPressed: {
            root.closeLockScreen();
        }
    }

    GlobalShortcut {
        description: "Toggle the session screen"
        name: "sessionScreenToggle"

        onPressed: {
            root.toggleLockScreen();
        }
    }
}
