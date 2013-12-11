# -*- coding: utf-8 -*-

# kujundus ja GUI teha PySide ja photoshopiga: http://qt-project.org/wiki/Category:LanguageBindings::PySide
# http://zetcode.com/gui/pysidetutorial/firstprograms/

from random import randint
import sys
from PySide.QtGui import QDesktopWidget, QApplication
from PySide.QtCore import QObject, Signal, Property, QUrl
from PySide.QtDeclarative import QDeclarativeItem, QDeclarativeView

# tuleviku jaoks ehk, kui peaks tekkima tahtmine mängu kaugemale arendada 
# ja näiteks mitmikmäng luua või mängija seisu salvestada
class M2ngija(QObject):
    def __init__(self):
        super(M2ngija, self).__init__()


class Kysimus(QDeclarativeItem, QObject):

    vasV2ljakutse = Signal() #antakse signaal funktsiooni väljakutseks, suhtlemine qml-iga
    kysV2ljakutse = Signal()
    genArv = Signal()
    kysteemaV2ljakutse=Signal()

    def __init__(self):
        super(Kysimus, self).__init__()
        
        # terve hunnik globaalseid muutujaid, mida saaks kasutada läbi mitme funktsiooni
        global kysmaatriks, vasmaatriks
        global randteema, randkysimus
        global olnudkyslist
        global maatriksipikkus
        
        # ja anname neile juba mingid väärtused
        olnudkyslist = []  
        kysmaatriks, vasmaatriks = self.kysValdkond()
        randteema, randkysimus = self.valiKysimus()
        maatriksipikkus = self.maatriksiPikkus()

    def maatriksiPikkus(self): # maatriksi pikkuse arvutamine
        maatriksipikkus = 0
        for i in kysmaatriks:
            for j in i:
                maatriksipikkus += 1
        return maatriksipikkus                      
        
    def valiKysimus(self): #genereerib random küsimuseteema ja küsimusenumbri
        teemanr = randint(0,len(kysmaatriks)-1)
        kysnr = randint(0,len(kysmaatriks[teemanr])-1)
        return teemanr, kysnr
   
    def kysimusvastus(self):  #genereetud küsimus pannakse listi koos küsimuseteema numbriga
        kysvaslist = []
        kysvaslist.append(kysmaatriks[randteema][randkysimus])
        kysvaslist.append(vasmaatriks[randteema][randkysimus])
        return kysvaslist   
    
    def kysToGUI(self):
        list = self.kysimusvastus()
        global olnudkyslist
        
        if len(olnudkyslist) == maatriksipikkus: # kontrollime, kas erinevaid küsimusi veel leidub
            return "Küsimused on otsas, nüüd pane mäng kinni ja mine hari ennast veidi!"
        elif list[0] in olnudkyslist: # teeme nii, et üht küsimust ühe mängusessiooni jooksul mitu korda küsida ei saa
            global randteema, randkysimus
            randteema,randkysimus = self.valiKysimus() # genereerib uue küsimuse
            # self.kysteema()
            return self.kysToGUI() # ja rekursiivselt sama funktsioon
        else:
            olnudkyslist.append(list[0]) # lisab küsimuse olnud küsimuste listi ja returnib selle küsimuse
            return list[0]
    
    def vasToGUI(self): #otsitakse randomilt leitud teema ja küsimusenumbrile vastava teema ja küsimuse
        list = self.kysimusvastus() # listi liikmeteks küsimus ja vastus
        global randteema, randkysimus
        randteema,randkysimus = self.valiKysimus() # globaalsetele muutujatele uus väärtus
        return list[1] # returnib vastuse
    
    def kysteema(self): #küsimust genereerides leiab selle küsimuse teema
        if randteema==0:
            teema = "AJALUGU"
        elif randteema==1:
            teema = "KULTUUR"
        elif randteema==2:
            teema = "LOODUS"
        elif randteema==3:
            teema = "GEOGRAAFIA"
        elif randteema==4:
            teema = "SPORT"
        elif randteema==5:
            teema = "VARIA"
        return teema
    
    kysteemanot=Property(str,kysteema,notify=kysteemaV2ljakutse) # küsimuse teema var QML faili
    valikys = Property(str,kysToGUI,notify=kysV2ljakutse) # küsimuse var QML faili
    valivas = Property(str,vasToGUI,notify=vasV2ljakutse) # vastuse var QML faili  
    

    def kysValdkond(self): #loeb küsimuste tekstifailidest küsimused maatriksisse, kõige esimene funktsioon, mis valmis sai kirjutatud
        faililist = ["tyhi","andmed\\kyssad\\ajalugu.lol","andmed\\kyssad\\kultuur.lol","andmed\\kyssad\\loodus.lol",
                     "andmed\\kyssad\\geo.lol","andmed\\kyssad\\sport.lol","andmed\\kyssad\\varia.lol"]
        kysimusmaatriks = []
        vastusmaatriks = []        
        for fail in range(1,len(faililist)):
            f = open(faililist[fail])
            kysimuslist = []
            vastuslist = []
            for line in f: # string split meetodit kasutades oleks ehk kood ilusam, kuid töötab ka see väga hästi
                kys = line[line.find('|')+1:line.find('>')]
                kysimuslist.append(kys) # loeb ühest failist küsimuse ja lisab selle listi, vastusega allpool sama
                vastus = line[line.find('>')+1:].strip()
                vastuslist.append(vastus)
            f.close()
            kysimusmaatriks.append(kysimuslist) # lisab eelnevalt tekitatud küsimuste listi maatriksisse, listid teemade kaupa
            vastusmaatriks.append(vastuslist)
        return kysimusmaatriks, vastusmaatriks

    # valdkonnad:
    # 1 - ajalugu, 2 - kultuur, 3 - loodus, 4 - geograafia, 5 - sport, 6 - varia


class PeaAken(QDeclarativeView):

    def __init__(self, parent=None):
        super(PeaAken, self).__init__(parent)
        url = QUrl('andmed\\huh.wat') #kasutab qml-faili, random nimi
        self.kysimus = Kysimus() # viide küsimuse klassile
        self.m2ngija = M2ngija()

        self.rootContext().setContextProperty('proge', self) # määrab ära need märksõnad, mille kaudu saab QMLis kasutada .py klasse
        self.rootContext().setContextProperty('kysimus', self.kysimus)
        self.rootContext().setContextProperty('player', self.m2ngija)
        
        self.setSource(url) # määrame akna sisu allika
           
        self.center() # paigutame selle akna keskele
        self.setFixedSize(600,340) #setib programmi akna
        tiitel = "Eesti mäng"
        self.setWindowTitle(tiitel)
        
    def center(self): # programmi aken ekraani keskele
        
        qr = self.frameGeometry()
        cp = QDesktopWidget().availableGeometry().center()
        qr.moveCenter(cp)
        self.move(qr.topLeft())
    



if __name__ == '__main__':
    
    app = QApplication(sys.argv)
    
    aken = PeaAken()
    aken.show() # kuvame akna
    app.exec_()

    sys.exit()



