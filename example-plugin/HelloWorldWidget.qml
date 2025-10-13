import QtQuick
import qs.Commons
import qs.Widgets
import qs.Services

Rectangle {
  id: root

  // Bar integration properties (injected by BarWidgetLoader)
  property ShellScreen screen
  property real scaling: 1.0
  property string widgetId: ""
  property string section: ""
  property int sectionWidgetIndex: -1
  property int sectionWidgetsCount: 0
  
  // Plugin-specific properties (injected by BarWidgetLoader)
  property string pluginId: ""
  property var pluginService: null
  property real widgetThickness: 0
  property real barThickness: 0
  property bool isHorizontal: true

  // Simple sizing
  implicitWidth: 100 * scaling
  implicitHeight: Style.barHeight * scaling

  // Simple appearance
  color: Color.mPrimary
  radius: Style.radiusM * scaling

  // Simple text
  Text {
    anchors.centerIn: parent
    text: "TEST"
    color: Color.mOnPrimary
    font.pointSize: Style.fontSizeM * scaling
  }

  // Click handler
  MouseArea {
    anchors.fill: parent
    onClicked: {
      ToastService.showNotice("Plugin Test", "Plugin widget clicked!", 2000)
    }
  }
}