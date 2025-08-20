import QtQuick

import qs.Common
import qs.Widgets

RippleButton {
    id: button

    property string buttonIcon
    property string buttonText
    property real size: 120

    buttonHeight: size
    buttonWidth: size
    backgroundColor: (button.focus || button.down) ? Theme.secondary : Theme.surfaceVariant

    Keys.onPressed: event => {
        if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
            button.clicked();
        }
    }

    contentItem: MaterialIcon {
        id: icon
        size: 45
        name: button.buttonIcon
    }
}
