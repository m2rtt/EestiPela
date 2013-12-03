# -*- coding: utf-8 -*-

# http://zetcode.com/gui/tkinter/introduction/ tkinter tutorial

# kujundus ja GUI teha PySide ja photoshopiga: http://qt-project.org/wiki/Category:LanguageBindings::PySide
# http://zetcode.com/gui/pysidetutorial/firstprograms/

from random import randint
import sys
from PySide.QtGui import *
from PySide.QtCore import *
from PySide.QtDeclarative import *


class M2ngija(QObject):
    def __init__(self):
        super(M2ngija, self).__init__()



class Kysimus(QDeclarativeItem, QObject):

    vasV2ljakutse = Signal()
    kysV2ljakutse = Signal()
    genArv = Signal()
    kysteemaV2ljakutse=Signal()

    def __init__(self):
        super(Kysimus, self).__init__()
        global kysmaatriks, vasmaatriks
        global randteema, randkysimus
        global teema
        global olnudkyslist
        global maatriksipikkus
        
        olnudkyslist = []
        
        kysmaatriks, vasmaatriks = self.kysValdkond()
        randteema, randkysimus = self.valiKysimus(kysmaatriks,vasmaatriks)
        maatriksipikkus = self.maatriksiPikkus()

    def maatriksiPikkus(self):
        maatriksipikkus = 0
        for i in kysmaatriks:
            for j in i:
                maatriksipikkus += 1
        return maatriksipikkus
                        
    def genereeriArv(self):
        randteema, randkysimus = self.valiKysimus(kysmaatriks,vasmaatriks)
        return randteema, randkysimus
        
    def valiKysimus(self, kysmaatriks, vasmaatriks):
        teemanr = randint(0,len(kysmaatriks)-1)
        kysnr = randint(0,len(kysmaatriks[teemanr])-1)
        return teemanr, kysnr
        #return kysmaatriks[teemanr][kysnr],vasmaatriks[teemanr][kysnr]   
   
    def kysimusvastus(self):    
        kysvaslist = []
        kysvaslist.append(kysmaatriks[randteema][randkysimus])
        kysvaslist.append(vasmaatriks[randteema][randkysimus])
        
        return kysvaslist
        #return kysmaatriks[x][y]+"||"+vasmaatriks[x][y]

    def kysteema(self):
        if randteema==0:
            teema="AJALUGU"
        elif randteema==1:
            teema="KULTUUR"
        elif randteema==2:
            teema="LOODUS"
        elif randteema==3:
            teema="GEOGRAAFIA"
        elif randteema==4:
            teema="SPORT"
        elif randteema==5:
            teema="VARIA"
        return teema

    kysteemanot=Property(str,kysteema,notify=kysteemaV2ljakutse)
    
    def kysToGUI(self):
        list = self.kysimusvastus()
        global olnudkyslist
        
        if len(olnudkyslist) == maatriksipikkus:
            return "Küsimused on otsas, sorry!"
        elif list[0] in olnudkyslist:
            global randteema, randkysimus
            randteema,randkysimus = self.genereeriArv()
            return self.kysToGUI()
        else:
            olnudkyslist.append(list[0])
            return list[0]
    
    def vasToGUI(self):
        list = self.kysimusvastus()
        global randteema, randkysimus
        randteema,randkysimus = self.genereeriArv()
        return list[1]        
    
    valikys = Property(str,kysToGUI,notify=kysV2ljakutse)
    valivas = Property(str,vasToGUI,notify=vasV2ljakutse)   
    

    def kysValdkond(self):
        faililist = ["tyhi","kyssad\\ajalugu.lol","kyssad\\kultuur.lol","kyssad\\loodus.lol",
                     "kyssad\\geo.lol","kyssad\\sport.lol","kyssad\\varia.lol"]
        kysimusmaatriks = []
        vastusmaatriks = []        
        for fail in range(1,len(faililist)):
            f = open(faililist[fail])
            kysimuslist = []
            vastuslist = []
            for line in f:
                kys = line[line.find('|')+1:line.find('>')]
                kysimuslist.append(kys)
                vastus = line[line.find('>')+1:].strip()
                vastuslist.append(vastus)
            f.close()
            kysimusmaatriks.append(kysimuslist)
            vastusmaatriks.append(vastuslist)
        return kysimusmaatriks, vastusmaatriks

    # valdkonnad:
    # 1 - ajalugu, 2 - kultuur, 3 - loodus, 4 - geograafia, 5 - sport, 6 - varia


class PeaAken(QDeclarativeView):

    def __init__(self, parent=None):
        super(PeaAken, self).__init__(parent)
        url = QUrl('EestiM2ng.qml')
        self.kysimus = Kysimus()
        self.m2ngija = M2ngija()

        self.rootContext().setContextProperty('proge', self)
        self.rootContext().setContextProperty('kysimus', self.kysimus)
        self.rootContext().setContextProperty('player', self.m2ngija)
        
        self.setSource(url)
           
        self.center()
        self.setFixedSize(600,340)
        tiitel = "Eesti mäng"
        self.setWindowTitle(tiitel) #millegipärast täpitäht ei tööta        
        
    def center(self):
        
        qr = self.frameGeometry()
        cp = QDesktopWidget().availableGeometry().center()
        qr.moveCenter(cp)
        self.move(qr.topLeft())
    



if __name__ == '__main__':
    
    app = QApplication(sys.argv)
    
    aken = PeaAken()
    aken.show()
    app.exec_()

    sys.exit()



