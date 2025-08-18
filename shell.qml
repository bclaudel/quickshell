import QtQuick
import Quickshell

import qs.Modules.TopBar
import qs.Modules.ControlCenter

ShellRoot {
    TopBar {}

    LazyLoader {
        loading: true
        component: ControlCenter {}
    }
}
