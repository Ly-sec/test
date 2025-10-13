import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

ColumnLayout {
  spacing: Style.marginL * scaling
  
  NText {
    text: "Example Plugin Settings"
    font.pixelSize: 16 * scaling
    font.weight: Font.Bold
    color: Color.mOnSurface
  }
  
  NSpinBox {
    label: "Refresh Interval (seconds)"
    value: Settings.data.plugins.examplePlugin?.refreshInterval || 30
    from: 5
    to: 300
    onValueChanged: {
      if (!Settings.data.plugins.examplePlugin) {
        Settings.data.plugins.examplePlugin = {}
      }
      Settings.data.plugins.examplePlugin.refreshInterval = value
    }
  }
  
  NToggle {
    label: "Show Temperature"
    checked: Settings.data.plugins.examplePlugin?.showTemperature !== false
    onToggled: {
      if (!Settings.data.plugins.examplePlugin) {
        Settings.data.plugins.examplePlugin = {}
      }
      Settings.data.plugins.examplePlugin.showTemperature = checked
    }
  }
  
  NComboBox {
    label: "Temperature Unit"
    model: [
      { key: "celsius", text: "Celsius" },
      { key: "fahrenheit", text: "Fahrenheit" }
    ]
    currentKey: Settings.data.plugins.examplePlugin?.temperatureUnit || "celsius"
    onSelected: {
      if (!Settings.data.plugins.examplePlugin) {
        Settings.data.plugins.examplePlugin = {}
      }
      Settings.data.plugins.examplePlugin.temperatureUnit = key
    }
  }
  
  NTextInput {
    label: "Custom Message"
    text: Settings.data.plugins.examplePlugin?.customMessage || "Hello!"
    placeholderText: "Enter a custom message..."
    onTextChanged: {
      if (!Settings.data.plugins.examplePlugin) {
        Settings.data.plugins.examplePlugin = {}
      }
      Settings.data.plugins.examplePlugin.customMessage = text
    }
  }
}
