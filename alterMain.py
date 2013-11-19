# -*- coding: utf-8 -*-

# http://zetcode.com/gui/tkinter/introduction/ tkinter tutorial

# kujundus ja GUI teha PySide ja photoshopiga: http://qt-project.org/wiki/Category:LanguageBindings::PySide
# http://zetcode.com/gui/pysidetutorial/firstprograms/

from random import randint
import sys
from PySide.QtGui import *
from PySide.QtCore import *
from PySide.QtDeclarative import *



class Kysimus(QDeclarativeItem, QObject):

    vasV2ljakutse = Signal()
    kysV2ljakutse = Signal() 
    def __init__(self):
        super(Kysimus, self).__init__()
        global kysmaatriks, vasmaatriks
        kysmaatriks, vasmaatriks = self.kysValdkond()

        
    def valiKysimus(self, kysmaatriks, vasmaatriks):
        teemanr = randint(0,len(kysmaatriks)-1)
        kysnr = randint(0,len(kysmaatriks[teemanr])-1)
        return teemanr, kysnr   
   
    def kysimusvastus(self):
        x,y = self.valiKysimus(kysmaatriks, vasmaatriks)
        kysvaslist = []
        kysvaslist.append(x)
        kysvaslist.append(y)
        #return kysvaslist
        return kysmaatriks[x][y]+"||"+vasmaatriks[x][y]
    def kysToGUI(self):
        a = 1
        
    
    valikys = Property(str,kysimusvastus,notify=kysV2ljakutse)   
    

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
        url = QUrl('MyElement.qml')
        self.kysimus = Kysimus()

        self.rootContext().setContextProperty('proge', self)
        self.rootContext().setContextProperty('kysimus', self.kysimus)
        
        self.setSource(url)
           
        self.center()
        self.setFixedSize(500,340)
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



