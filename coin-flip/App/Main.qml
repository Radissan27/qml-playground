import QtQuick
import QtMultimedia

import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: mainWindow

    width: 600
    height: 480

    visible: true
    color: "#00000000"

    title: qsTr("Hello World")

    flags: Qt.SplashScreen | Qt.FramelessWindowHint

    // Actual splash window
    Rectangle
    {
        anchors.fill: parent

        color: "#191919"
        radius: 45

        // Window buttons
        Rectangle
        {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 28
            anchors.rightMargin: 28

            width:  16
            height: 16

            radius: width / 2

            color: "red"

            Text
            {
                text: "X"
                color: "black"
                font.pixelSize: 10
                font.bold: true
                anchors.centerIn: parent
            }

            MouseArea
            {
                anchors.fill: parent

                onClicked: mainWindow.close()
            }
        }

        // Window content
        RowLayout
        {
            anchors.fill: parent

            spacing: 0

            // Spacer
            Item
            {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            // Coin
            Flipable
            {
                id: coin

                Layout.preferredWidth: 200
                Layout.preferredHeight: 200

                property int angle: 0
                property int duration: 500

                MediaPlayer
                {
                    id: victorySound
                    source: "resources/victory.mp3"
                    audioOutput: AudioOutput {}
                }

                MediaPlayer
                {
                    id: failureSound
                    source: "resources/failure.mp3"
                    audioOutput: AudioOutput {}
                }

                front: IconImage
                {
                    id: heads
                    width: 200
                    height: 200
                    anchors.centerIn: parent

                    Layout.alignment: Qt.AlignVCenter

                    property bool isHeads: true

                    color: "goldenrod"

                    source: "resources/dime-head.png"
                }

                back: IconImage
                {
                    id: tails
                    width: 200
                    height: 200
                    anchors.centerIn: parent

                    Layout.alignment: Qt.AlignVCenter

                    property bool isHeads: true

                    color: "goldenrod"

                    source: "resources/dime-tail.png"

                    transform: Rotation
                    {
                        axis.x: 0; axis.y: 0; axis.z: 1

                        origin.x: (tails.x + tails.width) / 2
                        origin.y: (tails.y + tails.height) / 2

                        angle: -90
                    }
                }

                transform: Rotation
                {
                    axis.x: 1; axis.y: 1; axis.z: 0

                    origin.x: coin.width / 2
                    origin.y: coin.height / 2

                    angle: coin.angle

                    Behavior on angle
                    {
                        SequentialAnimation
                        {
                            NumberAnimation { duration: coin.duration }

                            ScriptAction
                            {
                                script:
                                {
                                    var numberOfRotations = coin.angle / 180;

                                    if (numberOfRotations == 0)
                                    {
                                        return;
                                    }

                                    if
                                    (
                                        numberOfRotations % 2 == 0 && option1.checked === true ||
                                        numberOfRotations % 2 != 0 && option2.checked === true
                                    )
                                    {
                                        victorySound.play();
                                    }
                                    else
                                    {
                                        failureSound.play()
                                    }

                                    // Delay
                                    var timeStart = new Date().getTime();

                                    while (new Date().getTime() - timeStart < 4000) // 4s
                                    {
                                        // Do nothing
                                    }

                                    // Clear prediction
                                    option1.checked = false;
                                    option2.checked = false;

                                    // Reset coin to initial position
                                    coin.duration = 0;
                                    coin.angle = 0;
                                }
                            }


                        }
                    }
                }

                MouseArea
                {
                    id: coinSurface

                    anchors.fill: parent

                    enabled: false

                    onClicked:
                    {
                        coinSurface.enabled = false

                        var numberOfRotations = Math.floor(Math.random() * 10) + 1;

                        // Set duration before angle because otherwise the animation will play with the old duration
                        coin.duration = numberOfRotations * 500;

                        var newAngle = numberOfRotations * 180;

                        if (newAngle > coin.angle)
                        {
                            coin.angle += newAngle;
                        }
                        else
                        {
                            coin.angle -= newAngle;
                        }
                    }
                }
            }

            // Spacer
            Item
            {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            // Predictions layout
            ColumnLayout
            {
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignVCenter

                spacing: 25

                Text
                {
                    Layout.alignment: Qt.AlignHCenter

                    text: "Your prediction:"
                    color: "white"
                    font.pixelSize: 20
                }

                RowLayout
                {
                    Layout.alignment: Qt.AlignHCenter

                    spacing: 15

                    RadioButton
                    {
                        id: option1
                        text: qsTr("Heads")
                        font.pixelSize: 14

                        indicator: Rectangle
                        {
                            implicitWidth: 22
                            implicitHeight: 22
                            x: option1.leftPadding
                            y: parent.height / 2 - height / 2
                            radius: implicitWidth / 2
                            border.color: option1.down ? "#17a81a" : "#21be2b"

                            Rectangle {
                                width: 12
                                height: 12
                                anchors.centerIn: parent
                                radius: width / 2
                                color: option1.down ? "#17a81a" : "#21be2b"
                                visible: option1.checked
                            }
                        }

                        contentItem: Text
                        {
                            text: option1.text
                            font: option1.font
                            opacity: enabled ? 1.0 : 0.3
                            color: option1.down ? "#17a81a" : "#21be2b"
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: option1.indicator.width + option1.spacing
                        }

                        onCheckedChanged:
                        {
                            if (checked === true)
                            {
                                coinSurface.enabled = true
                            }
                        }
                    }

                    RadioButton
                    {
                        id: option2
                        text: qsTr("Tails")
                        font.pixelSize: 14

                        indicator: Rectangle
                        {
                            implicitWidth: 22
                            implicitHeight: 22
                            x: option2.leftPadding
                            y: parent.height / 2 - height / 2
                            radius: implicitWidth / 2
                            border.color: option2.down ? "#17a81a" : "#21be2b"

                            Rectangle {
                                width: 12
                                height: 12
                                anchors.centerIn: parent
                                radius: width / 2
                                color: option2.down ? "#17a81a" : "#21be2b"
                                visible: option2.checked
                            }
                        }

                        contentItem: Text
                        {
                            text: option2.text
                            font: option2.font
                            opacity: enabled ? 1.0 : 0.3
                            color: option2.down ? "#17a81a" : "#21be2b"
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: option2.indicator.width + option2.spacing
                        }

                        onCheckedChanged:
                        {
                            if (checked === true)
                            {
                                coinSurface.enabled = true
                            }
                        }
                    }
                }
            }

            // Spacer
            Item
            {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
