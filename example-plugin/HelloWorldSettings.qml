import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Commons
import qs.Widgets
import qs.Modules.Plugins

PluginSettings {
  id: root
  pluginId: "helloWorld"

  ColumnLayout {
    width: parent.width
    spacing: Style.marginL * scaling

    NText {
      text: "Hello World Plugin Settings"
      pointSize: Style.fontSizeXL * scaling
      font.weight: Style.fontWeightBold
      color: Color.mPrimary
    }

    NText {
      text: "Configure the appearance and behavior of the Hello World plugin."
      pointSize: Style.fontSizeM * scaling
      color: Color.mOnSurfaceVariant
      wrapMode: Text.WordWrap
    }

    NDivider {
      Layout.fillWidth: true
    }

    StringSetting {
      settingKey: "displayText"
      label: "Display Text"
      description: "Text shown in the bar widget"
      placeholder: "Hello World"
      defaultValue: "Hello World"
    }

    ToggleSetting {
      settingKey: "showIcon"
      label: "Show Icon"
      description: "Display an icon next to the text"
      defaultValue: true
    }

    NDivider {
      Layout.fillWidth: true
    }

    NText {
      text: "Statistics"
      pointSize: Style.fontSizeL * scaling
      font.weight: Style.fontWeightBold
      color: Color.mPrimary
    }

    RowLayout {
      Layout.fillWidth: true
      spacing: Style.marginM * scaling

      NText {
        text: "Click Count:"
        pointSize: Style.fontSizeM * scaling
        color: Color.mOnSurface
      }

      NText {
        text: getSetting("clickCount", 0)
        pointSize: Style.fontSizeM * scaling
        font.weight: Style.fontWeightBold
        color: Color.mPrimary
      }

      Item {
        Layout.fillWidth: true
      }

      NButton {
        text: "Reset"
        onClicked: {
          saveSetting("clickCount", 0)
        }
      }
    }

    Item {
      Layout.fillHeight: true
    }

    NText {
      text: "This plugin demonstrates the plugin system capabilities including settings persistence, bar integration, and popout windows."
      pointSize: Style.fontSizeS * scaling
      color: Color.mOnSurfaceVariant
      wrapMode: Text.WordWrap
      Layout.fillWidth: true
    }
  }
}
