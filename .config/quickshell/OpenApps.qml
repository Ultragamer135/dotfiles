pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets

Card {
  id: root

  property real collapseProgress: 0
  property var screen: null
  readonly property bool expanded: collapseProgress < 0.56
  readonly property int iconSize: 24
  readonly property int horizontalPadding: 10
  readonly property int verticalPadding: 8
  readonly property int rowGap: 4
  readonly property int rowHeight: 36
  readonly property var windows: {
    const result = [];
    for (const window of ToplevelManager.toplevels.values) {
      if (window.parent) continue;
      if (root.screen && window.screens.length
          && !window.screens.some(screen => screen.name === root.screen.name)) continue;
      const appId = window.appId || "";
      const entry = appId && (DesktopEntries.heuristicLookup(appId)
          || DesktopEntries.byId(appId));
      const iconName = entry?.icon || appId;
      result.push({ toplevel: window, appName: entry?.name || appId || window.title,
        iconSource: iconName
        ? Quickshell.iconPath(iconName, "application-x-executable") : "",
      });
    }
    return result;
  }

  width: Theme.lerp(Theme.sidebarCardExpandedWidth,
      Theme.sidebarCardCollapsedWidth, Theme.collapseWidth(collapseProgress))
  height: windows.length === 0 ? 0 : verticalPadding * 2
      + windows.length * rowHeight + Math.max(0, windows.length - 1) * rowGap
  visible: height > 0

  Column {
    x: root.horizontalPadding
    y: root.verticalPadding
    width: root.width - root.horizontalPadding * 2
    spacing: root.rowGap

    Repeater {
      model: root.windows

      delegate: Item {
        required property var modelData
        width: parent.width
        height: root.rowHeight

        Rectangle {
          anchors.fill: parent
          radius: 10
          color: modelData.toplevel.activated
              ? Theme.workspaceActiveIndicatorColor : "transparent"
        }

        IconImage {
          x: 2
          anchors.verticalCenter: parent.verticalCenter
          width: root.iconSize
          height: width
          source: modelData.iconSource || ""
          visible: source.toString() !== ""
          asynchronous: true
          smooth: true
        }

        Text {
          x: root.iconSize + 10
          width: Math.max(0, parent.width - x - 4)
          anchors.verticalCenter: parent.verticalCenter
          text: modelData.appName
          visible: root.expanded
          opacity: root.expanded ? 1 : 0
          color: Theme.sidebarV3Foreground
          font.family: Theme.fontFamily
          font.pixelSize: 12
          elide: Text.ElideRight
          verticalAlignment: Text.AlignVCenter
        }

        MouseArea {
          anchors.fill: parent
          acceptedButtons: Qt.LeftButton
          cursorShape: Qt.PointingHandCursor
          onClicked: modelData.toplevel.activate()
        }
      }
    }
  }
}
