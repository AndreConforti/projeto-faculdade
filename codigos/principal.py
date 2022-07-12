from PyQt5 import QtWidgets, uic
import validadorDeCPF

# FUNÇÕES ----------------------------------------------------
def sairDoSistema():
    telaLogin.close()


def entrarNoSistema():
    login = telaLogin.txtLogin.text()
    senha = telaLogin.txtSenha.text()
    if login == 'andre' and senha == '123':
        telaLogin.txtLogin.setText('')
        telaLogin.txtSenha.setText('')
        telaLogin.close()
        telaLogado.show()
    else:
        telaLogin.lblAviso.setText('Usuário e Senha incorretos')


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


def cancelarCadastro():
    telaCadastrarUsuario.txtNome.setText('')
    telaCadastrarUsuario.txtCPF.setText('')
    telaCadastrarUsuario.txtLogin.setText('')
    telaCadastrarUsuario.txtSenha.setText('')
    telaCadastrarUsuario.txtSenha_2.setText('')
    telaCadastrarUsuario.close()
    telaLogin.show()


def verificarCadastro():
    nome = telaCadastrarUsuario.txtNome.text()
    cpf = telaCadastrarUsuario.txtCPF.text().replace('.', ',').replace('-', '').strip()
    login = telaCadastrarUsuario.txtLogin.text()
    senha = telaCadastrarUsuario.txtSenha.text()
    senha2 = telaCadastrarUsuario.txtSenha_2.text()
    print(nome)
    print(cpf)
    print(login)
    print(senha)
    print(senha2)

    telaCadastrarUsuario.lblAviso.setText("verificar o CPF e se as senhas são iguais")
    telaCadastrarUsuario.txtNome.setText('')
    telaCadastrarUsuario.txtCPF.setText('')
    telaCadastrarUsuario.txtLogin.setText('')
    telaCadastrarUsuario.txtSenha.setText('')
    telaCadastrarUsuario.txtSenha_2.setText('')


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

telaCadastrarUsuario.btnCancelar.clicked.connect(cancelarCadastro)
telaCadastrarUsuario.btnLimpar.clicked.connect(limparCadastro)
telaCadastrarUsuario.btnCadastrar.clicked.connect(verificarCadastro)

telaLogado.btnVoltar.clicked.connect(voltarAoLogin)

# COMEÇANDO O PROGRAMA
telaLogin.show()
app.exec()