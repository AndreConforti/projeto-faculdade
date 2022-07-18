import mysql.connector

'''
PRINCÍPIOS BÁSICOS
    
    CRIA A CONEXÃO
        INVOCA O MYSQL CONNECTOR
            HOST
            USER
            PASSWORD
            DATABASE
    
    INVOCA O CURSOR
        CRIA O COMANDO
        EXECUTA O COMANDO
            SE FOR COMANDO PARA EDITAR
                EXECUTA UM COMMIT()
            SE FOR UM COMANDO PARA LER OU CONSULTAR
                EXECUTA UM FETCHALL()
    
    FECHA O CURSOR

    FECHA A CONEXÃO
'''

conex = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    password = '',
    database = 'db_faculdade',
)
cursor = conex.cursor()

comando = 'SELECT * FROM aluno'
cursor.execute(comando)
resultado = cursor.fetchall()

for nome in resultado:
    print(nome)



cursor.close()
conex.close()
