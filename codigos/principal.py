from PyQt5 import QtWidgets, uic

app = QtWidgets.QApplication([])

# É NECESSÁRIO ASSOCIAR OS FORMULÁRIOS A UMA VERIÁVEL PARA PODER CHAMÁ-LOS NO SISTEMA

telaLogin = uic.loadUi('frmLoginUsuario.ui')

telaLogin.show()
app.exec()