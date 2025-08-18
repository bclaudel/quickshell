import QtQuick

import qs.common
import qs.widgets
import qs.services

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

    function getWifiSignalIcon(signalStrength) {
        switch (signalStrength) {
        case "excellent":
            return "wifi";
        case "good":
            return "wifi_2_bar";
        case "fair":
            return "wifi_1_bar";
        case "poor":
            return "signal_wifi_0_bar";
        default:
            return "wifi";
        }
    }

    Row {
        id: controlCenterRow

        anchors.centerIn: parent
        spacing: Theme.spacingM

        MaterialIcon {
            name: "notifications"
            size: Theme.iconSize - 4
            color: Theme.surfaceText
        }

        MaterialIcon {
            name: "bluetooth"
            size: Theme.iconSize - 4
            color: Theme.surfaceText
        }

        MaterialIcon {
            name: {
                if (NetworkService.networkStatus === "ethernet")
                    return "lan";
                if (NetworkService.networkStatus === "wifi")
                    return getWifiSignalIcon(NetworkService.wifiSignalStrengthStr);
                else
                    "wifi_off";
            }
            size: Theme.iconSize - 4
            color: NetworkService.networkStatus !== "disconnected" ? Theme.surfaceText : Theme.outlineButton
        }
    }
}
