import QtQuick 2.6
import QtQuick.Controls 2.1



BusyIndicator {
    id: control

    property var size: 180

    contentItem: Item {
        implicitWidth: dp(size)
        implicitHeight: dp(size)

        Item {
            id: item
            x: parent.width / 2 - dp(size / 2)
            y: parent.height / 2 - dp(size / 2)
            width: dp(size)
            height: dp(size)
            opacity: control.running ? 1 : 0

            Behavior on opacity {
                OpacityAnimator {
                    duration: 250
                }
            }

            RotationAnimator {
                target: item
                running: control.visible && control.running
                from: 0
                to: 360
                loops: Animation.Infinite
                duration: 10000
            }

            Repeater {
                id: repeater
                model: 8

                Rectangle {
                    x: item.width / 2 - width / 2
                    y: item.height / 2 - height / 2
                    implicitWidth: dp(15)
                    implicitHeight: implicitWidth
                    radius: implicitWidth / 2
                    color: verdeMassa
                    transform: [
                        Translate {
                            y: -Math.min(item.width, item.height) * 0.5 + 5
                        },
                        Rotation {
                            angle: index / repeater.count * 360
                            origin.x: implicitWidth / 2
                            origin.y: implicitWidth / 2
                        }
                    ]
                }
            }
        }
    }
}
