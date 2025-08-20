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
    property var focusedScreen: Quickshell.screens.find(s => s.name === Hyprland.focusedMonitor?.name)

    Loader {
        id: lockScreenLoader
        active: false

        sourceComponent: PanelWindow {
            id: lockScreen
            visible: lockScreenLoader.active

            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.namespace: "quickshell:lockScreen"
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
            color: Qt.rgba(Theme.surfaceContainer.r, Theme.surfaceContainer.g, Theme.surfaceContainer.b, Theme.opacityMedium)

            anchors {
                top: true
                left: true
                right: true
            }

            implicitWidth: root.focusedScreen?.width ?? 0
            implicitHeight: root.focusedScreen?.height ?? 0

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
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: Theme.fontSizeXXLarge
                        font.weight: Font.DemiBold
                        color: Theme.surfaceText
                        text: "Session"
                    }
                    StyledText {
                        Layout.alignment: Qt.AlignHCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: Theme.fontSizeLarge
                        color: Theme.surfaceText
                        text: "Arrow keys to navigate, Enter to select\nEsc or click anywhere to cancel"
                    }
                }

                GridLayout {
                    columns: 3
                    columnSpacing: Theme.spacingL + 4
                    rowSpacing: Theme.spacingL + 4

                    SessionButton {
                        id: sessionLock
                        focus: lockScreen.visible
                        iconName: "lock"
                        onClicked: {
                            console.log("Locking session");
                        }
                        KeyNavigation.right: sessionLogout
                        KeyNavigation.down: sessionShutdown
                    }
                    SessionButton {
                        id: sessionLogout
                        iconName: "logout"
                        onClicked: {
                            console.log("Logging out");
                        }
                        KeyNavigation.left: sessionLock
                        KeyNavigation.right: sessionHibernate
                        KeyNavigation.down: sessionReboot
                    }
                    SessionButton {
                        id: sessionHibernate
                        iconName: "downloading"
                        onClicked: {
                            console.log("Hibernating session");
                        }
                        KeyNavigation.left: sessionLogout
                        KeyNavigation.down: sessionFirmwareReboot
                    }
                    SessionButton {
                        id: sessionShutdown
                        iconName: "power_settings_new"
                        onClicked: {
                            console.log("Powering off");
                        }
                        KeyNavigation.right: sessionReboot
                        KeyNavigation.up: sessionLock
                    }
                    SessionButton {
                        id: sessionReboot
                        iconName: "restart_alt"
                        onClicked: {
                            console.log("Rebooting session");
                        }
                        KeyNavigation.left: sessionShutdown
                        KeyNavigation.right: sessionFirmwareReboot
                        KeyNavigation.up: sessionLogout
                    }
                    SessionButton {
                        id: sessionFirmwareReboot
                        iconName: "settings_applications"
                        onClicked: {
                            console.log("Reboot to firmware setting ");
                        }
                        KeyNavigation.left: sessionReboot
                        KeyNavigation.up: sessionHibernate
                    }
                }
            }
        }
    }

    function openLockScreen() {
        lockScreenLoader.active = true;
    }

    function closeLockScreen() {
        lockScreenLoader.active = false;
    }

    function toggleLockScreen() {
        lockScreenLoader.active = !lockScreenLoader.active;
    }

    IpcHandler {
        target: "lockScreen"

        function open(): void {
            root.openLockScreen();
        }

        function close(): void {
            root.closeLockScreen();
        }

        function toggle(): void {
            root.toggleLockScreen();
        }
    }

    GlobalShortcut {
        name: "sessionScreenOpen"
        description: "Open the session screen"

        onPressed: {
            root.openLockScreen();
        }
    }

    GlobalShortcut {
        name: "sessionScreenClose"
        description: "Close the session screen"

        onPressed: {
            root.closeLockScreen();
        }
    }

    GlobalShortcut {
        name: "sessionScreenToggle"
        description: "Toggle the session screen"

        onPressed: {
            root.toggleLockScreen();
        }
    }
}
