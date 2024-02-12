import QtQuick
import QtQuick.Shapes 1.6
import Qt5Compat.GraphicalEffects

Item
{
    id: progressBar

    implicitWidth:  250
    implicitHeight: 250

    // Properties

    // General
    property int    strokeStartingAngle: -90
    property bool   areStrokeEndsRounded: true
    property int    progressLevel: 0

    // Background circle
    property color  backgroundColor: "transparent"
    property color  backgroundCircleColor: "#7e7e7e"
    property int    backgroundCircleWidth: 10

    // Progress circle
    property color  progressCircleColor: "#55aaff"
    property int    progressCircleWidth: 10

    // Text
    property bool   isTextVisible: true
    property int    textSize: 12
    property string textFontFamily: "Segoe UI"
    property color  textColor: "#7c7c7c"

    // Drop shadow
    property bool   isDropShadowEnabled: true
    property color  dropShadowColor: "#20000000"
    property int    dropShadowRadius: 10

    // Progress bar
    Shape
    {
        id: shape
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 8
        layer.effect: (isDropShadowEnabled == true) ? dropShadow : null

        // Drop Shadow
        Component
        {
            id : dropShadow

            DropShadow
            {
                verticalOffset:   0
                horizontalOffset: 0

                samples: 10
                fast: true

                color:  progressBar.dropShadowColor
                radius: progressBar.dropShadowRadius
            }
        }

        // Background circle stroke
        ShapePath
        {
            id: backgroundCircle
            strokeColor: progressBar.backgroundCircleColor
            fillColor: progressBar.backgroundColor
            strokeWidth: progressBar.backgroundCircleWidth
            capStyle: progressBar.areStrokeEndsRounded ? ShapePath.RoundCap : ShapePath.FlatCap

            PathAngleArc
            {
                radiusX: (progressBar.width  / 2) - (progressBar.progressCircleWidth / 2)
                radiusY: (progressBar.height / 2) - (progressBar.progressCircleWidth / 2)
                centerX: progressBar.width / 2
                centerY: progressBar.height / 2
                startAngle: progressBar.strokeStartingAngle
                sweepAngle: 360
            }
        }

        // Progress circle stroke
        ShapePath
        {
            id: progressCircle
            strokeColor: progressBar.progressCircleColor
            fillColor: "transparent"
            strokeWidth: progressBar.progressCircleWidth
            capStyle: progressBar.areStrokeEndsRounded ? ShapePath.RoundCap : ShapePath.FlatCap

            PathAngleArc
            {
                radiusX: (progressBar.width  / 2) - (progressBar.progressCircleWidth / 2)
                radiusY: (progressBar.height / 2) - (progressBar.progressCircleWidth / 2)
                centerX: progressBar.width / 2
                centerY: progressBar.height / 2
                startAngle: progressBar.strokeStartingAngle
                sweepAngle: (360 / 100 * progressBar.progressLevel)
            }
        }

        Text
        {
            id: text

            anchors.centerIn: parent

            text: (progressBar.progressLevel > 100) ? "100%" : progressBar.progressLevel + "%"
            color: progressBar.textColor
            font.pointSize: progressBar.textSize
            font.family: progressBar.textFontFamily
        }
    }
}
