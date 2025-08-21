import QtQuick
import Quickshell
import qs.Modules.ControlCenter
import qs.Modules.Session
import qs.Modules.TopBar

ShellRoot {
    TopBar {
    }

    LazyLoader {
        loading: true

        component: ControlCenter {
        }
    }

    LazyLoader {
        active: true

        component: Session {
        }
    }
}
