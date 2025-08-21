import QtQuick

import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root

    property real height: 300
    property real width: 400

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

    WlrLayershell.exclusiveZone: -1
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    WlrLayershell.layer: WlrLayershell.Overlay
    color: "transparent"
    visible: false

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    Rectangle {
        id: background

        anchors.fill: parent
        color: "black"
        opacity: 0
        visible: root.visible

        MouseArea {
            anchors.fill: parent
            enabled: root.visible

            onClicked: mouse => {
                           var localPos = mapToItem(content, mouse.x, mouse.y);

                           // Check if the clik is outside the content area
                           if (localPos.x < 0 || localPos.x > content.width || localPos.y < 0
                               || localPos.y > content.height) {
                               console.log("Clicked outside modal content");
                               root.backgroundClicked();
                           }
                       }
        }
    }

    Rectangle {
        id: content

        color: "white"
        height: root.height
        width: root.width
    }

    FocusScope {
        id: focusScope

        anchors.fill: parent
        focus: root.visible
        visible: root.visible

        Keys.onEscapePressed: event => {
                                  console.log("Key pressed in modal:", event.key);
                                  root.close();
                              }
    }
}
