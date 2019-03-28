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
            y: ( 9 * cartesian_frame.interval_unit - y_pos * cartesian_frame.interval_unit )/* - cartesian_frame.interval_unit*/
        }

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

            x: cartesian_frame.interval_unit + x_pos * cartesian_frame.interval_unit
            y: ( 9 * cartesian_frame.interval_unit - y_pos * cartesian_frame.interval_unit )/* - cartesian_frame.interval_unit*/
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

        from: 0
        to: 15
        value: 1
        onValueChanged: {
            direction_point.x_pos = value
        }
    }

    SpinBox{
        id: direction_y
        width: 200

        anchors.left: direction_x.right
        anchors.leftMargin: 50
        anchors.top: direction_x.top


        from: 0
        to: 9
        value: 1

        onValueChanged: {
            direction_point.y_pos = value
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
            slab_x0_line.x0_pos = value
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
            slab_x1_line.x1_pos = value
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
            slab_y0_line.y0_pos = value
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
            slab_y1_line.y1_pos = value
        }
    }


    property real x0: x_slab_x0.value
    property real x1: x_slab_x1.value
    property real y0: y_slab_y0.value
    property real y1: y_slab_y1.value

    property real origin_x_v: origin_x.value
    property real origin_y_v: origin_y.value

    property real direction_x_v: direction_x.value - origin_x.value
    property real direction_y_v: direction_y.value - origin_y.value

    property real t_x0: ( x0 - origin_x_v ) / direction_x_v
    property real t_x1: ( x1 - origin_x_v ) / direction_x_v

    property real t_y0: ( y0 - origin_y_v ) / direction_y_v
    property real t_y1: ( y1 - origin_y_v ) / direction_x_v

    Component.onCompleted: {
        console.log( "x0 : " + x0 );
        console.log( "x1 : " + x1 );
        console.log( "y0 : " + y0 );
        console.log( "y1 : " + y1 );

        console.log( "origin_x : " + origin_x_v );
        console.log( "origin_y : " + origin_y_v );
        console.log( "direction_x : " + direction_x_v );
        console.log( "direction_y : " + direction_y_v );
    }

    onT_x0Changed: {
        console.log( "t_x0 : " + t_x0 );
        console.log( "t_x1 : " + t_x1 );
        console.log( "t_y0 : " + t_y0 );
        console.log( "t_y1 : " + t_y1 );
    }

}
