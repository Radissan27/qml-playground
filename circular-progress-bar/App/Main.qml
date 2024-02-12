import QtQuick

import QtQuick.Layouts
import QtQuick.Controls

Window
{
    width: 1024
    height: 768
    visible: true

    title: qsTr("Hello World")

    color: "#191919"

    ColumnLayout
    {
        anchors.fill: parent

        Item
        {
            Layout.fillWidth:  true
            Layout.fillHeight: true
        }

        RowLayout
        {
            Layout.alignment: Qt.AlignHCenter

            spacing: 35

            CircularProgressBar
            {
                progressLevel: slider.value
                textColor: "#55aaff"
                backgroundColor: "indigo"
            }

            CircularProgressBar
            {
                progressLevel: slider.value
                backgroundCircleWidth:4
                progressCircleWidth: 8
                progressCircleColor: "yellow"
                textColor: "yellow"
                dropShadowColor: "grey"
            }

            CircularProgressBar
            {
                progressLevel: slider.value
                progressCircleColor: "red"
                isDropShadowEnabled: false
                textColor: "red"
            }
        }

        Item
        {
            Layout.fillWidth:  true
            Layout.preferredHeight: 35
        }

        Slider
        {
            id: slider

            Layout.alignment: Qt.AlignHCenter

            from: 0
            to: 100
        }

        Item
        {
            Layout.fillWidth:  true
            Layout.fillHeight: true
        }
    }

}
