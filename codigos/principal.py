from PyQt5 import QtWidgets, uic
import mysql.connector
import faculdadeTela1
import validadorDeCPF
import departamento

# VARIÁVEIS GLOBAIS ------------------------------------------
global cpf_numerado
global cpf
global cpfCorreto 
global cpfPrimeiroDigito
global cpfSegundoDigito


# CONEXÃO AO BANCO -------------------------------------------
conex = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    password = '',
    database = 'db_faculdade',
)


# FUNÇÕES ----------------------------------------------------
def sairDoSistema():
    telaLogin.close()


def entrarNoSistema():
    login = telaLogin.txtLogin.text()
    senha = telaLogin.txtSenha.text()
    if login == 'adm' and senha == 'adm':
        telaLogin.txtLogin.setText('')
        telaLogin.txtSenha.setText('')
        telaLogin.close()
        telaLogado.show()
    else:
        telaLogin.lblAviso.setText('Usuário ou Senha inválidos')
        telaLogin.txtLogin.setText('')
        telaLogin.txtSenha.setText('')
           

def voltarAoLogin():
    telaLogado.close()
    telaLogin.show()


def cadastrarUsuario():
    telaLogin.txtLogin.setText('')
    telaLogin.txtSenha.setText('')
    telaLogin.close()
    telaCadastrarUsuario.show()


def limparCadastro():
    telaCadastrarUsuario.txtNome.setText('')
    telaCadastrarUsuario.txtCPF.setText('')
    telaCadastrarUsuario.txtLogin.setText('')
    telaCadastrarUsuario.txtSenha.setText('')
    telaCadastrarUsuario.txtSenha_2.setText('')
    telaCadastrarUsuario.lblAviso.setText('')


def cancelarCadastro():
    telaCadastrarUsuario.txtNome.setText('')
    telaCadastrarUsuario.txtCPF.setText('')
    telaCadastrarUsuario.txtLogin.setText('')
    telaCadastrarUsuario.txtSenha.setText('')
    telaCadastrarUsuario.txtSenha_2.setText('')
    telaCadastrarUsuario.close()
    telaLogin.show()


def verificarCadastro():
    global cpf
    global cpfCorreto
    global cpfNumerado
    global cpfPrimeiroDigito
    global cpfSegundoDigito

    telaCadastrarUsuario.lblAviso.setText('')
    nome = telaCadastrarUsuario.txtNome.text().upper().strip()
    cpf = telaCadastrarUsuario.txtCPF.text().replace('.', '').replace('-', '').strip()
    login = telaCadastrarUsuario.txtLogin.text().strip()
    senha = telaCadastrarUsuario.txtSenha.text()
    senha2 = telaCadastrarUsuario.txtSenha_2.text()

    cpfCorreto = quantidade()
    numerarCPF()
    cpfPrimeiroDigito = primeiroDigito()
    cpfSegundoDigito = segundoDigito()
    if cpfCorreto and cpfPrimeiroDigito and cpfSegundoDigito:
        if len(senha) >= 3 and len(senha) <= 10 and senha == senha2:
            if nome != '':
                if len(login) >= 3 and len(login) <= 10:
                    telaCadastrarUsuario.lblAviso.setText('Usuário cadastrado com sucesso')
                    telaCadastrarUsuario.txtNome.setText('')
                    telaCadastrarUsuario.txtCPF.setText('')
                    telaCadastrarUsuario.txtLogin.setText('')
                    telaCadastrarUsuario.txtSenha.setText('')
                    telaCadastrarUsuario.txtSenha_2.setText('')
                else:
                    telaCadastrarUsuario.lblAviso.setText('O campo login deve ter no mínimo 3 e no máximo 10 caracteres')
            else: 
                telaCadastrarUsuario.lblAviso.setText('Digite seu nome')
        else:
            telaCadastrarUsuario.lblAviso.setText('Senha não confere. Verifique novamente')
    else: telaCadastrarUsuario.lblAviso.setText('CPF Inválido!!!')
    print(nome)
    print(cpf)
    print(login)
    print(senha)
    print(senha2)

    
# ------------------------------------------------------------------------------------------------
# VERIFICA O TAMANHO DO CPF
def quantidade():
    if len(cpf) > 11 or len(cpf) < 11:
        return False
    else:
        return True


# NUMERAR O CPF
def numerarCPF():
    global cpfNumerado
    cpfNumerado = []
    if cpfCorreto:
        for a in cpf:
            a = int(a)
            cpfNumerado.append(a)


# APÓS RETIRAR OS PONTOS E TRAÇO, VERIFICAR A QUANTIDADE E TRANSFORMAR EM NUMEROS INTEIROS,
# É NECESSÁRIO VALIDAR O PRIMEIRO DÍGITO
def primeiroDigito():
    if cpfCorreto:
        total = 0
        controlador = 10
        for num in cpfNumerado[:9]:
            total += (num * controlador)
            controlador -= 1
        total = (total * 10) % 11
        if total == 10:
            total = 0
        if total == cpfNumerado[9]:
            return True 
        else:
            return False


# SOMENTE APÓS VERIFICAR O PRIMEIRO DÍGITO, É POSSÍVEL VERIFICAR O SEGUNDO DÍGITO
def segundoDigito():
    if cpfCorreto:
        total = 0
        controlador = 11
        for num in cpfNumerado[:10]:
            total += (num * controlador)
            controlador -= 1
        total = (total * 10) % 11
        if total == 10:
            total = 0
        if total == cpfNumerado[10]:
            return True
        else:
            return False


app = QtWidgets.QApplication([])

# -----------------------------------------------------------------------------------
# É NECESSÁRIO ASSOCIAR OS FORMULÁRIOS A UMA VARIÁVEL PARA PODER CHAMÁ-LOS NO SISTEMA

telaLogin = uic.loadUi('../formularios/frmLoginUsuario.ui')
telaLogado = uic.loadUi('../formularios/frmLogado.ui')
telaCadastrarUsuario = uic.loadUi('../formularios/frmCadastroUsuarios.ui')

# -----------------------------------------------------------------------------------
# ASSOCIANDO OS BOTÕES DOS FORMULÁRIOS PARA UMA FUNÇÃO ESPECÍFICA
# CADA BOTÃO, UMA FUNÇÃO
telaLogin.btnSair.clicked.connect(sairDoSistema)
telaLogin.btnEntrar.clicked.connect(entrarNoSistema)
telaLogin.btnCadastrar.clicked.connect(cadastrarUsuario)

telaCadastrarUsuario.btnVoltar.clicked.connect(cancelarCadastro)
telaCadastrarUsuario.btnLimpar.clicked.connect(limparCadastro)
telaCadastrarUsuario.btnCadastrar.clicked.connect(verificarCadastro)

telaLogado.btnVoltar.clicked.connect(voltarAoLogin)

# COMEÇANDO O PROGRAMA
telaLogin.show()
app.exec()