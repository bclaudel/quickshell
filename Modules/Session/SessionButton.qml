import QtQuick

import qs.Common
import qs.Widgets

MaterialButton {
    id: button

    buttonSize: 120
    iconSize: 45
    radius: Theme.cornerRadius
    backgroundColor: (button.focus || button.down) ? Theme.secondary : Theme.surfaceVariant
}
