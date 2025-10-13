# Simple Plugin Guide

Creating plugins for Noctalia is **super easy**! Just follow this simple pattern.

## Plugin Structure

```
Modules/Plugins/YourPlugin/
├── meta.json      # Plugin info
├── plugin.qml     # Your widget (like a bar widget)
└── Settings.qml   # Settings form (optional)
```

## 1. Create meta.json

```json
{
  "id": "my-widget",
  "name": "My Cool Widget", 
  "description": "Shows cool stuff",
  "author": "Your Name",
  "version": "1.0.0",
  "type": "ui-component"
}
```

## 2. Create plugin.qml

Just make a widget like any bar widget! Here's a simple example:

```qml
import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

Rectangle {
    id: root
    
    // Standard properties (like bar widgets)
    property ShellScreen screen
    property real scaling: 1.0
    property string widgetId: "my-widget"
    
    // Your settings (stored in Settings.data.plugins.myWidget)
    property string customText: Settings.data.plugins.myWidget?.text || "Hello!"
    property int refreshRate: Settings.data.plugins.myWidget?.refreshRate || 1000
    
    // Widget size
    implicitWidth: 100 * scaling
    implicitHeight: Style.capsuleHeight * scaling
    radius: Style.radiusM * scaling
    color: Color.mSurfaceVariant
    
    // Your content
    NText {
        anchors.centerIn: parent
        text: customText
        font.pixelSize: 12 * scaling
        color: Color.mOnSurface
    }
    
    // Auto-refresh
    Timer {
        interval: refreshRate
        repeat: true
        running: true
        onTriggered: {
            // Update your widget here
            root.visible = false
            root.visible = true
        }
    }
}
```

## 3. Create Settings.qml (optional)

If you want settings, just make a simple form:

```qml
import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

ColumnLayout {
  spacing: Style.marginL * scaling
  
  NText {
    text: "My Widget Settings"
    font.pixelSize: 16 * scaling
    font.weight: Font.Bold
  }
  
  NTextInput {
    label: "Custom Text"
    text: Settings.data.plugins.myWidget?.text || "Hello!"
    onTextChanged: {
      if (!Settings.data.plugins.myWidget) {
        Settings.data.plugins.myWidget = {}
      }
      Settings.data.plugins.myWidget.text = text
    }
  }
  
  NSpinBox {
    label: "Refresh Rate (ms)"
    value: Settings.data.plugins.myWidget?.refreshRate || 1000
    from: 100
    to: 10000
    onValueChanged: {
      if (!Settings.data.plugins.myWidget) {
        Settings.data.plugins.myWidget = {}
      }
      Settings.data.plugins.myWidget.refreshRate = value
    }
  }
}
```

## That's it!

- **Settings**: Use `Settings.data.plugins.yourPluginId.propertyName`
- **Widget**: Make it like any bar widget with `implicitWidth`, `implicitHeight`, etc.
- **Styling**: Use `Color.mSurface`, `Style.radiusM`, `scaling` like normal widgets

## Plugin Types

- **UI Component**: Shows info (like the example above)
- **Bar Widget**: Can be added to bars (same as above, just smaller)
- **Settings Tab**: Adds a tab to settings (just Settings.qml)

## Example

See `Modules/Plugins/example-plugin/` for a working example!

**It's really that simple!** 🎉

