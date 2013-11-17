﻿
import QtQuick 1.0
Item {
    width:500
    height:340
    Image {
        id: taust
        source: "images/layer_0.png"
        x: 0
        y: 0
        opacity: 1
    }
    Image {
        id: logo
        source: "images/eesti_mäng.png"
        x: 120
        y: 100
        opacity: 1
    }
    Image {
        id: mangi
        source: "images/group_1.png"
        x: 92
        y: 228
        opacity: 1
		MouseArea {
			anchors.fill: parent
			onClicked: { 
				logo.opacity = 0
				abi.opacity = 0
				mangi.opacity = 0
				eesti_v2ike.opacity = 1
				content.opacity = 1
                vastus.opacity = 1
                ok.opacity = 1
                edasi.opacity = 1

			}
		}	
    }
    Image {
        id: abi
        source: "images/group_2.png"
        x: 292
        y: 228
        opacity: 1
        MouseArea {
            anchors.fill: parent
            onClicked: {
                logo.opacity = 0
                abi.opacity = 0
                mangi.opacity = 0
                eesti_v2ike.opacity = 1
            }
        }
    }
    Image {
        id: eesti_v2ike
        source: "images/eesti_v2ike.png"
        x: 8
        y: 4
        opacity: 0
		MouseArea {
			anchors.fill: parent
			onClicked: {
				proge.wat()
				content.opacity = 0
				vastus.opacity = 0
				logo.opacity = 1
				mangi.opacity = 1
				abi.opacity = 1
			}
		}
    }
    Image {
        id: content
        source: "images/content.png"
        x: 10
        y: 41
        opacity: 0
        Text {
			id: ala
			opacity: 0
			text: "aaaaa"
			anchors.fill: parent
			font.pixelSize: 14
			color: 'black'
		}


    }
    TextInput{
        id: vastus
        x: 20
        y: 90
        opacity: 0
        font.pixelSize: 14
        focus: true

    }
    Image {
        id: ok
        source: "images/ok.png"
        x: 60
        y: 190
        opacity: 0
        MouseArea {
            anchors.fill: parent
            onClicked: {
                proge.check_answer()


            }
        }
    }

    Image {
        id: edasi
        source: "images/edasi.png"
        x: 150
        y: 190
        opacity: 0
		MouseArea {
			anchors.fill: parent
			onClicked: {
				ala.opacity = 1
				ala.text = " "+proge.aaa
			}
		}

    }
}