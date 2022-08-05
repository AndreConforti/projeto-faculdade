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
    telaDepartamento.fraOpcoes.setEnabled(True)
    
    for i in range (0, len(resultado)):
        for j in range (0, 2):
            telaDepartamento.tblConsultaDepartamento.setItem(i,j,QtWidgets.QTableWidgetItem(str(resultado[i][j])))
            print(resultado[i][j])

    cursor.close()


def adicionarDepartamento():
    telaDepartamento.fraAdiciona.setEnabled(True)
    telaDepartamento.lblAviso.setText('')


def enviarNovoDepartamento():
    nome_departamento = telaDepartamento.txtNome.text().strip()
    if len(nome_departamento) > 0:
        cursor = conex.cursor()
        comando = f'INSERT INTO departamento (nome_departamento) VALUES ("{nome_departamento}")'
        cursor.execute(comando)
        conex.commit()
        cursor.close()
        telaDepartamento.txtNome.setText('')
        telaDepartamento.fraAdiciona.setEnabled(False)
        telaDepartamento.lblAviso.setText('CADASTRADO COM SUCESSO')
    else:
        telaDepartamento.lblAviso.setText('ERRO. Tente novamente')
        telaDepartamento.fraAdiciona.setEnabled(False)


def sairDepartamento():
    conex.close()
    telaDepartamento.close() 


def chama_departamento():
    app = QtWidgets.QApplication([])

    telaDepartamento = uic.loadUi('../formularios/frmDepartamento.ui')

    telaDepartamento.btnConsultar.clicked.connect(consultarDepartamento)
    telaDepartamento.btnAdicionar.clicked.connect(adicionarDepartamento)
    telaDepartamento.btnEnviar.clicked.connect(enviarNovoDepartamento)
    telaDepartamento.btnVoltar.clicked.connect(sairDepartamento)

    telaDepartamento.show()
    app.exec()

global telaDepartamento

