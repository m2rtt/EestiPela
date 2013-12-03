
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
				teemanimi = kysimus.kysteemanot
				vastus.opacity = 1
				kast.opacity = 1
				kysimusmuutujasse=kysimus.valikys
				kyspikkus = kysimusmuutujasse.length
				if(kyspikkus <= 63){
				kysimusetekst.text = "  "+teemanimi+"\n"+"\n"+"  "+kysimusmuutujasse
				}
				else{
				     n = kysimusmuutujasse.substring(47,63).indexOf(" ")
                     kysimusetekst.text = "  "+teemanimi+"\n"+"\n"+"  "+kysimusmuutujasse.substring(0,47+n)+"\n"+" "+kysimusmuutujasse.substring(47+n,kyspikkus)
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
                abitekst.text = " See on meie väike programmeerimisüritus, kus püüame imiteerida\n lauamängu EESTI MÄNG\n EDASI nupuga tuleb järgmine küsimus\n OK nupuga kinnitad vastuse ja väljastab kas Õige/Vale\n paremale tulevad teemade kaardid, mis teeninud oled\n all vasakul näitab õigete ja valede vastuste arvu"
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
			font.pixelSize: 13
			text: ''
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
			font.pixelSize: 13
			text: ''
			opacity: 0
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
            }
        }
    }
    TextInput{
        id: vastus
        x: 24
        y: 135
        opacity: 0
        font.pixelSize: 13
        font.family: "Arial"
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
					vastus.text = "Õige"
					ok_hall.opacity = 1
					ok.opacity = 0
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
				else if(oigevastus.toLowerCase().indexOf(vastus.text.toLowerCase())!=-1 && oigevastus.length - vastus.text.length <= pikkus){
					vastus.text = "Õige"
					ok.opacity = 0
					ok_hall.opacity = 1
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
					   ok.opacity = 0
					   ok_hall.opacity = 1
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
				ok.opacity = 1
				ok_hall.opacity = 0
				kysimusetekst.opacity = 1
				teemanimi = kysimus.kysteemanot
				vastus.opacity = 1
				kast.opacity = 1
				edasi.opacity = 0
				edasi_hall.opacity = 1
				kysimusmuutujasse=kysimus.valikys
				kyspikkus = kysimusmuutujasse.length
				if(kyspikkus <= 63){
				kysimusetekst.text = "  "+teemanimi+"\n"+"\n"+"  "+kysimusmuutujasse
				}
				else{
				     n = kysimusmuutujasse.substring(47,63).indexOf(" ")
                     kysimusetekst.text = "  "+teemanimi+"\n"+"\n"+"  "+kysimusmuutujasse.substring(0,47+n)+"\n"+" "+kysimusmuutujasse.substring(47+n,kyspikkus)
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
        x: 20
        y: 250
        opacity: 0
        Text {
			id: kastikiri
			font.pixelSize: 15
			font.family: "Arial"
			text: "ÕIGEID: "+oigedvastused.toString()+"\n"+"VALESID: "+valedvastused.toString()
			opacity: 1
			anchors.fill: parent
		}

    }
    Image {
        id: stopper
		source: "images/stopper.png"
        x: 120
        y: 250
		opacity: 0

        Text {

                text: seconds
                font.pointSize: 11
                font.bold: true
                font.family: "Arial"
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

