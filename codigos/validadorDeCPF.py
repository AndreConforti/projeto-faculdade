

# VERIFICA O TAMANHO DO CPF
def quantidade():
    if len(cpf) > 11 or len(cpf) < 11:
        print(f'O CPF é inválido pois há {len(cpf)} números')
        return False
    else:
        return True


# NUMERAR O CPF
def numerarCPF():
    if cpfCorreto:
        for a in cpf:
            a = int(a)
            cpf_numerado.append(a)


# APÓS RETIRAR OS PONTOS E TRAÇO, VERIFICAR A QUANTIDADE E TRANSFORMAR EM NUMEROS INTEIROS,
# É NECESSÁRIO VALIDAR O PRIMEIRO DÍGITO
def primeiroDigito():
    if cpfCorreto:
        total = 0
        controlador = 10
        for num in cpf_numerado[:9]:
            total += (num * controlador)
            controlador -= 1
        total = (total * 10) % 11
        if total == 10:
            total = 0
        if total == cpf_numerado[9]:
            return True 
        else:
            return False


# SOMENTE APÓS VERIFICAR O PRIMEIRO DÍGITO, É POSSÍVEL VERIFICAR O SEGUNDO DÍGITO
def segundoDigito():
    if cpfCorreto:
        total = 0
        controlador = 11
        for num in cpf_numerado[:10]:
            total += (num * controlador)
            controlador -= 1
        total = (total * 10) % 11
        if total == 10:
            total = 0
        if total == cpf_numerado[10]:
            return True
        else:
            return False


cpf_numerado = []
#cpf = str(input("Digite o CPF : ")).replace('.', ',').replace('-', '').strip()
cpf = '27875969832'


cpfCorreto = quantidade()

cpfFormatado1 = cpf_numerado[:3]
print(cpfFormatado1)

numerarCPF()

cpfPrimeiroDigito = primeiroDigito()
cpfSegundoDigito = segundoDigito()

if cpfCorreto and cpfPrimeiroDigito and cpfSegundoDigito:
    print('CPF ', end='')
    for i, v in enumerate(cpf_numerado):
        print(f'{v}', end='')
        if i == 2 or i == 5:
            print('.', end='')
        if i == 8:
            print('-', end='')
    print(' válido!!!')
else:
    print("CPF Inválido!!!")


