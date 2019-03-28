import QtQuick 2.0
import QtQuick.Shapes 1.11



ShapePath{
    id: thick_line

    property real num: 1
    property real interval: 50
    property real f_height: 500

    strokeWidth: 1
    strokeColor: "dark gray"
    joinStyle: ShapePath.BevelJoin
    capStyle: ShapePath.RoundCap

    startX: interval * num
    startY: 0

    PathLine{
        relativeX: 0
        relativeY: f_height
    }
}




