# -*- coding: utf-8 -*-

# http://zetcode.com/gui/tkinter/introduction/ tkinter tutorial

# kujundus ja GUI teha PySide ja photoshopiga: http://qt-project.org/wiki/Category:LanguageBindings::PySide
# http://zetcode.com/gui/pysidetutorial/firstprograms/

from random import randint
import sys
from PySide.QtGui import *
from PySide.QtCore import *
from PySide.QtDeclarative import QDeclarativeView
import MyElement.qml


def kysimusevaldkond(fail, kys_id):
    faililist = ["tyhi","kyssad\\ajalugu.lol","kyssad\\kultuur.lol","kyssad\\loodus.lol",
                 "kyssad\\geo.lol","kyssad\\sport.lol","kyssad\\varia.lol"]
    f = open(faililist[fail])
    kysimuslist = []
    vastuslist = []
    for line in f:
        kys = line[line.find('|')+1:line.find('>')]
        kysimuslist.append(kys)
        vastus = line[line.find('>')+1:].strip()
        vastuslist.append(vastus)
    f.close()
    return kysimuslist[kys_id], vastuslist[kys_id]
    # valdkonna usage:
    # kysimusevaldkond(valdkond, kĆ¼simuse id)
    # valdkonnad:
    # 1 - ajalugu, 2 - kultuur, 3 - loodus, 4 - geograafia, 5 - sport, 6 - varia



class Programm(QWidget):

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

    def __init__(self):
        super(Programm, self).__init__()
        
        self.initUI()


    def initUI(self):
        global view               
        view = QDeclarativeView()
        # Create an URL to the QML file
        url = QUrl('MyElement.qml')
        # Set the QML file and show
        view.setSource(url)
        view.rootContext().setContextProperty('proge', self)
        self.center()
        view.setFixedSize(500,340)
        tiitel = "Eesti mäng"
        view.setWindowTitle(tiitel) #millegipärast täpitäht ei tööta
        view.show()

        
    def center(self):
        
        qr = self.frameGeometry()
        cp = QDesktopWidget().availableGeometry().center()
        qr.moveCenter(cp)
        self.move(qr.topLeft())
    



def main():
    
    app = QApplication(sys.argv)
    ex = Programm()
    app.exec_()

    sys.exit(app.exec_())


if __name__ == '__main__':
    main()




