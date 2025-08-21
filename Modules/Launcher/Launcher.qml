import QtQuick
import QtQuick.Controls

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

import qs.Common
import qs.Widgets

Modal {
    id: launcherModal

    function show() {
        console.log("Launcher opened");
        open();
    }

    GlobalShortcut {
        description: "Open the launcher modal"
        name: "openLauncherModal"

        onPressed: {
            launcherModal.open();
        }
    }
}
