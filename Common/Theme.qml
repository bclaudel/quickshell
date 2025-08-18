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
    property real fontSizeMedium: 14
    property real fontSizeLarge: 16
    property real fontSizeXLarge: 20
    property real barHeight: 48
    property real iconSize: 24
    property real iconSizeSmall: 16
    property real iconSizeLarge: 32
    property real opacityDisabled: 0.38
    property real opacityMedium: 0.6
    property real opacityHigh: 0.87
    property real opacityFull: 1
    property real panelTransparency: 0.85
    property real widgetTransparency: 0.85
    property real popupTransparency: 0.92

    property int currentThemeIndex: 0
    property color primary: getCurrentTheme().primary
    property color primaryText: getCurrentTheme().primaryText
    property color primaryContainer: getCurrentTheme().primaryContainer
    property color secondary: getCurrentTheme().secondary
    property color surface: getCurrentTheme().surface
    property color surfaceText: getCurrentTheme().surfaceText
    property color surfaceVariant: getCurrentTheme().surfaceVariant
    property color outline: getCurrentTheme().outline
    property color surfaceContainer: getCurrentTheme().surfaceContainer
    property color surfaceContainerHigh: getCurrentTheme().surfaceContainerHigh

    property color archBlue: "#1793D1"
    property color success: "#4CAF50"
    property color warning: "#FF9800"
    property color info: "#2196F3"
    property color error: "#F2B8B5"

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

    property color outlineLight: Qt.rgba(outline.r, outline.g, outline.b, 0.05)
    property color outlineMedium: Qt.rgba(outline.r, outline.g, outline.b, 0.08)
    property color outlineStrong: Qt.rgba(outline.r, outline.g, outline.b, 0.12)
    property color outlineSelected: Qt.rgba(outline.r, outline.g, outline.b, 0.2)
    property color outlineHeavy: Qt.rgba(outline.r, outline.g, outline.b, 0.3)
    property color outlineButton: Qt.rgba(outline.r, outline.g, outline.b, 0.5)

    property color errorHover: Qt.rgba(error.r, error.g, error.b, 0.12)
    property color errorPressed: Qt.rgba(error.r, error.g, error.b, 0.9)

    property color warningHover: Qt.rgba(warning.r, warning.g, warning.b, 0.12)

    function getCurrentTheme() {
        return themes[currentThemeIndex];
    }
}
