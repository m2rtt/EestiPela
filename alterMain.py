# -*- coding: utf-8 -*-

# http://zetcode.com/gui/tkinter/introduction/ tkinter tutorial

# kujundus ja GUI teha PySide ja photoshopiga: http://qt-project.org/wiki/Category:LanguageBindings::PySide
# http://zetcode.com/gui/pysidetutorial/firstprograms/

from random import randint
import sys
from PySide.QtGui import *
from PySide.QtCore import *
from PySide.QtDeclarative import *





class Kysimus(QDeclarativeItem):

    kysV2ljakutse = Signal()
    vasV2ljakutse = Signal()
    
    def __init__(self):
        super(Kysimus, self).__init__()
        
    @Slot()
    def wat(self):
        x, y = kysimusevaldkond(randint(1,6),randint(1,10))
        if len(x) > 77:
            return x[:77]+"\n "+x[77:], y
        else:
            return x, y
        #do sth
    on_aaa = Signal()
    aaa = Property(str,wat,notify=on_aaa)

    @Slot()
    def check_answer(self):
        if y in vastus.SelectAll():
            return True
        else:
            return False
    on_bbb = Signal()
    bbb = Property(bool,check_answer,notify=on_bbb)

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
        return print(kysimusmaatriks, vastusmaatriks)

    # valdkonnad:
    # 1 - ajalugu, 2 - kultuur, 3 - loodus, 4 - geograafia, 5 - sport, 6 - varia



class PeaAken(QDeclarativeView):
   
    def __init__(self, parent=None):
        super(PeaAken, self).__init__(parent)
        url = QUrl('MyElement.qml')
        # Set the QML file and show
        self.setSource(url)
        self.rootContext().setContextProperty('proge', self)
        self.center()
        self.setFixedSize(500,340)
        tiitel = "Eesti mang"
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



