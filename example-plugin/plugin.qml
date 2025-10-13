import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

// Simple Example Plugin - Works like a bar widget
Rectangle {
    id: root
    
    // Standard widget properties (like bar widgets)
    property ShellScreen screen
    property real scaling: 1.0
    property string widgetId: "example-plugin"
    property string section: ""
    property int sectionWidgetIndex: -1
    
    // Plugin settings (stored in Settings.data.plugins.examplePlugin)
    property bool showTemperature: Settings.data.plugins.examplePlugin?.showTemperature !== false
    property string temperatureUnit: Settings.data.plugins.examplePlugin?.temperatureUnit || "celsius"
    property string customMessage: Settings.data.plugins.examplePlugin?.customMessage || "Hello!"
    property int refreshInterval: Settings.data.plugins.examplePlugin?.refreshInterval || 30
    
    // Widget dimensions
    implicitWidth: 120 * scaling
    implicitHeight: Style.capsuleHeight * scaling
    radius: Style.radiusM * scaling
    color: Color.mSurfaceVariant
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 2 * scaling
        
        NText {
            text: "Example"
            font.pixelSize: 10 * scaling
            font.weight: Font.Bold
            color: Color.mPrimary
            horizontalAlignment: Text.AlignHCenter
        }
        
        NText {
            text: showTemperature ? 
                  `${Math.floor(Math.random() * 30 + 10)}°${temperatureUnit === "celsius" ? "C" : "F"}` : 
                  customMessage
            font.pixelSize: 9 * scaling
            color: Color.mOnSurfaceVariant
            horizontalAlignment: Text.AlignHCenter
        }
    }
    
    // Auto-refresh timer
    Timer {
        interval: refreshInterval * 1000
        repeat: true
        running: true
        onTriggered: {
            // Trigger repaint
            root.visible = false
            root.visible = true
        }
    }
}
