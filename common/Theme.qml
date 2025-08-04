pragma Singleton
pragma ComponentBehavior
import QtQuick
import Quickshell

Singleton {
    id: root

    property var themes: [
        {
            "name": "Blue",
            "primary": "#42a5f5",
            "primaryText": "#ffffff",
            "primaryContainer": "#1976d2",
            "secondary": "#8ab4f8",
            "surface": "#1a1c1e",
            "surfaceText": "#e3e8ef",
            "surfaceVariant": "#44464f",
            "surfaceVariantText": "#c4c7c5",
            "surfaceTint": "#8ab4f8",
            "background": "#1a1c1e",
            "backgroundText": "#e3e8ef",
            "outline": "#8e918f",
            "surfaceContainer": "#1e2023",
            "surfaceContainerHigh": "#292b2f"
        }
    ]

    property real cornerRadius: 12
    property real spacingXS: 4
    property real spacingS: 8
    property real spacingM: 12
    property real spacingL: 16
    property real spacingXL: 24
    property real fontSizeSmall: 12
    property real barHeight: 48
    property real panelTransparency: 0.85
    property real widgetTransparency: 0.85
    property real popupTransparency: 0.92

    property int currentThemeIndex: 0
    property color primary: getCurrentTheme().primary
    property color secondary: getCurrentTheme().secondary
    property color surface: getCurrentTheme().surface
    property color surfaceText: getCurrentTheme().surfaceText
    property color surfaceVariant: getCurrentTheme().surfaceVariant
    property color surfaceContainer: getCurrentTheme().surfaceContainer
    property color surfaceContainerHigh: getCurrentTheme().surfaceContainerHigh

    // Temperature-specific colors
    property color tempWarning: "#ff9933" // Balanced orange for warm temperatures
    property color tempDanger: "#ff5555" // Balanced red for dangerous temperatures

    property color primaryHover: Qt.rgba(primary.r, primary.g, primary.b, 0.12)
    property color primaryHoverLight: Qt.rgba(primary.r, primary.g, primary.b, 0.08)
    property color primaryPressed: Qt.rgba(primary.r, primary.g, primary.b, 0.16)
    property color primarySelected: Qt.rgba(primary.r, primary.g, primary.b, 0.3)
    property color primaryBackground: Qt.rgba(primary.r, primary.g, primary.b, 0.04)

    property color secondaryHover: Qt.rgba(secondary.r, secondary.g, secondary.b, 0.08)

    property color surfaceHover: Qt.rgba(surfaceVariant.r, surfaceVariant.g, surfaceVariant.b, 0.08)
    property color surfacePressed: Qt.rgba(surfaceVariant.r, surfaceVariant.g, surfaceVariant.b, 0.12)
    property color surfaceSelected: Qt.rgba(surfaceVariant.r, surfaceVariant.g, surfaceVariant.b, 0.15)
    property color surfaceLight: Qt.rgba(surfaceVariant.r, surfaceVariant.g, surfaceVariant.b, 0.1)
    property color surfaceVariantAlpha: Qt.rgba(surfaceVariant.r, surfaceVariant.g, surfaceVariant.b, 0.2)
    property color surfaceTextHover: Qt.rgba(surfaceText.r, surfaceText.g, surfaceText.b, 0.08)
    property color surfaceTextPressed: Qt.rgba(surfaceText.r, surfaceText.g, surfaceText.b, 0.12)
    property color surfaceTextAlpha: Qt.rgba(surfaceText.r, surfaceText.g, surfaceText.b, 0.3)
    property color surfaceTextLight: Qt.rgba(surfaceText.r, surfaceText.g, surfaceText.b, 0.06)
    property color surfaceTextMedium: Qt.rgba(surfaceText.r, surfaceText.g, surfaceText.b, 0.7)

    function getCurrentTheme() {
        return themes[currentThemeIndex];
    }
}
