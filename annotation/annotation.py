#!/usr/bin/python
# eClub Summer Camp 2014, www.eclub.cvutmedialab.cz/contact
# Martin Kersner, m.kersner@gmail.com
# 07-25-2014
#
# GUI for annotating images

import sys
import os
import re
from PyQt4 import QtGui, QtCore

class Annotation(QtGui.QWidget):
    def __init__(self, list_of_files, path):
        super(Annotation, self).__init__()

        # initialization
        self.lof = list_of_files
        self.lof.sort()
        self.p = path
        self.counter = 1

        # gui intialization
        self.pixmap = QtGui.QPixmap(self.p + self.lof[self.counter])
        self.lbl = QtGui.QLabel(self)
        self.initUI()

    #def buttonClicked(self):
        #sender = self.sender()
        #self.statusBar().showMessage(sender.text() + ' was pressed')
        #self.close()
        #return(1)

    def keyPressEvent(self, e):
        # annotation remains same as the previous image had
        if e.key() == QtCore.Qt.Key_Return:
            print self.lof[self.counter]
            self.counter += 1
            self.pixmap.load(self.p + self.lof[self.counter])
            self.lbl.setPixmap(self.pixmap)

        # exit application
        if e.key() == QtCore.Qt.Key_Escape:
            self.close()
        
    def initUI(self):      
        hbox_main = QtGui.QHBoxLayout(self)
        hbox = QtGui.QHBoxLayout()
        vbox = QtGui.QVBoxLayout()


        # Image
        self.lbl.setPixmap(self.pixmap)
        hbox.addWidget(self.lbl)

        # Buttons
        btn_up = QtGui.QPushButton('UP', self)
        #btn_up.clicked.connect(self.buttonClicked)

        btn_down = QtGui.QPushButton('DOWN', self)
        btn_left = QtGui.QPushButton('LEFT', self)
        btn_right = QtGui.QPushButton('RIGHT', self)

        vbox.addWidget(btn_up)
        vbox.addWidget(btn_down)
        vbox.addWidget(btn_left)
        vbox.addWidget(btn_right)

        hbox_main.addLayout(hbox)
        hbox_main.addLayout(vbox)

        self.setLayout(hbox_main)
        
        #self.move(300, 200)
        self.setWindowTitle('Image Annotations')
        self.show()        

def main():
    # getting only *.png images
    input_dir = "../data/part3/"
    output_dir = "../data/part3_annotated/"
    pattern = ".png"

    list_of_files = os.listdir(input_dir)
    indices = [i for i, x in enumerate(list_of_files) if re.search(pattern, x)]
    list_of_images = [list_of_files[i] for i in indices]

    app = QtGui.QApplication(sys.argv)
    ex = Annotation(list_of_images, input_dir)
    sys.exit(app.exec_())

if __name__ == '__main__':
    main()    
