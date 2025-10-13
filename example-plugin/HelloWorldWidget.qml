import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Commons
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
  id: root

  // Plugin properties
  property string displayText: getSetting("displayText", "Hello World")
  property bool showIcon: getSetting("showIcon", true)
  property int clickCount: getSetting("clickCount", 0)

  // Horizontal bar pill (for top/bottom bars)
  horizontalBarPill: Component {
    Rectangle {
      width: contentRow.implicitWidth + Style.marginM * scaling * 2
      height: parent.widgetThickness
      radius: Style.radiusM * scaling
      color: Color.mSurfaceContainerHigh
      border.color: Color.mOutline
      border.width: Math.max(1, Style.borderS * scaling)

      Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: Style.marginS * scaling

        NIcon {
          icon: "extension"
          color: Color.mPrimary
          pointSize: Style.fontSizeM * scaling
          visible: root.showIcon
        }

        NText {
          text: root.displayText
          color: Color.mOnSurface
          pointSize: Style.fontSizeM * scaling
          font.weight: Style.fontWeightMedium
        }
      }

      MouseArea {
        anchors.fill: parent
        onClicked: {
          root.clickCount++
          root.saveSetting("clickCount", root.clickCount)
        }
      }
    }
  }

  // Vertical bar pill (for left/right bars)
  verticalBarPill: Component {
    Rectangle {
      width: parent.widgetThickness
      height: contentColumn.implicitHeight + Style.marginM * scaling * 2
      radius: Style.radiusM * scaling
      color: Color.mSurfaceContainerHigh
      border.color: Color.mOutline
      border.width: Math.max(1, Style.borderS * scaling)

      Column {
        id: contentColumn
        anchors.centerIn: parent
        spacing: Style.marginS * scaling

        NIcon {
          icon: "extension"
          color: Color.mPrimary
          pointSize: Style.fontSizeM * scaling
          visible: root.showIcon
        }

        NText {
          text: root.displayText
          color: Color.mOnSurface
          pointSize: Style.fontSizeS * scaling
          font.weight: Style.fontWeightMedium
          rotation: 90
        }
      }

      MouseArea {
        anchors.fill: parent
        onClicked: {
          root.clickCount++
          root.saveSetting("clickCount", root.clickCount)
        }
      }
    }
  }

  // Popout content
  popoutContent: Component {
    PopoutComponent {
      headerText: "Hello World Plugin"
      detailsText: "A simple example plugin demonstrating the plugin system"
      showCloseButton: true

      ColumnLayout {
        width: parent.width
        spacing: Style.marginM * scaling

        NText {
          text: "Plugin Information"
          pointSize: Style.fontSizeL * scaling
          font.weight: Style.fontWeightBold
          color: Color.mPrimary
        }

        NText {
          text: "Display Text: " + root.displayText
          pointSize: Style.fontSizeM * scaling
          color: Color.mOnSurface
        }

        NText {
          text: "Click Count: " + root.clickCount
          pointSize: Style.fontSizeM * scaling
          color: Color.mOnSurface
        }

        NText {
          text: "Show Icon: " + (root.showIcon ? "Yes" : "No")
          pointSize: Style.fontSizeM * scaling
          color: Color.mOnSurface
        }

        NDivider {
          Layout.fillWidth: true
        }

        NText {
          text: "This is a demonstration plugin that shows how to:"
          pointSize: Style.fontSizeM * scaling
          color: Color.mOnSurface
          wrapMode: Text.WordWrap
        }

        ColumnLayout {
          Layout.leftMargin: Style.marginM * scaling
          spacing: Style.marginS * scaling

          NText {
            text: "• Create horizontal and vertical bar pills"
            pointSize: Style.fontSizeS * scaling
            color: Color.mOnSurfaceVariant
          }

          NText {
            text: "• Use plugin settings for persistence"
            pointSize: Style.fontSizeS * scaling
            color: Color.mOnSurfaceVariant
          }

          NText {
            text: "• Create popout windows with content"
            pointSize: Style.fontSizeS * scaling
            color: Color.mOnSurfaceVariant
          }

          NText {
            text: "• Handle user interactions"
            pointSize: Style.fontSizeS * scaling
            color: Color.mOnSurfaceVariant
          }
        }

        Item {
          Layout.fillHeight: true
        }

        NButton {
          text: "Reset Click Count"
          Layout.alignment: Qt.AlignHCenter
          onClicked: {
            root.clickCount = 0
            root.saveSetting("clickCount", 0)
          }
        }
      }
    }
  }

  // Popout dimensions
  popoutWidth: 400
  popoutHeight: 350

  // Control Center integration
  ccWidgetIcon: "extension"
  ccWidgetPrimaryText: "Hello World"
  ccWidgetSecondaryText: "Clicks: " + clickCount
  ccWidgetIsActive: clickCount > 0

  onCcWidgetToggled: {
    clickCount++
    saveSetting("clickCount", clickCount)
  }
}
