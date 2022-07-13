package main

import "fmt"

/* VERIFICA O TAMANHO DO CPF */
func quantidade(valor string) bool{
	if len(valor) > 11 || len(valor) < 11{
		fmt.Println("O CPF é inválido por há", len(valor), "números")
		return false
	} else {
		return true
	}
} 

/* NUMERA O CPF */
func numeraCPF() {
	if cpfCorreto{
		for _, a := range cpf{
			a = int(a)
			cpfNumerado.append(a)
		}

	}
	print(cpfNumerado)
}





func main(){

	cpf := "25874525836"
	
	cpfCorreto := quantidade(cpf)
	print(cpfCorreto)
	
	/*cpfNumerado := []int{}*/



}
