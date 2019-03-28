import QtQuick 2.0
import QtQuick.Shapes 1.11

//property alias strokeW: thick_line.strokeWidth

ShapePath{
    id: thick_line

    property real num: 1
    property real interval: 50
    property real f_width: 800

    strokeWidth: 1
    strokeColor: "dark gray"
    joinStyle: ShapePath.BevelJoin
    capStyle: ShapePath.RoundCap

    startX: 0
    startY: interval * num

    PathLine{
        relativeX: f_width
        relativeY: 0
    }
}
