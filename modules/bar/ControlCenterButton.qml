import QtQuick

import qs.common
import qs.widgets

Rectangle {
    id: root

    height: 30
    width: controlCenterRow.width + 2 * Theme.spacingM
    radius: Theme.cornerRadius
    color: {
        const baseColor = Theme.surfaceTextHover;
        return Qt.rgba(baseColor.r, baseColor.g, baseColor.b, baseColor.a * Theme.widgetTransparency);
    }
    anchors.verticalCenter: parent.verticalCenter

    function getWifiSignalIcon(signalStrengh) {
        return "signal_wifi_4_bar";
    }

    Row {
        id: controlCenterRow

        anchors.centerIn: parent
        spacing: Theme.spacingS

        MaterialIcon {
            text: "signal_wifi_4_bar"
        }
    }
}
