.data
	input: .space 33
	cifra: .space 33
	newline: .asciz "\n"
	key: .word 0
	

.text


	#lendo o numero do passo
	li a7,5
	ecall
	
	la t3, key 
	li t1,26
	rem t2, a0,t1
	sw t2, 0(t3)
	j ler_frase

corrigir:
	addi t2,t2,26
	ble t2,zero,corrigir
	sw t2, 0(t3)	



ler_frase:	
	#lendo a frase
	la a0,input
	li a7,8
	li a1,33
	ecall
	
	la t0, input
	la t1, cifra
	la t2, key
	lw t4, 0(t2)
	
cifrar:
    la t2, key
    lw t4, 0(t2)
    lb t2, 0(t0)        # Carregar caractere
    beqz t2, print_cifra # Se fim, imprimir
    
    # Verificar se é letra
    li t3, 'A'
    blt t2, t3, copiar  # Menor que 'A'
    li t3, 'z'
    bgt t2, t3, copiar  # Maior que 'z'
    li t3, 'Z'
    ble t2, t3, maiuscula
    li t3, 'a'
    blt t2, t3, copiar  # Entre 'Z' e 'a'
    
    # Minúscula
    add t2, t2,t4
    li t3,122
    bgt t2,t3,fix_lower	
    j guardar
 
    
maiuscula:

    add t2, t2,t4
    li t3,90
    bgt t2,t3,fix_upper	
    j guardar
    
fix_lower:
    li t6,97
    li t5,26
    rem t2,t2,t6
    rem t2, t2,t5
    addi t2,t2,97      
    j guardar
    
fix_upper:
    li t6,65
    li t5,26
    rem t2,t2,t6
    rem t2, t2,t5
    addi t2,t2,65
    j guardar
copiar:
    # Caracteres não-letra
    j guardar
    
guardar:
    sb t2, 0(t1)        # Guardar caractere processado
    addi t0, t0, 1      # Próximo caractere entrada
    addi t1, t1, 1      # Próxima posição saída
    j cifrar

	
			
print_cifra:
    	sb    zero, 0(t1)            # Adicionar o terminador nulo à string de saída
	
    	#Exibir mensagem cifrada
    	 la    a0, cifra        
   	 li    a7, 4                
   	 ecall

	#Print newLune
	la a0, newline
	li a7,4
	ecall


	li a7,10
	ecall
	