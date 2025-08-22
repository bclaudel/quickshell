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
        console.log("Launcher opened");
        console.log(contentLoader.status);
        console.log(contentLoader.item);
    }

    function hide() {
        spotlightOpen = false;
        close();
        console.log("Launcher closed");
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
        console.log("Launcher visibility changed: " + visible);
        if (visible && !spotlightOpen) {
            show();
        }
    }
    onBackgroundClicked: {
        hide();
    }

    spotlightContent: Component {
        Item {
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: 100
                height: 100
                color: "red"
            }

            AppLauncher {
                id: appLauncher
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
