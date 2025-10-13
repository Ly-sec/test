import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets
import qs.Services

ColumnLayout {
    id: root
    
    property string pluginId: "example-plugin"
    
    spacing: Style.marginM * scaling
    
    // Auto-handles storage and provides saveValue/loadValue to children
    function saveValue(key, value) {
        if (!pluginId) return false
        
        try {
            if (!Settings.data.plugins) {
                Settings.data.plugins = {}
            }
            if (!Settings.data.plugins[pluginId]) {
                Settings.data.plugins[pluginId] = {}
            }
            
            Settings.data.plugins[pluginId][key] = value
            Logger.log("PluginSettings", `Saved ${pluginId}.${key} = ${value}`)
            return true
        } catch (e) {
            Logger.error("PluginSettings", `Failed to save ${pluginId}.${key}: ${e}`)
            return false
        }
    }
    
    function loadValue(key, defaultValue) {
        if (!pluginId) return defaultValue
        
        try {
            return Settings.data.plugins?.[pluginId]?.[key] ?? defaultValue
        } catch (e) {
            Logger.error("PluginSettings", `Failed to load ${pluginId}.${key}: ${e}`)
            return defaultValue
        }
    }
    
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
    
    // Custom Message Setting
    ColumnLayout {
        Layout.fillWidth: true
        spacing: Style.marginS * scaling
        
        NText {
            text: "Custom Message"
            font.pixelSize: Style.fontSizeM * scaling
            font.weight: Font.Medium
            color: Color.mOnSurface
        }
        
        NText {
            text: "The message to display when temperature is disabled"
            font.pixelSize: Style.fontSizeS * scaling
            color: Color.mOnSurfaceVariant
            wrapMode: Text.WordWrap
        }
        
        NTextInput {
            id: customMessageInput
            Layout.fillWidth: true
            placeholderText: "Enter custom message..."
            text: root.loadValue("customMessage", "Hello!")
            
            onTextChanged: {
                root.saveValue("customMessage", text)
            }
        }
    }
    
    // Show Temperature Setting
    RowLayout {
        Layout.fillWidth: true
        spacing: Style.marginM * scaling
        
        ColumnLayout {
            Layout.fillWidth: true
            spacing: Style.marginXS * scaling
            
            NText {
                text: "Show Temperature"
                font.pixelSize: Style.fontSizeM * scaling
                font.weight: Font.Medium
                color: Color.mOnSurface
            }
            
            NText {
                text: "Display random temperature instead of custom message"
                font.pixelSize: Style.fontSizeS * scaling
                color: Color.mOnSurfaceVariant
                wrapMode: Text.WordWrap
            }
        }
        
        NToggle {
            id: showTemperatureToggle
            checked: root.loadValue("showTemperature", true)
            
            onToggled: {
                root.saveValue("showTemperature", checked)
            }
        }
    }
    
    // Temperature Unit Setting
    RowLayout {
        Layout.fillWidth: true
        spacing: Style.marginM * scaling
        
        ColumnLayout {
            Layout.fillWidth: true
            spacing: Style.marginXS * scaling
            
            NText {
                text: "Temperature Unit"
                font.pixelSize: Style.fontSizeM * scaling
                font.weight: Font.Medium
                color: Color.mOnSurface
            }
            
            NText {
                text: "Choose between Celsius and Fahrenheit"
                font.pixelSize: Style.fontSizeS * scaling
                color: Color.mOnSurfaceVariant
                wrapMode: Text.WordWrap
            }
        }
        
        NComboBox {
            id: temperatureUnitCombo
            Layout.preferredWidth: 200 * scaling
            
            model: ["Celsius", "Fahrenheit"]
            currentIndex: root.loadValue("temperatureUnit", "celsius") === "celsius" ? 0 : 1
            
            onCurrentIndexChanged: {
                const value = currentIndex === 0 ? "celsius" : "fahrenheit"
                root.saveValue("temperatureUnit", value)
            }
        }
    }
    
    // Refresh Interval Setting
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