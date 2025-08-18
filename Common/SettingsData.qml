pragma Singleton
pragma ComponentBehavior

import QtQuick
import Quickshell

Singleton {
    id: root

    property int themeIndex: 0
    property int maxWorkspaces: 8
    property real topBarTransparency: 0.75

    property string networkPreference: "auto"
}
