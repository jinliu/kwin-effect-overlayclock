/*
    SPDX-FileCopyrightText: 2024 Vlad Zahorodnii <vlad.zahorodnii@kde.org>

    SPDX-License-Identifier: MIT
*/

import QtQuick
import QtQuick.Window
import QtQuick.Effects
import org.kde.kwin as KWinComponents

Window {
    id: root

    readonly property bool _q_showWithoutActivating: true

    color: "transparent"
    flags: Qt.BypassWindowManagerHint | Qt.FramelessWindowHint
    width: 1000
    height: 500
    x: (Screen.virtualX + Screen.width) - width
    y: Screen.virtualY

    Text {
        id: clock
        fontSizeMode: Text.Fit
        font.pixelSize: 72
        font.bold: true
        horizontalAlignment: Text.AlignRight
        color: "white"
        anchors.fill: parent
        width: 500
        height: 200
    }

    MultiEffect {
        source: clock
        anchors.fill: clock
        shadowBlur: 1.0
        shadowEnabled: true
        shadowColor: "black"
        shadowVerticalOffset: 15
        shadowHorizontalOffset: 11
    }

    Timer {
        interval: 1000
        running: root.visible
        repeat: true
        onTriggered: {
            clock.text = new Date().toLocaleTimeString();
            console.log(clock.text);
        }
    }

    function toggle() {
        clock.text = new Date().toLocaleTimeString();
        root.visible = !root.visible;
    }

    KWinComponents.ShortcutHandler {
        name: "OverlayClock"
        text: "Toggle Overlay Clock Effect"
        sequence: "Meta+Ctrl+C"
        onActivated: {
            root.toggle();
        }
    }
}
