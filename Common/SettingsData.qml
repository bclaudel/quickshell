pragma Singleton
pragma ComponentBehavior

import QtQuick
import Quickshell

Singleton {
    id: root

    property int themeIndex: 0
    property real hyprlandGapsOut: 5
    property int maxWorkspaces: 8
    property string networkPreference: "auto"
    property real topBarTransparency: 0.75
}
