pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

import qs.Common
import qs.Widgets

Modal {
    id: root

    property bool spotlightOpen: false
    property Component spotlightContent

    function show() {
        spotlightOpen = true;
        open();
    }

    function hide() {
        spotlightOpen = false;
        close();
    }

    function toggle() {
        if (spotlightOpen) {
            show();
        } else {
            hide();
        }
    }

    width: 550
    height: 600
    content: spotlightContent
    onVisibleChanged: {
        if (visible && !spotlightOpen) {
            show();
        }
    }
    onBackgroundClicked: {
        hide();
    }

    spotlightContent: Component {
        Item {
            id: splotlightKeyHandler

            property alias appLauncher: appLauncher
            property alias searchField: searchField

            anchors.fill: parent
            focus: true
            Keys.onPressed: function (event) {
                if (event.key === Qt.Key_Escape) {
                    root.hide();
                    event.accepted = true;
                } else if (event.key === Qt.Key_Down) {
                    event.accepted = true;
                }
            }

            AppLauncher {
                id: appLauncher
            }

            Column {
                anchors.fill: parent
                anchors.margins: Theme.spacingL
                spacing: Theme.spacingL

                Row {
                    width: parent.width
                    spacing: Theme.spacingM

                    TextField {
                        id: searchField

                        width: parent.width - 80 - Theme.spacingM
                        height: 56
                        backgroundColor: Qt.rgba(Theme.surfaceVariant.r, Theme.surfaceVariant.g,
                                                 Theme.surfaceVariant.b,
                                                 Theme.getContentBackgroundAlpha() * 0.7)
                        normalBorderColor: Theme.outlineMedium
                        focusedBorderColor: Theme.primary
                        iconName: "search"
                        iconSize: Theme.iconSize
                        iconColor: Theme.surfaceVariantText
                        iconFocusedColor: Theme.primary

                        onTextEdited: {
                            console.log("Search query:", searchField.text);
                            appLauncher.searchQuery = searchField.text;
                        }
                    }
                }
            }
        }
    }

    GlobalShortcut {
        description: "Open the launcher modal"
        name: "openLauncherModal"

        onPressed: {
            root.open();
        }
    }
}
