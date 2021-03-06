#!/usr/bin/python
# eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
# Martin Kersner, m.kersner@gmail.com
# 07-25-2014
#
# GUI for annotating images
#
# 1 UP
# 2 DOWN
# 3 LEFT
# 4 RIGHT

import sys
import os
import re
from shutil import copy
from PyQt4 import QtGui, QtCore

class Annotation(QtGui.QWidget):
    def __init__(self, list_of_files, input_path, input_path2, output_path):
        super(Annotation, self).__init__()

        # initialization
        self.lof = list_of_files
        self.lof.sort()
        self.p = input_path
        self.p2 = input_path2
        self.op = output_path
        self.counter = 0

        self.rotations = {'UPLEFT': 1, 'UP': 2, 'UPRIGHT': 3, 'LEFT': 4, 'RIGHT': 5, 'DOWNLEFT': 6, 'DOWN': 7, 'DOWNRIGHT': 8, 'NOTHING': 9}

        # initialization of status
        init_status = 'UP'
        self.status = self.rotations[init_status]
        self.status_lbl = QtGui.QLabel(init_status)
        self.status_lbl.setAlignment(QtCore.Qt.AlignCenter)

        # GUI intialization
        self.pixmap = QtGui.QPixmap(self.p + self.lof[self.counter].split('-')[1])
        self.lbl = QtGui.QLabel(self)

        self.pixmap2 = QtGui.QPixmap(self.p2 + self.lof[self.counter])
        self.lbl2 = QtGui.QLabel(self)

        self.initUI()

    def process(self):
        # save annotation
        src_file = self.p2 + self.lof[self.counter]
        dst_file = self.op + str(self.status) + '-' + self.lof[self.counter]
        copy(src_file, dst_file)

        print dst_file

        self.refreshImages()
        
    def refreshImages(self):
        # load new images
        self.pixmap.load(self.p + self.lof[self.counter].split('-')[1])
        self.lbl.setPixmap(self.pixmap)

        self.pixmap2.load(self.p2 + self.lof[self.counter])
        self.lbl2.setPixmap(self.pixmap2)

        # increasing index in list of all images
        self.counter += 1

    def buttonClicked(self):
        sender = self.sender()
        text_btn = sender.text()
        self.status_lbl.setText(text_btn)
        self.status = self.rotations[str(text_btn)] 

        self.process()

    def keyPressEvent(self, e):
        # annotation remains same as the previous image had
        if e.key() == QtCore.Qt.Key_Return:
            self.process()

        # exit application
        if e.key() == QtCore.Qt.Key_Escape:
            self.close()
        
    def initUI(self):      
        hbox_main = QtGui.QHBoxLayout(self)
        hbox = QtGui.QHBoxLayout()
        grid = QtGui.QGridLayout()

        # Image
        self.lbl.setPixmap(self.pixmap)
        self.lbl2.setPixmap(self.pixmap2)
        hbox.addWidget(self.lbl)
        hbox.addWidget(self.lbl2)

        # Buttons
        btn_up = QtGui.QPushButton('UP', self)
        btn_down = QtGui.QPushButton('DOWN', self)
        btn_left = QtGui.QPushButton('LEFT', self)
        btn_right = QtGui.QPushButton('RIGHT', self)

        # Extented Buttons
        btn_up_left = QtGui.QPushButton('UPLEFT', self)
        btn_up_right = QtGui.QPushButton('UPRIGHT', self)
        btn_down_left = QtGui.QPushButton('DOWNLEFT', self)
        btn_down_right = QtGui.QPushButton('DOWNRIGHT', self)

        btn_nothing = QtGui.QPushButton('NOTHING', self)

        # Connection Buttons
        btn_up.clicked.connect(self.buttonClicked)
        btn_down.clicked.connect(self.buttonClicked)
        btn_left.clicked.connect(self.buttonClicked)
        btn_right.clicked.connect(self.buttonClicked)

        btn_up_left.clicked.connect(self.buttonClicked)
        btn_up_right.clicked.connect(self.buttonClicked)
        btn_down_left.clicked.connect(self.buttonClicked)
        btn_down_right.clicked.connect(self.buttonClicked)

        btn_nothing.clicked.connect(self.buttonClicked)

        # Label
        grid.addWidget(self.status_lbl, 0, 1)
    
        # Layouts
        grid.addWidget(btn_up_left, 1, 0)
        grid.addWidget(btn_up, 1, 1)
        grid.addWidget(btn_up_right, 1, 2)

        grid.addWidget(btn_left, 2, 0)
        grid.addWidget(btn_nothing, 2, 1)
        grid.addWidget(btn_right, 2, 2)

        grid.addWidget(btn_down_left, 3, 0)
        grid.addWidget(btn_down, 3, 1)
        grid.addWidget(btn_down_right, 3, 2)

        hbox_main.addLayout(hbox)
        hbox_main.addLayout(grid)

        self.setLayout(hbox_main)
        
        self.setWindowTitle('Image Annotations')
        self.show()        

def main():
    # preparing input and output paths
    input_dir = '../data/part3'
    input_dir2 = input_dir + '_dataset/'
    output_dir = input_dir + '_annotated/'
    input_dir = input_dir + '/'
    
    # creating output directory
    if not os.path.exists(output_dir):
            os.makedirs(output_dir)

    # getting only *.png images
    pattern = '.png'
    list_of_files = os.listdir(input_dir2)
    indices = [i for i, x in enumerate(list_of_files) if re.search(pattern, x)]
    list_of_images = [list_of_files[i] for i in indices]

    app = QtGui.QApplication(sys.argv)
    ex = Annotation(list_of_images, input_dir, input_dir2, output_dir)
    sys.exit(app.exec_())

if __name__ == '__main__':
    main()    
