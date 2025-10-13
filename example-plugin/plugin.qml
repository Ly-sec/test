import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets
import qs.Modules.Plugins

// Example Plugin using PluginComponent wrapper
PluginComponent {
    id: root
    
    // Plugin settings (stored in Settings.data.plugins.examplePlugin)
    property bool showTemperature: Settings.data.plugins.examplePlugin?.showTemperature !== false
    property string temperatureUnit: Settings.data.plugins.examplePlugin?.temperatureUnit || "celsius"
    property string customMessage: Settings.data.plugins.examplePlugin?.customMessage || "Hello!"
    property int refreshInterval: Settings.data.plugins.examplePlugin?.refreshInterval || 30
    
    // Horizontal bar pill (for top/bottom bars)
    horizontalBarPill: Component {
        NBox {
            width: content.implicitWidth + Style.marginM * scaling * 2
            height: parent.widgetThickness
            radius: Style.radiusM * scaling
            color: Color.mSurfaceVariant
            
            RowLayout {
                id: content
                anchors.centerIn: parent
                spacing: Style.marginS * scaling
                
                NText {
                    text: "Example"
                    font.pixelSize: 10 * scaling
                    font.weight: Font.Bold
                    color: Color.mPrimary
                }
                
                NText {
                    text: showTemperature ? 
                          `${Math.floor(Math.random() * 30 + 10)}°${temperatureUnit === "celsius" ? "C" : "F"}` : 
                          customMessage
                    font.pixelSize: 9 * scaling
                    color: Color.mOnSurfaceVariant
                }
            }
        }
    }
    
    // Vertical bar pill (for left/right bars)
    verticalBarPill: Component {
        NBox {
            width: parent.widgetThickness
            height: content.implicitHeight + Style.marginM * scaling * 2
            radius: Style.radiusM * scaling
            color: Color.mSurfaceVariant
            
            ColumnLayout {
                id: content
                anchors.centerIn: parent
                spacing: Style.marginXS * scaling
                
                NText {
                    text: "Example"
                    font.pixelSize: 8 * scaling
                    font.weight: Font.Bold
                    color: Color.mPrimary
                    rotation: 90
                }
                
                NText {
                    text: showTemperature ? 
                          `${Math.floor(Math.random() * 30 + 10)}°` : 
                          customMessage.substring(0, 3)
                    font.pixelSize: 7 * scaling
                    color: Color.mOnSurfaceVariant
                    rotation: 90
                }
            }
        }
    }
    
    // Popout content (optional)
    popoutContent: Component {
        PopoutComponent {
            headerText: "Example Plugin"
            detailsText: "This is an example plugin showing how to create custom widgets"
            showCloseButton: true
            
            ColumnLayout {
                width: parent.width
                spacing: Style.marginM * scaling
                
                NText {
                    text: "Plugin Information"
                    font.pixelSize: Style.fontSizeL * scaling
                    font.weight: Font.Bold
                    color: Color.mOnSurface
                }
                
                NText {
                    text: `Temperature: ${showTemperature ? "Enabled" : "Disabled"}`
                    font.pixelSize: Style.fontSizeM * scaling
                    color: Color.mOnSurfaceVariant
                }
                
                NText {
                    text: `Unit: ${temperatureUnit === "celsius" ? "Celsius" : "Fahrenheit"}`
                    font.pixelSize: Style.fontSizeM * scaling
                    color: Color.mOnSurfaceVariant
                }
                
                NText {
                    text: `Custom Message: ${customMessage}`
                    font.pixelSize: Style.fontSizeM * scaling
                    color: Color.mOnSurfaceVariant
                }
                
                NText {
                    text: `Refresh Interval: ${refreshInterval} seconds`
                    font.pixelSize: Style.fontSizeM * scaling
                    color: Color.mOnSurfaceVariant
                }
            }
        }
    }
    
    // Popout dimensions
    popoutWidth: 300
    popoutHeight: 250
    
    // Auto-refresh timer
    Timer {
        interval: refreshInterval * 1000
        repeat: true
        running: true
        onTriggered: {
            // Trigger repaint by updating a property
            root.showTemperature = root.showTemperature
        }
    }
}
