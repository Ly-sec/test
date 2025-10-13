import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets
import qs.Modules.Plugins

PluginSettings {
    id: root
    pluginId: "example-plugin"
    
    spacing: Style.marginM * scaling
    
    NText {
        text: "Example Plugin Settings"
        font.pixelSize: Style.fontSizeL * scaling
        font.weight: Font.Bold
        color: Color.mOnSurface
        Layout.fillWidth: true
    }
    
    NDivider {
        Layout.fillWidth: true
    }
    
    StringSetting {
        settingKey: "customMessage"
        label: "Custom Message"
        description: "The message to display when temperature is disabled"
        placeholder: "Enter custom message..."
        defaultValue: "Hello!"
    }
    
    ToggleSetting {
        settingKey: "showTemperature"
        label: "Show Temperature"
        description: "Display random temperature instead of custom message"
        defaultValue: true
    }
    
    SelectionSetting {
        settingKey: "temperatureUnit"
        label: "Temperature Unit"
        description: "Choose between Celsius and Fahrenheit"
        options: [
            {label: "Celsius", value: "celsius"},
            {label: "Fahrenheit", value: "fahrenheit"}
        ]
        defaultValue: "celsius"
    }
    
    // Custom slider for refresh interval
    ColumnLayout {
        Layout.fillWidth: true
        spacing: Style.marginS * scaling
        
        NText {
            text: "Refresh Interval"
            font.pixelSize: Style.fontSizeM * scaling
            font.weight: Font.Medium
            color: Color.mOnSurface
        }
        
        NText {
            text: "How often to update the display (in seconds)"
            font.pixelSize: Style.fontSizeS * scaling
            color: Color.mOnSurfaceVariant
            wrapMode: Text.WordWrap
        }
        
        RowLayout {
            Layout.fillWidth: true
            spacing: Style.marginM * scaling
            
            NSlider {
                id: intervalSlider
                Layout.fillWidth: true
                from: 5
                to: 60
                stepSize: 5
                value: root.loadValue("refreshInterval", 30)
                
                onValueChanged: {
                    root.saveValue("refreshInterval", Math.round(value))
                }
            }
            
            NText {
                text: `${Math.round(intervalSlider.value)}s`
                font.pixelSize: Style.fontSizeM * scaling
                color: Color.mOnSurfaceVariant
                Layout.preferredWidth: 30 * scaling
            }
        }
    }
}