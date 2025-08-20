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

        sourceComponent: Component {
            Rectangle {
                id: controlCenterBackground
                anchors.fill: parent
                radius: Theme.cornerRadius
                color: Theme.popupBackground()

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: Theme.spacingL
                    spacing: Theme.spacingM

                    Column {
                        width: parent.width
                        spacing: Theme.spacingM

                        Rectangle {
                            width: parent.width
                            height: 90
                            radius: Theme.cornerRadius
                            color: Qt.rgba(Theme.surfaceVariant.r, Theme.surfaceVariant.g, Theme.surfaceVariant.b, Theme.getContentBackgroundAlpha() * 0.4)
                            border.color: Qt.rgba(Theme.outline.r, Theme.outline.g, Theme.outline.b, 0.08)
                            border.width: 1

                            Row {
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.leftMargin: Theme.spacingL
                                anchors.rightMargin: Theme.spacingL
                                spacing: Theme.spacingL

                                Item {
                                    id: avatarContainer

                                    width: 64
                                    height: 64

                                    Rectangle {
                                        anchors.fill: parent
                                        radius: width / 2
                                        color: "transparent"
                                        border.color: Theme.primary
                                        border.width: 1
                                        visible: true
                                    }
                                }

                                Column {
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: Theme.spacingXS

                                    StyledText {
                                        text: "Ekko"
                                        color: Theme.surfaceText
                                        font.pixelSize: Theme.fontSizeLarge
                                        font.weight: Font.Medium
                                    }

                                    StyledText {
                                        text: "Unknown"
                                        color: Theme.surfaceText
                                        font.pixelSize: Theme.fontSizeSmall
                                        font.weight: Font.Normal
                                    }
                                }
                            }

                            Row {
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.rightMargin: Theme.spacingL
                                spacing: Theme.spacingS

                                MaterialButton {
                                      buttonSize: 40
                                  iconName: "restart_alt"
                                  iconSize: Theme.iconSize
                                  iconColor: Theme.surfaceText
                                }

                                MaterialButton {
                                  buttonSize: 40
                                  iconName: "settings"
                                  iconSize: Theme.iconSize
                                  iconColor: Theme.surfaceText
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
