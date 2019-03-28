import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Shapes 1.11

import QtQuick.Controls 2.4


Window {
    visible: true
    width: 1600
    height: 900
    title: qsTr("SLABS")

    Rectangle{
        id: cartesian_frame
        property real interval_unit: 50
        property real line_width: 1
        border.color: "slate gray"
        border.width: 1
        clip: true

        x: 20
        y: 20
        width: 16 * interval_unit
        height: 10 * interval_unit
        color: "light gray"

        CartesianGrid{

        }

        Rectangle{
            id: slab_area

            x: slab_x0_line.startX
            y: slab_y1_line.startY

            width: slab_x1_line.startX - slab_x0_line.startX
            height: slab_y0_line.startY - slab_y1_line.startY
            color: "cyan"
            opacity: 0.2

        }

        // ORIGIN AND DIRECTION LINES
        Shape{
            anchors.fill: parent

            ShapePath{
                id: origin_line

                property real x0_pos: 8

                strokeWidth: 2
                strokeColor: "violet"
                joinStyle: ShapePath.BevelJoin
                capStyle: ShapePath.RoundCap

                startX: cartesian_frame.interval_unit + 0 * cartesian_frame.interval_unit
                startY: ( 9 * cartesian_frame.interval_unit - 0 * cartesian_frame.interval_unit )

                PathLine{
                    x: origin_point.x
                    y: origin_point.y
                }
            }

            ShapePath{
                id: direction_line

                property real x1_pos: 10

                strokeWidth: 2
                strokeColor: "royal blue"
                joinStyle: ShapePath.BevelJoin
                capStyle: ShapePath.RoundCap

                startX: origin_point.x
                startY: origin_point.y

                PathLine{
                    relativeX: direction_point.x
                    relativeY: direction_point.y
                }
            }
        }

        // ORIGIN POINT
        Item{
            id: origin_point
            property real x_pos: 0
            property real y_pos: 0

            Rectangle{
                anchors.centerIn: parent
                color: "dark violet"
                width: 10
                height: 10
                radius: 10
            }

            x: cartesian_frame.interval_unit + x_pos * cartesian_frame.interval_unit
            y: ( 9 * cartesian_frame.interval_unit - y_pos * cartesian_frame.interval_unit )

            // DIRECTION POINT
            Item{
                id: direction_point
                property real x_pos: 1
                property real y_pos: 1

                Rectangle{
                    anchors.centerIn: parent
                    color: "blue"
                    width: 10
                    height: 10
                    radius: 10
                }

                x: x_pos * cartesian_frame.interval_unit
                y: -y_pos * cartesian_frame.interval_unit
            }
        }



        // SLAB X
        Shape{
            anchors.fill: parent

            ShapePath{
                id: slab_x0_line

                property real x0_pos: 8

                strokeWidth: 3
                strokeColor: "dark red"
                joinStyle: ShapePath.BevelJoin
                capStyle: ShapePath.RoundCap

                startX: cartesian_frame.interval_unit + x0_pos * cartesian_frame.interval_unit
                startY: 0

                PathLine{
                    relativeX: 0
                    relativeY: cartesian_frame.height
                }
            }

            ShapePath{
                id: slab_x1_line

                property real x1_pos: 10

                strokeWidth: 3
                strokeColor: "dark red"
                joinStyle: ShapePath.BevelJoin
                capStyle: ShapePath.RoundCap

                startX: cartesian_frame.interval_unit + x1_pos * cartesian_frame.interval_unit
                startY: 0

                PathLine{
                    relativeX: 0
                    relativeY: cartesian_frame.height
                }
            }
        }

        // SLAB Y
        Shape{
            anchors.fill: parent

            ShapePath{
                id: slab_y0_line

                property real y0_pos: 4

                strokeWidth: 3
                strokeColor: "dark green"
                joinStyle: ShapePath.BevelJoin
                capStyle: ShapePath.RoundCap

                startX: 0
                startY: ( 9 * cartesian_frame.interval_unit - y0_pos * cartesian_frame.interval_unit )

                PathLine{
                    relativeX: cartesian_frame.width
                    relativeY: 0
                }
            }

            ShapePath{
                id: slab_y1_line

                property real y1_pos: 6

                strokeWidth: 3
                strokeColor: "dark green"
                joinStyle: ShapePath.BevelJoin
                capStyle: ShapePath.RoundCap

                startX: 0
                startY: ( 9 * cartesian_frame.interval_unit - y1_pos * cartesian_frame.interval_unit )

                PathLine{
                    relativeX: cartesian_frame.width
                    relativeY: 0
                }
            }
        }
    }


    // ORIGIN
    Text{
        id: origin_text
        anchors.left: cartesian_frame.right
        anchors.leftMargin: 50
        anchors.top: cartesian_frame.top
        text: "ORIGIN COORDINATES"
    }

    SpinBox{
        id: origin_x
        width: 200
        anchors.left: cartesian_frame.right
        anchors.leftMargin: 50
        anchors.top: origin_text.bottom
        anchors.topMargin: 10

        from: 0
        to: 15
        value: 0
        onValueChanged: {
            origin_point.x_pos = value
            results.calculate();
        }
    }

    SpinBox{
        id: origin_y
        width: 200

        anchors.left: origin_x.right
        anchors.leftMargin: 50
        anchors.top: origin_x.top


        from: 0
        to: 9
        value: 0

        onValueChanged: {
            origin_point.y_pos = value
            results.calculate();
        }
    }

    // DIRECTION
    Text{
        id: direction_text
        anchors.left: cartesian_frame.right
        anchors.leftMargin: 50
        anchors.top: origin_x.bottom
        anchors.topMargin: 30
        text: "DIRECTION COORDINATES"
    }

    SpinBox{
        id: direction_x
        width: 200
        anchors.left: cartesian_frame.right
        anchors.leftMargin: 50
        anchors.top: direction_text.bottom
        anchors.topMargin: 10

        from: -10
        to: 10
        value: 1
        onValueChanged: {
            direction_point.x_pos = value
            results.calculate();
        }
    }

    SpinBox{
        id: direction_y
        width: 200

        anchors.left: direction_x.right
        anchors.leftMargin: 50
        anchors.top: direction_x.top


        from: -10
        to: 10
        value: 1

        onValueChanged: {
            direction_point.y_pos = value
            results.calculate();
        }
    }


    Text{
        id: slab_X_text
        anchors.left: cartesian_frame.right
        anchors.leftMargin: 50
        anchors.top: direction_x.bottom
        anchors.topMargin: 30
        text: "X SLAB COORDINATES"
    }

    SpinBox{
        id: x_slab_x0
        width: 200
        anchors.left: cartesian_frame.right
        anchors.leftMargin: 50
        anchors.top: slab_X_text.bottom
        anchors.topMargin: 10

        from: 1
        to: x_slab_x1.value - 1
        value: 8
        onValueChanged: {
            slab_x0_line.x0_pos = value;
            results.calculate();
        }
    }

    SpinBox{
        id: x_slab_x1
        width: 200

        anchors.left: x_slab_x0.right
        anchors.leftMargin: 50
        anchors.top: x_slab_x0.top


        from: x_slab_x0.value + 1
        to: 14
        value: 10

        onValueChanged: {
            slab_x1_line.x1_pos = value;
            results.calculate();
        }
    }



    // SLAB Y
    Text{
        id: slab_Y_text
        anchors.left: cartesian_frame.right
        anchors.leftMargin: 50
        anchors.top: x_slab_x0.bottom
        anchors.topMargin: 30
        text: "Y SLAB COORDINATES"
    }

    SpinBox{
        id: y_slab_y0
        width: 200
        anchors.left: cartesian_frame.right
        anchors.leftMargin: 50
        anchors.top: slab_Y_text.bottom
        anchors.topMargin: 10

        from: 1
        to: y_slab_y1.value - 1
        value: 4
        onValueChanged: {
            slab_y0_line.y0_pos = value;
            results.calculate();
        }
    }

    SpinBox{
        id: y_slab_y1
        width: 200

        anchors.left: y_slab_y0.right
        anchors.leftMargin: 50
        anchors.top: y_slab_y0.top


        from: y_slab_y0.value + 1
        to: 8
        value: 6

        onValueChanged: {
            slab_y1_line.y1_pos = value;
            results.calculate();
        }
    }



    Column{
        id: results

        anchors.top: cartesian_frame.bottom
        anchors.topMargin: 50
        anchors.left: cartesian_frame.left
        spacing: 8

        property real font_size: 12
        Text{
            font.pixelSize: parent.font_size
            text: "x0 : " + x_slab_x0.value
        }
        Text{
            font.pixelSize: parent.font_size
            text: "x1 : " + x_slab_x1.value
        }

        Text{
            font.pixelSize: parent.font_size
            text: "y1 : " + y_slab_y0.value
        }
        Text{
            font.pixelSize: parent.font_size
            text: "y1 : " + y_slab_y1.value
        }

        Text{
            font.pixelSize: parent.font_size
            text: "Origin.x : " + origin_x.value
        }
        Text{
            font.pixelSize: parent.font_size
            text: "Origin.y : " + origin_y.value
        }
        Text{
            font.pixelSize: parent.font_size
            text: "Direction.x : " + direction_x.value
        }
        Text{
            font.pixelSize: parent.font_size
            text: "Direction.y : " + direction_y.value
        }

        Text{
            font.pixelSize: parent.font_size
            text: "tx0: ( x0 - Origin.x ) / Direction.x : " + parent.tx0
        }
        Text{
            font.pixelSize: parent.font_size
            text: "tx1: ( x1 - Origin.x ) / Direction.x : " + parent.tx1
        }
        Text{
            font.pixelSize: parent.font_size
            text: "ty0: ( y0 - Origin.y ) / Direction.y : " + parent.ty0
        }
        Text{
            font.pixelSize: parent.font_size
            text: "ty1: ( y1 - Origin.y ) / Direction.y : " + parent.ty1
        }
        Text{
            font.pixelSize: parent.font_size
            text: "f: min( tx0, tx1 ) : " + parent._f
        }
        Text{
            font.pixelSize: parent.font_size
            text: "F: max( ty0, ty1 ) : " + parent._F
        }

        Text{
            font.pixelSize: parent.font_size
            text: "Hit status : " + parent.is_hit
        }

        property real tx0: 0
        property real tx1: 0
        property real ty0: 0
        property real ty1: 0
        property real _f: 0
        property real _F: 0

        property string is_hit: ""

        function calculate (){
            var l_tx0 = ( x_slab_x0.value - origin_x.value ) / direction_x.value;
            var l_tx1 = ( x_slab_x1.value - origin_x.value ) / direction_x.value;
            var l_ty0 = ( y_slab_y0.value - origin_y.value ) / direction_y.value;
            var l_ty1 = ( y_slab_y1.value - origin_y.value ) / direction_y.value;

            tx0 = l_tx0;
            tx1 = l_tx1;
            ty0 = l_ty0;
            ty1 = l_ty1;

            var l_f = Math.min(l_tx0, l_tx1);
            var l_F = Math.max(l_ty0, l_ty1);

            _f = l_f;
            _F = l_F;


            if( Number.isNaN(l_f) ){
                is_hit = "NaN"
            }
            else if( !(l_f < l_F) ){
                is_hit = "no hit"
            }
            else if( l_f < l_F ){
                is_hit = "hit"
            }
            else
                is_hit = "?"
        }

        Component.onCompleted: {
            var l_tx0 = ( x_slab_x0.value - origin_x.value ) / direction_x.value;
            var l_tx1 = ( x_slab_x1.value - origin_x.value ) / direction_x.value;
            var l_ty0 = ( y_slab_y0.value - origin_y.value ) / direction_y.value;
            var l_ty1 = ( y_slab_y1.value - origin_y.value ) / direction_y.value;


            tx0 = l_tx0;
            tx1 = l_tx1;
            ty0 = l_ty0;
            ty1 = l_ty1;

            var l_f = Math.min(l_tx0, l_tx1);
            var l_F = Math.max(l_ty0, l_ty1);

            _f = l_f;
            _F = l_F;


            if( Number.isNaN(l_f) ){
                is_hit = "NaN"
            }
            else if( !(l_f < l_F) ){
                is_hit = "no hit"
            }
            else if( l_f < l_F ){
                is_hit = "hit"
            }
            else
                is_hit = "?"
        }
    }
}
