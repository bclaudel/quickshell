pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Widgets

import qs.Common
import qs.Widgets

Modal {
    id: root

    property bool spotlightOpen: false
    property Component spotlightContent

    function show() {
        spotlightOpen = true;
        open();
    }

    function hide() {
        spotlightOpen = false;
        close();
    }

    function toggle() {
        if (spotlightOpen) {
            show();
        } else {
            hide();
        }
    }

    width: 550
    height: 600
    content: spotlightContent
    onVisibleChanged: {
        if (visible && !spotlightOpen) {
            show();
        }
    }
    onBackgroundClicked: {
        hide();
    }

    spotlightContent: Component {
        Item {
            id: splotlightKeyHandler

            property alias appLauncher: appLauncher
            property alias searchField: searchField

            anchors.fill: parent
            focus: true
            Keys.onPressed: function (event) {
                if (event.key === Qt.Key_Escape) {
                    root.hide();
                    event.accepted = true;
                } else if (event.key === Qt.Key_Down) {
                    event.accepted = true;
                }
            }

            AppLauncher {
                id: appLauncher
            }

            Column {
                anchors.fill: parent
                anchors.margins: Theme.spacingL
                spacing: Theme.spacingL

                visible: appLauncher.model.count > 0

                Row {
                    width: parent.width
                    spacing: Theme.spacingM

                    TextField {
                        id: searchField

                        width: parent.width
                        height: 56
                        backgroundColor: Qt.rgba(Theme.surfaceVariant.r, Theme.surfaceVariant.g,
                                                 Theme.surfaceVariant.b,
                                                 Theme.getContentBackgroundAlpha() * 0.7)
                        normalBorderColor: Theme.outlineMedium
                        focusedBorderColor: Theme.primary
                        iconName: "search"
                        iconSize: Theme.iconSize
                        iconColor: Theme.surfaceVariantText
                        iconFocusedColor: Theme.primary

                        onTextEdited: {
                            appLauncher.searchQuery = searchField.text;
                        }
                    }
                }

                Rectangle {
                    id: resultsContainer

                    width: parent.width
                    height: parent.height - y
                    radius: Theme.cornerRadius
                    color: Theme.surfaceLight
                    border.color: Theme.outlineLight
                    border.width: 1

                    ListView {
                        id: resultsList

                        property int itemHeight: 60
                        property int iconSize: 40
                        property bool showDescription: true
                        property int itemSpacing: Theme.spacingS

                        signal itemClicked(int index, var modelData)

                        anchors.fill: parent
                        anchors.margins: Theme.spacingS
                        model: splotlightKeyHandler.appLauncher.model
                        clip: true
                        spacing: Theme.spacingS

                        onCurrentIndexChanged: {
                            console.log("Current index changed to", currentIndex);
                        }
                        onItemClicked: function (index, modelData) {
                            console.log("Item clicked:", modelData);
                        }

                        delegate: Rectangle {
                            id: item

                            required property int index
                            required property var model
                            required property string name
                            required property string icon

                            width: ListView.view.width
                            height: resultsList.itemHeight
                            radius: Theme.cornerRadius
                            color: ListView.isCurrentItem ? Theme.primaryPressed :
                                                            listMouseArea.containsMouse
                                                            ? Theme.primaryHoverLight : Qt.rgba(
                                                                  Theme.surfaceVariant.r,
                                                                  Theme.surfaceVariant.g,
                                                                  Theme.surfaceVariant.b, 0.03)
                            border.color: ListView.isCurrentItem ? Theme.primarySelected :
                                                                   Theme.outlineMedium
                            border.width: ListView.isCurrentItem ? 2 : 1

                            Row {
                                anchors.fill: parent
                                anchors.margins: Theme.spacingM
                                spacing: Theme.spacingL

                                Item {
                                    width: resultsList.iconSize
                                    height: resultsList.iconSize
                                    anchors.verticalCenter: parent.verticalCenter

                                    IconImage {
                                        id: listIconImg

                                        anchors.fill: parent
                                        source: item.icon ? Quickshell.iconPath(item.icon, "") : ""
                                        smooth: true
                                        visible: source !== "" && status === Image.Ready
                                    }
                                    Rectangle {
                                        anchors.fill: parent
                                        visible: !listIconImg.visible
                                        color: Theme.surfaceLight
                                        radius: Theme.cornerRadius
                                        border.color: Theme.primarySelected
                                        border.width: 1

                                        StyledText {
                                            anchors.centerIn: parent
                                            text: (item.name && item.name.length > 0) ? item.name.charAt(
                                                                                            0).toUpperCase(
                                                                                            ) : "?"
                                            font.pixelSize: resultsList.iconSize * 0.4
                                            font.weight: Font.Bold
                                            color: Theme.primary
                                        }
                                    }
                                }

                                Column {
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: parent.width - resultsList.iconSize - Theme.spacingL
                                    spacing: Theme.spacingXS

                                    StyledText {
                                        width: parent.width
                                        text: item.name || ""
                                        color: Theme.surfaceText
                                        font.pixelSize: Theme.fontSizeMedium
                                        font.weight: Font.Medium
                                        elide: Text.ElideRight
                                    }

                                    StyledText {
                                        width: parent.width
                                        text: item.model.comment || ""
                                        color: Theme.surfaceVariantText
                                        font.pixelSize: Theme.fontSizeMedium
                                        elide: Text.ElideRight
                                        visible: resultsList.showDescription && item.model.comment
                                                 !== ""
                                    }
                                }
                            }

                            MouseArea {
                                id: listMouseArea

                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor

                                onClicked: mouse => {
                                    if (mouse.button === Qt.LeftButton) {
                                        resultsList.itemClicked(item.index, item.model);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    GlobalShortcut {
        description: "Open the launcher modal"
        name: "openLauncherModal"

        onPressed: {
            root.open();
        }
    }
}
