
import QtQuick 1.0

Item {
    width:500
    height:340
    property variant teemanimi: ''
    property variant oigedvastused: 0
    property variant valedvastused: 0
    property variant oigevastus: ''
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
                content.opacity = 1
                kysimusetekst.text = " See on meie väike programmeerimisüritus, kus püüame imiteerida\n lauamängu EESTI MÄNG\n EDASI nupuga tuleb järgmine küsimus\n OK nupuga kinnitad vastuse ja väljastab kas Õige/Vale\n paremale tulevad teemade kaardid, mis teeninud oled\n all vasakul näitab õigete ja valede vastuste arvu"
                kysimusetekst.opacity = 1
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
				content.opacity = 0
				vastus.opacity = 0
				ok.opacity = 0
				edasi.opacity = 0
				mangi.opacity = 1
				abi.opacity = 1
				logo.opacity = 1
				eesti_v2ike.opacity = 0
				kast.opacity = 0
				geograafia.opacity = 0
				varia.opacity = 0
				loodus.opacity = 0
				sport.opacity = 0
				kultuur.opacity = 0
				ajalugu.opacity = 0
				kysimusetekst.text = ''
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
			id: kysimusetekst
			font.pixelSize: 13
			text: ''
			opacity: 0
			anchors.fill: parent
		}
    }
    TextInput{
        id: vastus
        x: 14
        y: 115
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
                edasi.opacity = 1
                vastus.opacity = 1
                oigevastus = kysimus.valivas
				if(vastus.text.toLowerCase().indexOf(oigevastus.toLowerCase())!=-1){
					vastus.text = "Õige"
                    oigedvastused = oigedvastused+1

					if(teemanimi==="GEOGRAAFIA") {
					geograafia.opacity = 1
					}
					else if (teemanimi==="KULTUUR") {
					kultuur.opacity = 1
					}
					else if (teemanimi==="AJALUGU") {
					ajalugu.opacity = 1
					}
					else if (teemanimi==="SPORT") {
					sport.opacity = 1
					}
					else if (teemanimi==="VARIA") {
					varia.opacity = 1
					}
					else if (teemanimi==="LOODUS") {
					loodus.opacity = 1
					}
				}
				else if(oigevastus.toLowerCase().indexOf(vastus.text.toLowerCase())!=-1){
					vastus.text = "Õige"
                    oigedvastused = oigedvastused+1

					if(teemanimi==="GEOGRAAFIA") {
					geograafia.opacity = 1
					}
					else if (teemanimi==="KULTUUR") {
					kultuur.opacity = 1
					}
					else if (teemanimi==="AJALUGU") {
					ajalugu.opacity = 1
					}
					else if (teemanimi==="SPORT") {
					sport.opacity = 1
					}
					else if (teemanimi==="VARIA") {
					varia.opacity = 1
					}
					else if (teemanimi==="LOODUS") {
					loodus.opacity = 1
					}
				}
				else { vastus.text = "VALE, õige vastus on "+oigevastus
				       valedvastused = valedvastused+1
				       }
				
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
			    vastus.text=''
				kysimusetekst.opacity = 1
				teemanimi = kysimus.kysteemanot
				kysimusetekst.text = " "+teemanimi+"\n"+"\n"+" "+kysimus.valikys
				vastus.opacity = 1
				kast.opacity = 1
				edasi.opacity = 0
			}
		}

    }
    Image {
        id: kultuur
        source: "images/kultuur.png"
        x: 380
        y: 85
        opacity: 0

    }
    Image {
        id: sport
        source: "images/sport.png"
        x: 380
        y: 120
        opacity: 0

    }
    Image {
        id: geograafia
        source: "images/geograafia.png"
        x: 380
        y: 155
        opacity: 0

    }
    Image {
        id: varia
        source: "images/varia.png"
        x: 380
        y: 190
        opacity: 0

    }
    Image {
        id: loodus
        source: "images/loodus.png"
        x: 380
        y: 225
        opacity: 0

    }
    Image {
        id: ajalugu
        source: "images/ajalugu.png"
        x: 380
        y: 260
        opacity: 0

    }
    Image {
        id: kast
        source: "images/kast.png"
        x: 20
        y: 250
        opacity: 0
        Text {
			id: kastikiri
			font.pixelSize: 15
			text: "ÕIGEID: "+oigedvastused.toString()+"\n"+"VALESID: "+valedvastused.toString()
			opacity: 1
			anchors.fill: parent
		}

    }
}
