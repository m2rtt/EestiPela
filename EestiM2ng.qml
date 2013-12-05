
import QtQuick 1.0

Item {
    width:600
    height:340
    property variant teemanimi: ''
    property variant oigedvastused: 0
    property variant valedvastused: 0
    property variant kysimusmuutujasse: ''
    property variant kyspikkus: 0
    property variant oigevastus: ''
	property variant pikkus: 0
	property int seconds : 0
	property int n: 0
    Image {
        id: taust
        source: "images/taust.png"
        x: 0
        y: 0
        opacity: 1
    }
    Image {
        id: logo
        source: "images/eesti_mäng.png"
        x: 0
        y: 72
        opacity: 1
    }
    Image {
        id: mangi
        source: "images/mängi.png"
        x: 90
        y: 230
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
                edasi_hall.opacity = 1
				stopper.opacity = 1
				taimer.running = true
			    vastus.text=''
				kysimusetekst.opacity = 1
				vastus.opacity = 1
				kast.opacity = 1
				kysimusmuutujasse=kysimus.valikys
				teemanimi = kysimus.kysteemanot
				kyspikkus = kysimusmuutujasse.length
				if(kyspikkus <= 53){
				kysimusetekst.text = " "+teemanimi+"\n"+"\n"+" "+kysimusmuutujasse
				}
				else{
				     n = kysimusmuutujasse.substring(37,53).indexOf(" ")
                     kysimusetekst.text = " "+teemanimi+"\n "+kysimusmuutujasse.substring(0,37+n)+"\n"+kysimusmuutujasse.substring(37+n,kyspikkus)
				}

			}
		}	
    }
    Image {
        id: abi
        source: "images/abi.png"
        x: 325
        y: 230
        opacity: 1
        MouseArea {
            anchors.fill: parent
            onClicked: {
                logo.opacity = 0
                abi.opacity = 0
                mangi.opacity = 0
                eesti_v2ike.opacity = 1
                abicontent.opacity = 1
                abitekst.text = "  See on meie väike programmeerimisüritus, kus püüame imiteerida\n  lauamängu EESTI MÄNG\n  1) EDASI nupuga tuleb järgmine küsimus\n  2) VASTA nupuga kinnitad vastuse\n  3) Paremale tekivad teemad, mis oled õigesti vastanud\n  4) All vasakul näitab statisktikat\n  PS: Jälgi KÄÄNDEID!!"
                abitekst.opacity = 1
				tagasi.opacity = 1
            }
        }
    }
    Image {
        id: eesti_v2ike
        source: "images/eesti_mäng_väike.png"
        x: 0
        y: -39
        opacity: 0
    }
    Image {
        id: content
        source: "images/valgetaust.png"
        x: 13
        y: 65
        opacity: 0
        Text {
			id: kysimusetekst
			anchors.margins: 5
			font.pixelSize: 13
			text: ''
			font.family: "Century Gothic"
			opacity: 0
			anchors.fill: parent
		}
    }
    Image {
        id: abicontent
        source: "images/valgetaust_abi.png"
        x: 13
        y: 65
        opacity: 0
        Text {
			id: abitekst
			font.pixelSize: 15
			font.family: "Century Gothic"
			text: ''
			opacity: 0
			anchors.margins: 5
			anchors.fill: parent
		}
	}
    Image {
        id: tagasi
        source: "images/tagasi.png"
        x: 474
        y: 269
        opacity: 0
		MouseArea {
            anchors.fill: parent
            onClicked: {
                logo.opacity = 1
                abi.opacity = 1
                mangi.opacity = 1
                eesti_v2ike.opacity = 0
                abicontent.opacity = 0
				tagasi.opacity = 0
				geograafia.opacity = 0
				varia.opacity = 0
				sport.opacity = 0
				loodus.opacity = 0
				kultuur.opacity = 0
				ajalugu.opacity = 0
				content.opacity = 0
				stopper.opacity = 0
				kast.opacity = 0
				oigedvastused = 0
				valedvastused = 0
				kysimusetekst.font.bold = false
				kysimusetekst.color = "black"
				kysimusetekst.font.pixelSize = 13
				tagasi.x = 474
				tagasi.y = 269
				seconds = 0

            }
        }
    }

    TextInput{
        id: vastus
        x: 24
        y: 135
        opacity: 0
        font.pixelSize: 13
        font.family: "Century Gothic"
        color: "black"
        focus: true

    }
    Image {
        id: edasi_hall
        source: "images/edasi_hall.png"
        x: 170
        y: 156
        opacity: 0
    }
    Image {
        id: ok_hall
        source: "images/vasta_hall.png"
        x: 49
        y: 156
        opacity: 0
    }
    Image {
        id: ok
        source: "images/vasta.png"
        x: 49
        y: 156
        opacity: 0
        MouseArea {
            anchors.fill: parent
            onClicked: {
                edasi.opacity = 1
				edasi_hall.opacity = 0
                vastus.opacity = 1
                oigevastus = kysimus.valivas
				if(oigevastus.length > 4) {
					if(oigevastus.length > 8) {
						pikkus = 8
					}
					else {
						pikkus = 4
					}
				}
				else if(oigevastus.length <= 4) {
					pikkus = 0
				}
				if(vastus.text.toLowerCase().indexOf(oigevastus.toLowerCase())!=-1){
				    vastus.font.bold = true
				    vastus.color = "green"
					vastus.text = "Õige"
					ok_hall.opacity = 1
					ok.opacity = 0
                    oigedvastused = oigedvastused+1

					if(teemanimi=="GEOGRAAFIA") {
					geograafia.opacity = 1
					}
					else if (teemanimi=="KULTUUR") {
					kultuur.opacity = 1
					}
					else if (teemanimi=="AJALUGU") {
					ajalugu.opacity = 1
					}
					else if (teemanimi=="SPORT") {
					sport.opacity = 1
					}
					else if (teemanimi=="VARIA") {
					varia.opacity = 1
					}
					else if (teemanimi=="LOODUS") {
					loodus.opacity = 1
					}
				}
				else if(oigevastus.toLowerCase().indexOf(vastus.text.toLowerCase())!=-1 && oigevastus.length - vastus.text.length <= pikkus){
				    vastus.font.bold = true
				    vastus.color = "green"
					vastus.text = "Õige"
					ok.opacity = 0
					ok_hall.opacity = 1
                    oigedvastused = oigedvastused+1

					if(teemanimi=="GEOGRAAFIA") {
					geograafia.opacity = 1
					}
					else if (teemanimi=="KULTUUR") {
					kultuur.opacity = 1
					}
					else if (teemanimi=="AJALUGU") {
					ajalugu.opacity = 1
					}
					else if (teemanimi=="SPORT") {
					sport.opacity = 1
					}
					else if (teemanimi=="VARIA") {
					varia.opacity = 1
					}
					else if (teemanimi=="LOODUS") {
					loodus.opacity = 1
					}
				}
				else { vastus.font.bold = true
				       vastus.color = "red"
				       vastus.text = "VALE, õige vastus on "+oigevastus
				       valedvastused = valedvastused+1
					   ok.opacity = 0
					   ok_hall.opacity = 1
			    }
			    if(loodus.opacity == 1 && varia.opacity == 1 && sport.opacity == 1 && ajalugu.opacity == 1 && kultuur.opacity == 1 && geograafia.opacity == 1){
			       vastus.opacity = 0
			       vastus.text = ""
			       ok_hall.opacity = 0
			       ok.opacity = 0
			       edasi.opacity = 0
			       kysimusetekst.font.bold = true
			       kysimusetekst.font.pixelSize = 18
			       kysimusetekst.color = "blue"
			       kysimusetekst.text = "\n      VÕITSID MÄNGU!"
			       tagasi.x = 275
			       tagasi.y = 260
			       tagasi.opacity = 1
			       taimer.running = false

			    }
				
            }
        }
    }

    Image {
        id: edasi
        source: "images/edasi.png"
        x: 170
        y: 156
        opacity: 0
		MouseArea {
			anchors.fill: parent
			onClicked: {
			    vastus.text=''
			    vastus.font.bold = false
			    vastus.color = "black"
				ok.opacity = 1
				ok_hall.opacity = 0
				kysimusetekst.opacity = 1
				vastus.opacity = 1
				kast.opacity = 1
				edasi.opacity = 0
				edasi_hall.opacity = 1
				kysimusmuutujasse=kysimus.valikys
				teemanimi = kysimus.kysteemanot
				kyspikkus = kysimusmuutujasse.length
				if(kyspikkus <= 53){
				kysimusetekst.text = " "+teemanimi+"\n"+"\n"+" "+kysimusmuutujasse
				}
				else{
				     n = kysimusmuutujasse.substring(37,53).indexOf(" ")
                     kysimusetekst.text = " "+teemanimi+"\n"+" "+kysimusmuutujasse.substring(0,37+n)+"\n"+kysimusmuutujasse.substring(37+n,kyspikkus)
				}
			}
		}

    }
     Image {
        id: ajalugu
        source: "images/ajalugu.png"
        x: 397
        y: 154
        opacity: 0
    }
    Image {
        id: geograafia
        source: "images/ge_ograafia.png"
        x: 413
        y: 70
        opacity: 0
    }
    Image {
        id: kultuur
        source: "images/kultuur.png"
        x: 408
        y: 107
        opacity: 0
    }
    Image {
        id: loodus
        source: "images/loodus.png"
        x: 412
        y: 180
        opacity: 0
    }
    Image {
        id: sport
        source: "images/sport.png"
        x: 413
        y: 232
        opacity: 0
    }
    Image {
        id: varia
        source: "images/varia.png"
        x: 413
        y: 267
        opacity: 0
    }
    Image {
        id: kast
        source: "images/kast.png"
        x: 29
        y: 255
        opacity: 0
        Text {
			id: kastikiri
			font.pointSize: 15
			font.family: "Berlin Sans FB"
			text: "Õigeid: "+oigedvastused.toString()+"\n"+"Valesid: "+valedvastused.toString()
			opacity: 1
			anchors.fill: parent
		}

    }
    Image {
        id: stopper
		source: "images/stopper.png"
        x: 153
        y: 252
		opacity: 0

        Text {

                text: "Aeg: "+seconds+"s"
                font.pointSize: 15
                font.family: "Berlin Sans FB"
                anchors.centerIn: parent
            }
    }

    Timer {
		id: taimer
        interval: 1000
        running: false
        repeat: true
        onTriggered: seconds++
    }
}

