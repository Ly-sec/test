import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

Rectangle {
  id: root
  
  property real scaling: 1.0
  property string location: "London"
  property string units: "metric"
  property bool showIcon: true
  property color backgroundColor: "#2196F3"
  
  width: content.implicitWidth + Style.marginM * scaling * 2
  height: 32 * scaling
  radius: Style.radiusS * scaling
  color: backgroundColor
  
  RowLayout {
    id: content
    anchors.centerIn: parent
    spacing: Style.marginS * scaling
    
    // Weather icon
    NIcon {
      visible: showIcon
      icon: getWeatherIcon()
      pointSize: 16 * scaling
      color: "white"
    }
    
    // Temperature
    NText {
      text: getTemperature()
      font.pixelSize: 14 * scaling
      font.weight: Font.Medium
      color: "white"
    }
    
    // Location
    NText {
      text: location
      font.pixelSize: 12 * scaling
      color: "white"
      opacity: 0.8
    }
  }
  
  function getWeatherIcon() {
    // This would normally fetch real weather data
    // For demo purposes, return a generic weather icon
    return "cloud"
  }
  
  function getTemperature() {
    // This would normally fetch real temperature data
    // For demo purposes, return a mock temperature
    const temp = units === "metric" ? "22°C" : "72°F"
    return temp
  }
  
  // Timer to simulate weather updates
  Timer {
    interval: 30000 // 30 seconds
    repeat: true
    running: true
    onTriggered: {
      // In a real implementation, this would fetch new weather data
      console.log("Weather widget updated for", location)
    }
  }
}
