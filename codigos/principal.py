from PyQt5 import QtWidgets, uic
import os

app = QtWidgets.QApplication([])

# É NECESSÁRIO ASSOCIAR OS FORMULÁRIOS A UMA VARIÁVEL PARA PODER CHAMÁ-LOS NO SISTEMA

telaLogin = uic.loadUi('../formularios/frmLoginUsuario.ui')




telaLogin.show()
app.exec()