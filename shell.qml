import QtQuick
import Quickshell

import qs.Modules.TopBar
import qs.Modules.ControlCenter
import qs.Modules.Session

ShellRoot {
    TopBar {}

    LazyLoader {
        loading: true
        component: ControlCenter {}
    }

    LazyLoader {
        active: true
        component: Session {}
    }
}
