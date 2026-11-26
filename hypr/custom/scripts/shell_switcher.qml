import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Io

PanelWindow {
    id: root

    screen: Quickshell.screens[0]
    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    color: "transparent"
    visible: true
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.namespace: "hypr:shell_switcher"
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    readonly property string iconDir: Quickshell.env("HOME") + "/.config/hypr/custom/scripts/icons/"
    property var shells: [
        { id: "end4-pC",  label: "Hyprland", sub: "end-4 dots",     icon: iconDir + "hyprland.svg" },
        { id: "sekaipop", label: "SekaiPop", sub: "Project SEKAI",  icon: iconDir + "sekaipop.svg" },
        { id: "macos",    label: "macOS",    sub: "Apple style",    icon: iconDir + "apple.svg" },
        { id: "MacShell", label: "Liquid",   sub: "MacShell Glass", icon: iconDir + "apple.svg" }
    ]

    property int selectedIndex: 0
    property string activeShell: "end4-pC"

    Process {
        id: activeShellProc
        command: ["bash", "-c", "pgrep -a -x qs | grep -o '\\-c [^ ]*' | awk '{print $2}' | head -n1"]
        stdout: SplitParser {
            onRead: data => {
                let trimmed = data.trim();
                if (trimmed !== "") {
                    root.activeShell = trimmed;
                    for (let i = 0; i < root.shells.length; i++) {
                        if (root.shells[i].id === trimmed) {
                            root.selectedIndex = i;
                            break;
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        activeShellProc.running = true;
    }

    function switchShell(targetId) {
        if (targetId === root.activeShell) {
            Qt.quit();
            return;
        }

        let p = switchProc.createObject(root);
        p.command = ["setsid", "-f", Quickshell.env("HOME") + "/.config/hypr/custom/scripts/switch_shell.sh", targetId];
        p.running = true;
    }

    Component {
        id: switchProc
        Process {
            onExited: Qt.quit()
        }
    }

    // Dim backdrop to dismiss
    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.45)
        opacity: 0
        NumberAnimation on opacity {
            from: 0; to: 1; duration: 140
        }
        MouseArea {
            anchors.fill: parent
            onClicked: Qt.quit()
        }
    }

    Item {
        anchors.fill: parent
        focus: true

        Keys.onLeftPressed: {
            root.selectedIndex = (root.selectedIndex - 1 + root.shells.length) % root.shells.length;
        }
        Keys.onRightPressed: {
            root.selectedIndex = (root.selectedIndex + 1) % root.shells.length;
        }
        Keys.onReturnPressed: {
            root.switchShell(root.shells[root.selectedIndex].id);
        }
        Keys.onEnterPressed: {
            root.switchShell(root.shells[root.selectedIndex].id);
        }
        Keys.onEscapePressed: {
            Qt.quit();
        }

        Rectangle {
            id: container
            width: 620
            height: 220
            anchors.centerIn: parent
            radius: 24
            color: "#E60a0a14"
            border.color: "#25FFFFFF"
            border.width: 1

            // Scale & Opacity pop animation
            scale: 0.92
            opacity: 0

            NumberAnimation on opacity {
                from: 0; to: 1; duration: 150; easing.type: Easing.OutCubic
            }
            NumberAnimation on scale {
                from: 0.92; to: 1.0; duration: 150; easing.type: Easing.OutBack
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 22
                spacing: 12

                Text {
                    text: "SWITCH SHELL"
                    Layout.alignment: Qt.AlignHCenter
                    color: "#80FFFFFF"
                    font.pixelSize: 11
                    font.weight: Font.DemiBold
                    font.letterSpacing: 2
                }

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 16

                    Repeater {
                        model: root.shells
                        delegate: Rectangle {
                            id: card
                            width: 120
                            height: 110
                            radius: 16
                            color: isSelected ? "#26FFFFFF" : "#0DFFFFFF"
                            border.color: isSelected ? "#90FFFFFF" : (isActive ? "#58D1F5" : "transparent")
                            border.width: 2

                            property bool isSelected: index === root.selectedIndex
                            property bool isActive: modelData.id === root.activeShell

                            Behavior on color { ColorAnimation { duration: 120 } }
                            Behavior on border.color { ColorAnimation { duration: 120 } }

                            ColumnLayout {
                                anchors.centerIn: parent
                                spacing: 6

                                Image {
                                    source: modelData.icon
                                    Layout.preferredWidth: 46
                                    Layout.preferredHeight: 46
                                    Layout.alignment: Qt.AlignHCenter
                                    sourceSize.width: 46
                                    sourceSize.height: 46
                                }

                                Text {
                                    text: modelData.label
                                    color: "#F0FFFFFF"
                                    font.pixelSize: 13
                                    font.weight: Font.Bold
                                    Layout.alignment: Qt.AlignHCenter
                                }

                                Text {
                                    text: modelData.sub
                                    color: "#60FFFFFF"
                                    font.pixelSize: 10
                                    Layout.alignment: Qt.AlignHCenter
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    root.selectedIndex = index;
                                    root.switchShell(modelData.id);
                                }
                            }
                        }
                    }
                }

                Text {
                    text: "← → navigate   Enter switch   Esc cancel"
                    Layout.alignment: Qt.AlignHCenter
                    color: "#50FFFFFF"
                    font.pixelSize: 11
                }
            }
        }
    }
}
