import QtQuick

import qs.Common

Text {
    id: root

    verticalAlignment: Text.AlignVCenter
    color: Theme.surfaceText
    font.family: SettingsData.fontFamily
    font.pixelSize: 14
    font.weight: Font.Normal
    antialiasing: true
    wrapMode: Text.WordWrap
    elide: Text.ElideRight
}
