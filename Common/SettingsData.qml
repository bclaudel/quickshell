pragma Singleton
pragma ComponentBehavior

import QtQuick
import Quickshell

Singleton {
    id: root

    property real hyprlandGapsOut: 5
    property int maxWorkspaces: 8
    property string networkPreference: "auto"
    property int themeIndex: 0
    property real topBarTransparency: 0.75
}
