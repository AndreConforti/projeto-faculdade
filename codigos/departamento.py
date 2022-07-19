from PyQt5 import QtWidgets, uic
import mysql.connector

conex = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    password = '',
    database = 'db_faculdade',
)

def consultarDepartamento():
    cursor = conex.cursor()
    comando = 'SELECT * FROM departamento'
    cursor.execute(comando)
    resultado = cursor.fetchall()
    telaDepartamento.tblConsultaDepartamento.setRowCount(len(resultado))
    telaDepartamento.tblConsultaDepartamento.setColumnCount(2)
    telaDepartamento.fraAdiciona.setEnabled(False)
    telaDepartamento.fraOpcoes.setEnabled(False)
    
    for i in range (0, len(resultado)):
        for j in range (0, 2):
            telaDepartamento.tblConsultaDepartamento.setItem(i,j,QtWidgets.QTableWidgetItem(str(resultado[i][j])))
            print(resultado[i][j])


def adicionarDepartamento():
    telaDepartamento.fraAdiciona.setEnabled(True)











app = QtWidgets.QApplication([])

telaDepartamento = uic.loadUi('../formularios/frmDepartamento.ui')



telaDepartamento.btnConsultar.clicked.connect(consultarDepartamento)
telaDepartamento.btnAdicionar.clicked.connect(adicionarDepartamento)

telaDepartamento.show()
app.exec()



