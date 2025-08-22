import QtQuick

import Quickshell
import Quickshell.Wayland

import qs.Common

PanelWindow {
    id: root

    property alias content: contentLoader.sourceComponent
    property alias contentLoader: contentLoader

    property real height: 300
    property real width: 400
    property string positioning: "center"
    property color backgroundColor: Theme.surfaceVariant
    property color borderColor: Theme.outlineMedium
    property real borderWidth: 1
    property real cornerRadius: Theme.cornerRadius

    signal backgroundClicked

    function close() {
        visible = false;
    }

    function open() {
        visible = true;
        focusScope.forceActiveFocus();
    }

    function toggle() {
        visible = !visible;
    }

    color: "transparent"
    visible: false

    WlrLayershell.exclusiveZone: -1
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    Rectangle {
        id: background

        anchors.fill: parent
        color: Qt.rgba(Theme.surfaceContainer.r, Theme.surfaceContainer.g, Theme.surfaceContainer.b,
                       Theme.opacityMedium)

        MouseArea {
            anchors.fill: parent
            enabled: root.visible

            onClicked: mouse => {
                           var localPos = mapToItem(content, mouse.x, mouse.y);

                           // Check if the clik is outside the content area
                           if (localPos.x < 0 || localPos.x > content.width || localPos.y < 0
                               || localPos.y > content.height) {
                               root.backgroundClicked();
                           }
                       }
        }
    }

    Rectangle {
        id: content

        height: root.height
        width: root.width
        anchors.centerIn: root.positioning === "center" ? parent : undefined

        color: root.backgroundColor
        radius: root.cornerRadius
        border.color: root.borderColor
        border.width: root.borderWidth

        Loader {
            id: contentLoader

            anchors.fill: parent
            active: root.visible
            asynchronous: false
        }
    }

    FocusScope {
        id: focusScope

        anchors.fill: parent
        focus: root.visible
        visible: root.visible

        Keys.onEscapePressed: event => {
                                  root.close();
                              }
    }
}
