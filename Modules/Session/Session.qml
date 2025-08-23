pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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

    function closeSessionScreen() {
        sessionLoader.active = false;
    }

    function openSessionScreen() {
        sessionLoader.active = true;
    }

    function toggleSessionScreen() {
        sessionLoader.active = !sessionLoader.active;
    }

    Loader {
        id: sessionLoader

        active: false

        sourceComponent: PanelWindow {
            id: sessionRoot

            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.namespace: "quickshell:lockScreen"
            color: Qt.rgba(Theme.surfaceContainer.r, Theme.surfaceContainer.g,
                           Theme.surfaceContainer.b, Theme.opacityMedium)
            exclusionMode: ExclusionMode.Ignore
            implicitHeight: root.focusedScreen?.height ?? 0
            implicitWidth: root.focusedScreen?.width ?? 0
            visible: sessionLoader.active

            anchors {
                left: true
                right: true
                top: true
            }

            MouseArea {
                id: sessionMouseArea

                anchors.fill: parent

                onClicked: {
                    root.closeSessionScreen();
                }
            }

            ColumnLayout {
                id: sessionContent

                anchors.centerIn: parent
                spacing: Theme.spacingXL

                Keys.onPressed: event => {
                    if (event.key === Qt.Key_Escape) {
                        root.closeSessionScreen();
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

                        buttonIcon: "lock"
                        focus: sessionRoot.visible
                        onClicked: {
                            onClicked: {
                                Quickshell.execDetached(["loginctl", "lock-session"]);
                                root.closeSessionScreen();
                            }
                        }

                        KeyNavigation.down: sessionShutdown
                        KeyNavigation.right: sessionLogout
                    }

                    SessionButton {
                        id: sessionLogout

                        buttonIcon: "logout"
                        onClicked: {
                            onClicked: {
                                Quickshell.execDetached(["pkill", "Hyprland"]);
                                root.closeSessionScreen();
                            }
                        }

                        KeyNavigation.down: sessionReboot
                        KeyNavigation.left: sessionLock
                        KeyNavigation.right: sessionHibernate
                    }

                    SessionButton {
                        id: sessionHibernate

                        buttonIcon: "downloading"
                        onClicked: {
                            onClicked: {
                                Quickshell.execDetached(["bash", "-c",
                                                         `systemctl hibernate || loginctl hibernate`]);
                                root.closeSessionScreen();
                            }
                        }

                        KeyNavigation.down: sessionFirmwareReboot
                        KeyNavigation.left: sessionLogout
                    }

                    SessionButton {
                        id: sessionShutdown

                        buttonIcon: "power_settings_new"
                        onClicked: {
                            onClicked: {
                                Quickshell.execDetached(["bash", "-c",
                                                         `systemctl poweroff || loginctl poweroff`]);
                                root.closeSessionScreen();
                            }
                        }

                        KeyNavigation.right: sessionReboot
                        KeyNavigation.up: sessionLock
                    }

                    SessionButton {
                        id: sessionReboot

                        buttonIcon: "restart_alt"
                        onClicked: {
                            onClicked: {
                                Quickshell.execDetached(["bash", "-c",
                                                         `reboot || loginctl reboot`]);
                                root.closeSessionScreen();
                            }
                        }

                        KeyNavigation.left: sessionShutdown
                        KeyNavigation.right: sessionFirmwareReboot
                        KeyNavigation.up: sessionLogout
                    }

                    SessionButton {
                        id: sessionFirmwareReboot

                        buttonIcon: "settings_applications"
                        onClicked: {
                            onClicked: {
                                Quickshell.execDetached(["bash", "-c",
                                                         `systemctl reboot --firmware-setup || loginctl reboot --firmware-setup`]);
                                root.closeSessionScreen();
                            }
                        }

                        KeyNavigation.left: sessionReboot
                        KeyNavigation.up: sessionHibernate
                    }

                    // TODO: Add sleep button
                }
                // TODO: Add tooltip
            }
        }
    }

    IpcHandler {
        function close(): void {
            root.closeSessionScreen();
        }

        function open(): void {
            root.openSessionScreen();
        }

        function toggle(): void {
            root.toggleSessionScreen();
        }

        target: "session"
    }

    GlobalShortcut {
        description: "Open the session screen"
        name: "sessionScreenOpen"

        onPressed: {
            root.openSessionScreen();
        }
    }

    GlobalShortcut {
        description: "Close the session screen"
        name: "sessionScreenClose"

        onPressed: {
            root.closeSessionScreen();
        }
    }

    GlobalShortcut {
        description: "Toggle the session screen"
        name: "sessionScreenToggle"

        onPressed: {
            root.toggleSessionScreen();
        }
    }
}
