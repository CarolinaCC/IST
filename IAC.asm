; **********************************************************************
; **********************************************************************
; 													********************
;	 ENTREGA PROJETO TETRIS INVADERS	            ********************
; 													********************
; **********************************************************************
;													
; GRUPO 26
;													
; **********************************************************************
; * Constantes
; **********************************************************************
	
LINHA   EQU 8       ; Posicao do bit correspondente à linha (4) a testar (rotina teclado)
PIN  	EQU 0E000H  ; Endereco de entrada do teclado
POUT1 	EQU 0A000H	; Displays
POUT2 	EQU 0C000H  ; Endereco de escrita do teclado
screen  EQU 8000H   ; Endereco de entrada de pixel screen

; **********************************************************************
; * MEMORIA (variaveis)
; **********************************************************************.

PLACE 3000H


pilha:
	TABLE 0300H
fim_pilha:

tab:        WORD    rot0			; Tabela interrupcoes
			WORD    rot1


BUFFERL:
		STRING 0100H				; Enderenco onde se guarda a linha (rotina teclado)
			
ultima_tecla_pressa: WORD 0H		
tecla_pressa: WORD 0H				; Endereco onde guarda a tecla efetivamente pressa

linha_tetramino: WORD 0
coluna_tetramino: WORD 5			; Linha e coluna do ultimo tetramino desenhado


tetramino_forma: WORD 0				; Forma tetramino na rotacao (0-3)

coluna_monstro: WORD 25				; Ultima posicao do monstro

counter: WORD 2

counter_fim_jogo: WORD 0 			; variavel para saber quando o jogo acaba

escolher_tetraminos:     			; Tabela para escolher o tetramino a desenhar (0-7)
	WORD t_word_alto				; (da rotina Random)
	WORD line_word_alto
	WORD s_word_alto
	WORD z_word_alto
	WORD L_word_alto
	WORD J_word_alto
	WORD O_word
	WORD t_word_alto


; **********************************************************************
; * METADADOS TETRAMINOS
; **********************************************************************

t_word_alto:
	STRING 4, 4
	STRING 0,1,0,0
	STRING 1,1,1,0
	STRING 0,0,0,0
	STRING 0,0,0,0

	STRING 4, 4
	STRING 1,0,0,0
	STRING 1,1,0,0
	STRING 1,0,0,0
	STRING 0,0,0,0
	
	STRING 4,4
	STRING 1,1,1,0 
	STRING 0,1,0,0
	STRING 0,0,0,0
	STRING 0,0,0,0
	
	STRING 4,4
	STRING 0,1,0,0
	STRING 1,1,0,0
	STRING 0,1,0,0
	STRING 0,0,0,0

; ************************************
	
line_word_alto:
	STRING 4,4
	STRING 1,0,0,0
	STRING 1,0,0,0
	STRING 1,0,0,0
	STRING 1,0,0,0
	
	STRING 4,4
	STRING 1,1,1,1
	STRING 0,0,0,0
	STRING 0,0,0,0
	STRING 0,0,0,0
	
	STRING 4,4
	STRING 1,0,0,0
	STRING 1,0,0,0
	STRING 1,0,0,0
	STRING 1,0,0,0
	
	STRING 4,4
	STRING 1,1,1,1
	STRING 0,0,0,0
	STRING 0,0,0,0
	STRING 0,0,0,0

; ************************************
	
s_word_alto:
	STRING 4,4
	STRING 0,1,1,0
	STRING 1,1,0,0
	STRING 0,0,0,0
	STRING 0,0,0,0
	
	STRING 4,4
	STRING 1,0,0,0
	STRING 1,1,0,0
	STRING 0,1,0,0
	STRING 0,0,0,0

	STRING 4,4
	STRING 1,0,0,0
	STRING 1,1,0,0
	STRING 0,1,0,0
	STRING 0,0,0,0

	STRING 4,4
	STRING 1,0,0,0
	STRING 1,1,0,0
	STRING 0,1,0,0
	STRING 0,0,0,0
	
; ************************************

z_word_alto:
	STRING 4,4
	STRING 1,1,0,0
	STRING 0,1,1,0
	STRING 0,0,0,0
	STRING 0,0,0,0
	
	STRING 4,4
	STRING 0,1,0,0
	STRING 1,1,0,0
	STRING 1,0,0,0
	STRING 0,0,0,0

	STRING 4,4
	STRING 1,1,0,0
	STRING 0,1,1,0
	STRING 0,0,0,0
	STRING 0,0,0,0
	
	STRING 4,4
	STRING 0,1,0,0
	STRING 1,1,0,0
	STRING 1,0,0,0
	STRING 0,0,0,0

; ************************************

L_word_alto:
	STRING 4,4
	STRING 1,0,0,0
	STRING 1,0,0,0
	STRING 1,1,0,0
	STRING 0,0,0,0
	
	STRING 4,4
	STRING 1,1,1,0
	STRING 1,0,0,0
	STRING 0,0,0,0
	STRING 0,0,0,0
	
	STRING 4,4
	STRING 1,1,0,0
	STRING 0,1,0,0
	STRING 0,1,0,0
	STRING 0,0,0,0
	
	STRING 4,4
	STRING 0,0,1,0
	STRING 1,1,1,0
	STRING 0,0,0,0
	STRING 0,0,0,0
	
; ************************************

J_word_alto:
	STRING 4,4
	STRING 0,1,0,0
	STRING 0,1,0,0
	STRING 1,1,0,0
	STRING 0,0,0,0
	
	STRING 4,4
	STRING 1,0,0,0
	STRING 1,1,1,0
	STRING 0,0,0,0
	STRING 0,0,0,0
	
	STRING 4,4
	STRING 1,1,0,0
	STRING 1,0,0,0
	STRING 1,0,0,0
	STRING 0,0,0,0
	
	STRING 4,4
	STRING 1,1,1,0
	STRING 0,0,1,0
	STRING 0,0,0,0
	STRING 0,0,0,0
	
; ************************************

O_word:					
	STRING 4,4 			
	STRING 1,1,0,0
	STRING 1,1,0,0
	STRING 0,0,0,0
	STRING 0,0,0,0

	STRING 4,4 			
	STRING 1,1,0,0
	STRING 1,1,0,0
	STRING 0,0,0,0
	STRING 0,0,0,0

	STRING 4,4 			
	STRING 1,1,0,0
	STRING 1,1,0,0
	STRING 0,0,0,0
	STRING 0,0,0,0

	STRING 4,4 			
	STRING 1,1,0,0
	STRING 1,1,0,0
	STRING 0,0,0,0
	STRING 0,0,0,0
	
; ************************************	

monstro_word:
	STRING 4,4
	STRING 1,0,1,0
	STRING 0,1,0,0
	STRING 1,0,1,0
	STRING 0,0,0,0
	STRING 0



; **********************************************************************
; Mascaras para selecionar o pixel a escrever/apagar (rotina pixel_screen)
mascaras:	
	nibble_7: WORD 080h  ; 10000000
	nibble_6: WORD 040h  ; 01000000
	nibble_5: WORD 020h  ; 00100000
	nibble_4: WORD 010h  ; 00010000
	nibble_3: WORD 08h   ; 00001000
	nibble_2: WORD 04h   ; 00000100
	nibble_1: WORD 02h   ; 00000010
	nibble_0: WORD 01h   ; 00000001


	
; ************************************
; Ecra inicial (rotina escreve_ecra) 
; 'TETRIS INVADERS
;      PRESS 
;	 --> B <--'
welcome:
	STRING 00H,00H,00H,00H     ;0 	
	STRING 3EH,0EFH,0BDH,7CH   ;1 
	STRING 08H,82H,25H,40H     ;2                   
	STRING 08H,0E2H,39H,7CH    ;3                   
    STRING 08H,82H,29H,04H     ;4                   
    STRING 08H,0E2H,25H,7CH    ;5                   
    STRING 00H,00H,00H,00H     ;6                   
    STRING 0A2H,0AEH,0CEH,0EFH ;7                   
    STRING 0B2H,0AAH,0A8H,0A8H ;8                   
    STRING 0AAH,0AEH,0AEH,0CFH ;9                   
	STRING 0A6H,0AAH,0A8H,0A1H ;10                   
	STRING 0A2H,4AH,0CEH,0AFH  ;11                   
	STRING 00H,00H,00H,00H     ;12                   
	STRING 00H,00H,00H,00H     ;13                   
	STRING 7CH,0FBH,0EFH,0BEH  ;14                   
	STRING 42H,8AH,08H,20H     ;15                   
	STRING 42H,92H,08H,20H     ;16                   
	STRING 42H,0A3H,0EFH,0BEH  ;17                   
	STRING 7CH,0C2H,00H,82H    ;18                   
	STRING 40H,0A2H,00H,82H    ;19                  
	STRING 40H,92H,00H,82H     ;20                   
	STRING 40H,8BH,0EFH,0BEH   ;21                  
	STRING 00H,00H,00H,00H     ;22                  
	STRING 08H,0FH,0C0H,10H    ;23                   
	STRING 0CH,08H,20H,30H     ;24                   
	STRING 0F2H,08H,20H,4FH    ;25                   
	STRING 81H,0FH,0C0H,81H    ;26                  
	STRING 0F2H,08H,20H,4FH    ;27                  
	STRING 0CH,08H,20H,30H     ;28                   
    STRING 08H,0FH,0C0H,10H    ;29                  
	STRING 00H,00H,00H,00H     ;30                  
	STRING 00H,00H,00H,00H     ;31  



; ************************************
; Ecra fim de jogo (rotina escreve_ecra) 
; 	   'GAME
;     	OVER
;	   AGAIN? 
;	 --> A <--'	
game_over:
	STRING 00H,00H,00H,00H    ;0 	
	STRING 3FH,7EH,82H,0F8H   ;1 
	STRING 20H,42H,0C6H,80H   ;2 
	STRING 20H,42H,0AAH,80H   ;3 
	STRING 27H,7EH,92H,0F8H   ;4 
	STRING 21H,42H,82H,80H    ;5 
	STRING 21H,42H,82H,80H    ;6 
	STRING 3FH,42H,82H,0F8H   ;7 
	STRING 00H,00H,00H,00H    ;8 
	STRING 00H,00H,00H,00H    ;9 
	STRING 3FH,42H,0FEH,0F8H ;10 
	STRING 21H,42H,80H,84H   ;11 
	STRING 21H,42H,80H,84H   ;12 
	STRING 21H,42H,0FEH,88H  ;13 
	STRING 21H,42H,80H,0F0H  ;14 
	STRING 21H,42H,80H,88H   ;15 
	STRING 21H,24H,80H,84H   ;16 
	STRING 3FH,18H,0FEH,84H  ;17 
	STRING 00H,00H,00H,00H   ;18 
	STRING 3DH,0EFH,50H,0BEH ;19
	STRING 25H,09H,58H,0A2H  ;20 
	STRING 25H,09H,54H,8EH   ;21
	STRING 3DH,6FH,52H,88H   ;22
	STRING 25H,29H,51H,80H   ;23 
	STRING 25H,0E9H,50H,88H  ;24 
	STRING 00H,00H,00H,00H   ;25 
	STRING 08H,07H,0C0H,10H  ;26
	STRING 74H,04H,40H,2EH   ;27
	STRING 42H,04H,40H,42H   ;28 
	STRING 74H,07H,0C0H,2EH  ;29
	STRING 08H,04H,40H,10H   ;30
	STRING 00H,04H,40H,00H   ;31



; **********************************************************************
; * Inicializações gerais
; **********************************************************************
PLACE 0000H
inicio:		
	MOV  SP, fim_pilha
	MOV  BTE, tab
	
	
; **********************************************************************
; *     Corpo principal do programa
; **********************************************************************

	CALL escreve_ecra					;chama a rotina que vai escrever a mensagem inicial no pixel screen
ecra_inicial:
	
	CALL teclado_x
	MOV R1, tecla_pressa		
	MOV R2, [R1]	
	MOV R0, 0BH				
	CMP R2, R0							;quando a tecla B é pressionada prossegue-se para ciclo
	JNZ ecra_inicial
	

	CALL limpa_pixel_screen				
	CALL desenha_barra
	MOV R0, z_word_alto
	CALL desenha_tetramino_x
	EI
	EI0 
	EI1
	
ciclo:
	CALL teclado_x							;identifica se alguma tecla foi pressioanda e e sim qual
	CALL mexer_tetramino					;faz as respetivas movimentacoes dos tetraminos
	CALL verifica_fim_jogo					;confirma se o jogo terminou e se se pode avancar para o ecra de final de jogo
	
	JMP ciclo
	




; **********************************************************************
; 							ROTINAS
; **********************************************************************


; ******************************************************************
; Rotina para mover o tetramino no pixel screen (mexer_tetramino)
; INPUT - ND (tecla_pressa da rotina teclado)
; OUTPUT - ND (atualiza variaveis em memoria: coluna_tetramino/tetramino_forma)
; ******************************************************************

mexer_tetramino:
	PUSH R1
	PUSH R2
	PUSH R4
	MOV R1, tecla_pressa
	MOV R2, [R1]			; ve a ultima tecla pressa

	MOV R3, 0FFH			
	CMP R2, R3				; compara, se for 0FFH nenhuma tecla foi pressa
	JZ sair_mexer_tetramino ;  e sair da rotina

	CMP R2,	0H
	JZ esquerda				; tecla 0 anda para a esquerda 
	CMP R2, 02H
	JZ direita				; tecla 2 anda para a direita 
	CMP R2, 1H
	JZ roda					; tecla 1 roda 

sair_mexer_tetramino:
	POP R4
	POP R2
	POP R1
	RET

esquerda:
	MOV R0, z_word_alto		; para a rotina int_apaga_tetramino_x
	MOV R10, coluna_tetramino
	MOV R1, [R10]
	CMP R1, 0H
	JZ sair_mexer_tetramino
	CALL int_apaga_tetramino_x
	
	MOV R10, coluna_tetramino
	MOV R1, [R10]
	SUB R1, 1					; actualiza a coluna_tetramino para desenhar o tetramino 
	MOV [R10], R1				;    uma casa a esquerda 
	
	CALL desenha_tetramino_x
	JMP sair_mexer_tetramino
	
direita:
	MOV R0, z_word_alto		; para a rotina int_apaga_tetramino_x
	MOV R10, coluna_tetramino
	MOV R1, [R10]
	MOV R5, 0AH
	CMP R1, R5
	JZ sair_mexer_tetramino
	CALL int_apaga_tetramino_x
	
	MOV R10, coluna_tetramino
	MOV R1, [R10]
	ADD R1, 1					; actualiza a coluna_tetramino para desenhar o tetramino 
	MOV [R10], R1				;     uma casa a direita 
	
	CALL desenha_tetramino_x
	JMP sair_mexer_tetramino

roda:
	MOV R0, z_word_alto
	CALL int_apaga_tetramino_x
	MOV R10, tetramino_forma	
	MOV R1, [R10]			
	CMP R1, 3					; ve se ja esta na ultima posicao (3)
	JZ atualiza_roda 				
	ADD R1, 1					; se nao actualiza o tetramino_forma para desenhar o tetramino 
	MOV [R10], R1				;     na posicao seguinte 
	
fim_roda:
	CALL desenha_tetramino_x
	JMP sair_mexer_tetramino

atualiza_roda:				
	MOV R1, 0					; se já tivermos chegado a ultima posica (3) volta a primeira (0)
	MOV [R10], R1				; e atualiza em memoria 
	JMP fim_roda



; ******************************************************************
;   Rotina que deteta a linha e a coluna da tecla premida (teclado_x)
;   INPUT - ND (de memoria LINHA)
;   OUTPUT - R4 (coluna), actualiza BUFFERL (linha)
; ******************************************************************

teclado_x:
	MOV  R1, LINHA    		  ; testar a linha 4 
	MOV  R2, PIN      		  ; R2 com o endereço de entrada do teclado
	MOV	 R7, tecla_pressa	  ; endereco de memoria onde vai guardar a tecla efetivamente pressa
	MOV  R8, POUT2    		  ; R8 com o enderenço de saida do teclado
		
teclado:
    MOVB [R8],R1        ; escrever no periferico no teclado
    MOVB R3, [R2]       ; le coluna
    AND  R3, R3  	    ; ver se alguma tecla foi pressa
	JZ 	 muda           ; nenhuma tecla pressa vai para ciclo para mudar de linha
	MOV  R4, R3         ; guarda coluna
	MOV  R5, BUFFERL
	MOVB [R5], R1		; guardar linha
	JMP  muda  
	
muda:
	SHR R1, 1           ; vai ver a proxima linha
	AND R1,R1			; se a proxima linha for zero
	JNZ teclado		    ; se a proxima linha nao for zero continua a analizar       
	MOV R1, LINHA
	CALL calcula_tecla_guarda
	RET

	
; *******************************************************************
;   Rotina que calcula e manda o valor da tecla clicada para o tecla_pressa
; 	INPUT - R4 (coluna); BUFFERL(linha)
;   OUTPUT - ND (em memória tecla_pressa)
; *******************************************************************
calcula_tecla_guarda:
	PUSH R1					
	PUSH R2
	CMP R4, 0000          	; saber se a tecla foi premida
	JNZ calc_tecla
	MOV R10, 0FFH			; escrever se nenhuma tecla foi pressa
	JMP escreve_memoria
	
; *****************************************
; 	Calcula o numero da tecla
; *****************************************

calc_tecla:					
	CALL calcula_tecla    ; para saber a linha 0...3
	MOV R9, R11
	MOV R0,  BUFFERL
	MOVB R4, [R0]         ; para saber a coluna 0...3
	CALL calcula_tecla
	MOV R10, R11
	SHL R10, 2
	ADD R10, R9		      ; faz soma, e guarda no R10 o valor a mostrar no calcula_tecla_guarda
	

; ***************************************
;	Escreve no calcula_tecla_guarda e guarda a ultima_tecla_pressa (escreve_memoria)
;  	INPUT - R11, valor a escrever no calcula_tecla_guarda
; 	OUTPUT - ND, (em memoria ultima_tecla_pressa, e tecla_pressa)
; ***************************************

escreve_memoria:	
	MOV R2, ultima_tecla_pressa			
	MOV R11, [R2]			
	CMP R10, R11		  ; comparar o valor a escrever no tecla_pressa com ultima_tecla_pressa
	JZ sair				  ; se o for igual não escreve no tecla_pressa
	MOV [R2], R10		  ; escreve na ultima_tecla_pressa 
	MOV R7, tecla_pressa
	MOV [R7], R10		  ; escreve no calcula_tecla_guarda

	
sair:
	MOV R4, 0			  ; gera o registo que guarda a coluna
	POP R2
	POP R1
	RET

; ***************************************
; 	Rotina que calcula a posiçao da linha ou coluna (0...3) (calcula_tecla)
; 	INPUT - R4, uma linha ou coluna para calcular a posiçao
; 	OUTPUT - R11 (posicao 0...3)
; ***************************************

calcula_tecla:
	PUSH R1
	MOV  R1, 0      ; contador
cicloc:
	ADD R1, 1
	SHR R4, 1
	JNZ cicloc
	SUB R1, 1
	MOV R11, R1
	POP R1
	RET






; *****************************************************
;   Rotina para limpar pixel screen
;   INPUT - ND
;   OUTPUT - ND (periferico pixel screen)
; *****************************************************
limpa_pixel_screen:
	MOV R0, 0		 ; contador
	MOV R1, 128		 ; condiçao de paragem (max)
	MOV R2, screen
	MOV R3, 0H
		
 lps_loop:
	CMP R0, R1
	JZ fim_lps
	ADD R2, 1        ; incrementar endereco
	MOVB [R2], R3    ; apagar pixel
	ADD R0, 1        ; incrementar contador
	JMP lps_loop
 fim_lps: 
	RET
	




	
; *****************************************************
; 	Rotina para desenhar barra
;	INPUT - ND
; 	OUTPUT - ND (periferico pixel screen)
; *****************************************************

desenha_barra:
	MOV R1, 0   ; Linha
	MOV R2, 13  ; Coluna
	MOV R3, 1   ; Estado do bit
	MOV R4, 32  
 ciclo_barra:
	CMP R1, R4			 ; compara a linha com 
	JGE fim_db
	CALL rw_pixel_screen ; passa linha em R1 e coluna em R2 
	ADD R1, 1
	JMP ciclo_barra
 fim_db:
	RET
	

; *****************************************************
; 	Rotina para verificar o fim do jogo
;	INPUT - ND (memoria counter_fim_jogo)
; 	OUTPUT - ND 
; *****************************************************
verifica_fim_jogo:
	PUSH R1
	PUSH R2
	MOV R1, counter_fim_jogo
	MOV R2, [R1]
	CMP R2, 1
	JZ fim_fim

sair_verifica_fim:
	POP R2
	POP R1
	RET
	
fim_fim:
	CALL escreve_ecra_final
fim_fim_1:
	JMP fim_fim_1




; **********************************************************
; 	Rotina que escreve/apaga um pixel do pixel screen
;	INPUT  - R1 (linha), R2 (coluna), R3 (Estado_do_bit: 0 - apaga
;													     1 - escreve)		
; 	OUTPUT - ND (periferico pixel screen, altera 1 pixel)
; ***********************************************************

rw_pixel_screen:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
    call calcEnderecoByte_e_n_esimo_bit  ; devolve: R1 => endereco relativo do byte, R2 => n_esimo_bit
	
	MOV R0, screen          ; Endereco (Base) do pixelScreen
	ADD R0, R1				; adicionar endereco do BYTE ao endereco base do pixelScreen
	                        ; para obter endereco correcto do byte (endereco absoluto + endereco relativo)
	MOVB R1, [R0]			; Colocar em registo o que esta no ecra (byte)
	
	
	; Calculo da mascara
	SHL R2, 1				; porque as WORD's valem dois (isto e uma multiplicacao por dois)
	MOV R4, mascaras		
	ADD R4, R2				; seleciona a mascara que queremos	
	MOVB R2, [R4]			; mascara
	BIT R3, 0
	JZ apaga_pixel
	
 acende_pixel:
	OR R1, R2				; (Ecran OR Mascara) coloca pixel a 1, sem alterar os restantes
	JMP escreve

 apaga_pixel:               ; coloca pixel a 0
	NOT R2					; not mascara	
	AND R1, R2				; (Ecran AND NotMascara) inverte/apaga o pixel. coloca pixel a 0, sem alterar os restantes
	
 escreve:
	MOVB [R0], R1           ; escreve pixel (R1) ecra [R0]
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
	

; ***********************************************************************
;	 Rotina para calcular endereco byte e o bit (calcEnderecoByte_e_n_esimo_bit)
;	 INPUT -  R1(linha), R2(coluna) (Nota: em R3 esta o estado do bit, nao estragar)
;	 OUTPUT - R1 (Endereco_byte) , R2 (n_esimo_bit)
; ***********************************************************************

calcEnderecoByte_e_n_esimo_bit:
	MOV R4, R2				; Guardar Coluna (R2) para calculo do n_esimo_bit
	SHL R1, 2				; estamos a multiplicar por 4
	SHR R4, 3 				; dividir por 8
	ADD R1, R4				; O endereço do byte no pixelscreen (dentro do ecrã, 0 a 128 bytes) 
	MOV R0, 8
	MOD R2, R0              ; Posicao do bit dentro do byte (coluna modulo 8). (n_esimo_bit)
	ADD R2, 1 		
	RET	
	





; ******************************************************
; 	Rotina para preparar o desenho de um tetramino especifico
; 	INPUT - R0: endereco base do tetramino (em memoria linha_tetramino, coluna_tetramino, tetramino_forma)
; 	OUTPUT - ND (para desenha_tetramino, R1: linha, R2: coluna, R4: num rotacao (0...3))
; *******************************************************
desenha_tetramino_x:
	
	MOV R10, linha_tetramino
	MOV R1, [R10]            ; Linha Inicial	

	MOV R10, coluna_tetramino
	MOV R2, [R10]            ; Coluna Inicial

	MOV R3, tetramino_forma
	MOV R4, [R3]
	CALL desenha_tetramino 	 ; passar => R0: Endereco Base do Tetramino, R1: Linha Inicial, R2: Coluna Inicial
    RET                      ;           R3: BIT (0: apagar, 1: acender), R4: Numero da posicao do tetramino


; ***************************************************************************************************************************************************
; 	Rotina para escrever tetraminos
; 	INPUT  - R0: Endereco base do tetramino; R1: linha inicial; R2: coluna inicial, R4: numero da posicao do tetramino (rotacao 0...3)
; 	OUTPUT - ND (para rotina rw_pixel_screen, R1:linha, R2:coluna, R3:estado bit (apagar/escrever) )
; ****************************************************************************************************************************************************

desenha_tetramino:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R7
	MOV R9, R2              ; Guardar Coluna Original em R9 para repor quando se muda de linha
	MOV R10, 18             ; Cada desenho ocupa 18 (12H)
    MUL R4, R10             ; R4 tem figura 0,1,2 ou 3
	ADD  R0, R4             ; Endereco base da figura + deslocamento relativo
	MOVB R4, [R0]			; total nº LINHAS da figura em R4
	ADD R0, 1 			
	MOVB R5, [R0] 			; total nº COLUNAS da figura em R5
	
	MOV R6, 0				; contador LINHAS em R6
	MOV R7, 0				; contador COLUNAS em R7 
	
 loop_desenha_tetramino:	
	ADD R0, 1 				; endereco do pixel a ser desenhado
	ADD R7, 1               ; incrementar contador de colunas
	
	MOVB R8, [R0]           ; Pixel a ser desenhado
	CMP R8,0                ; afetar flag zero
	JZ nextPixel            ; Se o bit a acender/apagar for zero, não necessido de o apagar
	
	MOV R3, R8 
	CMP R3, 1				
	JNZ nextPixel
	
	CALL rw_pixel_screen      ; espera: R1:Linha, R2:Coluna, R3:Estado_do_bit 
	JMP nextPixel
	
 nextPixel:		
	CMP R7, R5				  ; ver se estamos na ultima coluna
	JZ nextLine			      ; se sim
	
	CMP R6, R4                ; ver se chegamos à ultima linha
	JZ fim_desenha_tetramino  ; acaba a rotina	
	ADD R2,1
	JMP loop_desenha_tetramino

 nextLine:
	ADD R6, 1               ; incrementar contador de linha
	MOV R2, R9				; voltar à coluna original
	MOV R7, 0
	ADD R1, 1				; passar linha de baixo
	JMP loop_desenha_tetramino

	
fim_desenha_tetramino:
	POP R7
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
	
	
	


; ******************************************************
; 	Rotina para preparar a delecao do monstro
; 	INPUT - ND (em memoria coluna_monstro)
; 	OUTPUT - ND (para int_apaga_tetramino - R1: linha inicial; R2: coluna inicial;
;											R4: numero da posicao do tetramino (rotacao 0...3))
; ******************************************************

int_apaga_monstro_x:
	MOV R0, monstro_word
	MOV R1, 15
	MOV R10, coluna_monstro
	MOV R2, [R10]            ; Coluna Inicial
	MOV R3, 1        
	MOV R4, 0
	CALL int_apaga_tetramino ; passar => R0: Endereco Base do Tetramino, R1: Linha Inicial, R2: Coluna Inicial
	RET

; ******************************************************
; 	Rotina para preparar a delecao do tetramino
; 	INPUT - ND (em memoria linha_tetramino, coluna_tetramino, tetramino_forma)
; 	OUTPUT - ND (para int_apaga_tetramino - R1: linha inicial; R2: coluna inicial;
;											R4: numero da posicao do tetramino (rotacao 0...3))
; ******************************************************
int_apaga_tetramino_x:
	MOV R10, linha_tetramino
	MOV R1, [R10]              ; Linha Inicial	
	MOV R10, coluna_tetramino
	MOV R2, [R10] 			   ; linha Inicial
	MOV R3, 1    		   
	MOV R3, tetramino_forma	   ; Forma rotacao tetramino (0...3)
	MOV R4, [R3]
	CALL int_apaga_tetramino   ; passar => R0: Endereco Base do Tetramino, R1: Linha Inicial, R2: Coluna Inicial
	
	RET  
	



; ***************************************************************************************************************************************************
; 	Rotina para apagar tetramino
; 	INPUT  - R1: linha inicial, R2: coluna inicial, R4: numero da posicao do tetramino (rotacao 0...3)
; 	OUTPUT - ND (para rotina rw_pixel_screen: R1:linha, R2:coluna, R3: estado bit (apagar/escrever) )
; ****************************************************************************************************************************************************

int_apaga_tetramino:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	MOV R9, R2              ; Guardar Coluna Original em R9 para repor quando se muda de linha
	MOV R10, 18             ; Cada desenho ocupa 18 (12H)
    MUL R4, R10             ; R4 tem figura 0,1,2 ou 3
	ADD  R0, R4             ; Endereco base da figura + deslocamento relativo
	MOVB R4, [R0]			; total nº LINHAS da figura em R4
	ADD R0, 1 				
	MOVB R5, [R0] 			; total nº COLUNAS da figura em R5
	
	MOV R6, 0				; contador LINHAS em R6
	MOV R7, 0				; contador COLUNAS em R7
	
  
	
 int_loop_apaga_tetramino:	
	ADD R0, 1 				; endereco do pixel a ser desenhado
	ADD R7, 1               ; incrementar contador de colunas
	
	MOVB R8, [R0]           ; Pixel a ser desenhado
	CMP R8,0                ; afetar flag zero
	JZ int_nextPixel        ; Se o bit a acender/apagar for zero, não necessido de o apagar
	
	MOV R3, R8 
	CMP R3, 1	
	JNZ int_nextPixel
	
	MOV R3, 0
	CALL rw_pixel_screen        ; espera: R1:Linha, R2:Coluna, R3:Estado_do_bit 
	JMP int_nextPixel
	
 int_nextPixel:		
	CMP R7, R5				    ; ver se estamos na ultima coluna
	JZ int_nextLine			    ; se sim
	
	CMP R6, R4                  ; ver se chegamos à ultima linha
	JZ int_fim_apaga_tetramino	; acaba a rotina	
	ADD R2,1
	JMP int_loop_apaga_tetramino

 int_nextLine:
	ADD R6, 1             		; incrementar contador de linha
	MOV R2, R9					; voltar à coluna original
	MOV R7, 0
	ADD R1, 1					; passar linha de baixo
	JMP int_loop_apaga_tetramino

int_fim_apaga_tetramino:	
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
	


; ******************************************************
; 	Rotina para preparar o desenho do monstro
; 	INPUT - ND (em memoria coluna_monstro)
; 	OUTPUT - ND (para desenha_monstro, R1: linha, R2: coluna, R4: num rotacao (0...3))
; *******************************************************
	
desenha_monstro_x:
	MOV R0, monstro_word
	
	MOV R1, 15               ; Linha Inicial	
	MOV R10, coluna_monstro
	MOV R2, [R10]            ; Coluna Inicial
	CALL desenha_monstro     ; passar => R0: Endereco Base do Tetramino, R1: Linha Inicial, R2: Coluna Inicial
	RET                      ;           R3: BIT (0: apagar, 1: acender), R4: Numero da posicao do tetramino



; ***************************************************************************************************************************************************
; 	Rotina para desenhar monstro
;	INPUT  - R1: linha inicial, R2: coluna inicial
; 	OUTPUT - ND (para rotina rw_pixel_screen: R1:linha, R2:coluna, R3: estado bit (apagar/escrever) )
; ****************************************************************************************************************************************************

desenha_monstro:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R10
	MOV R9, R2                ; Guardar Coluna Original em R9 para repor quando se muda de linha
	MOVB R4, [R0]			  ; total nº LINHAS da figura em R4
	ADD R0, 1 				
	MOVB R5, [R0] 			  ; total nº COLUNAS da figura em R5
	MOV R6, 0				  ; contador LINHAS em R6
	MOV R7, 0				  ; contador COLUNAS em R7  
	
 loop_desenha_monstro:	
	ADD R0, 1 				  ; endereco do pixel a ser desenhado
	ADD R7, 1                 ; incrementar contador de colunas
	MOVB R8, [R0]             ; Pixel a ser desenhado
	CMP R8,0                  ; afetar flag zero
	JZ nextPixel_monstro      ; Se o bit a acender/apagar for zero, não necessido de o apagar
	
	MOV R3, R8 
	CMP R3, 1				  ; ver se e apagar ou acender
	JNZ nextPixel_monstro
	
	CALL rw_pixel_screen      ; espera: R1:Linha, R2:Coluna, R3:Estado_do_bit 
	JMP nextPixel_monstro
		
	
 nextPixel_monstro:		
	CMP R6, R4                ; ver se chegamos à ultima linha
	JZ fim_desenha_monstro	  ; acaba a rotina	
	ADD R2,1

	CMP R7, R5				  ; ver se estamos na ultima coluna
	JZ nextLine_monstro		  ; se sim
	JMP loop_desenha_monstro

 nextLine_monstro:
	ADD R6, 1               ; incrementar contador de linha
	MOV R2, R9				; voltar à coluna original
	MOV R7, 0
	ADD R1, 1				; passar linha de baixo
	JMP loop_desenha_monstro

	
fim_desenha_monstro:
	POP R10
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
	
	
	

; ***********************************************************************
; 	Rotina para desenhar 'ecra de inicio'
; 	INPUT - R1:Endereco_byte da string a escrever na ecra (em memoria welcome)
;	OUTPUT - ND (para periferico pixel screen)
; ***********************************************************************	

escreve_ecra:			 ; passar => endereco da string a escrever em R1
	PUSH R0
	PUSH R1 
	PUSH R2 
	PUSH R3 
	PUSH R4 
	MOV R0, screen    	 ; endereco do pixel screen 		
	MOV R1, welcome	     ; o endereco do que queremos desenhar
	MOV R3, 0			 ; contador 
    MOV R4, 128			 ; numero de bytes do pixel screen 
ciclo_ec:					
	MOVB R2, [R1]		 ; informacao a escrever
	MOVB [R0], R2		 ; escrever no pixel screen 
	ADD R3,1             ; incrementa contador   
	ADD R1,1             ; incrementa endereco da informocao a desenhar
	ADD R0,1             ; passa ao byte seguinte do ecra
	CMP R3,R4 			
	JNZ ciclo_ec		 ; se o contador ja tiver chegado ao fim sai 
	POP R4 
	POP R3 
	POP R2 
	POP R1 
	POP R0
	RET
	
	
; ***********************************************************************
; 	Rotina para desenhar 'ecra de fim'
; 	INPUT - R1:Endereco_byte da string a escrever na ecra (em memoria game_over)
;	OUTPUT - ND (para periferico pixel screen)
; ***********************************************************************		
escreve_ecra_final:		 ; passar => endereco da string a escrever em R1
	PUSH R0
	PUSH R1 
	PUSH R2 
	PUSH R3 
	PUSH R4 
	MOV R0, screen    	 ; endereco do pixel screen 		
	MOV R1, game_over	 ; o endereco do que queremos desenhar
	MOV R3, 0			 ; contador 
    MOV R4, 128			 ; numero de bytes do pixel screen 
ciclo_ec_final:					
	MOVB R2, [R1]		 ; informacao a escrever pixel screen 
	MOVB [R0], R2		
	ADD R3,1             ; incrementa contador   
	ADD R1,1             ; incrementa endereco da informocao a desenhar
	ADD R0,1             ; passa ao byte seguinte do ecra
	CMP R3, R4 			
	JNZ ciclo_ec_final		; se o contador ja tiver chegado ao fim sai 
	DI
	POP R4 
	POP R3 
	POP R2 
	POP R1 
	POP R0
	RET


; ************************************************
;	Rotina que gera numeros aleatorios
; 	INPUT - ND (em memoria counter)
; 	OUTPUT - ND (atualiza counter)
; ************************************************

gerador:
	MOV R10, counter
	MOV R11, [R10]                ;contador
	ADD R11, 1                    ;incrementa o contador
	MOV [R10], R11
	RET
	
	
; ************************************************
;	Rotina para obter um num random entre 0 e 7 (para escolher o tetramino da tabela escolher_tetramino)
;	INPUT -  ND (memoria counter)
;	OUTPUT - R0: valor aleatorio entre 0 e 7
; ************************************************


get_random:
	PUSH R1 
	MOV R1, counter 
	MOV r0, [R1]               ; obtem o valor do contador
	MOV R0, 0003H              ; mascara para obter os 3 bits de menor peso 
	AND R0, R1
	POP R1 
	RET 


; *********************************************************************************************
;			INTERRUPCOES
; *********************************************************************************************

; ************************************************
;	Rotina de interrupcao 
;	Faz descer o tetramino
;	INPUT - ND
;	OUTPUT - ND (em memoria atualiza linha_tetramino)
; ************************************************
rot0:
	PUSH R0
	PUSH R1
	PUSH R10
	PUSH R9
	MOV R0, z_word_alto				; para a rotina int_apaga_tetramino_x e desenha_tetramino
	CALL int_apaga_tetramino_x
	
	MOV R10, linha_tetramino
	MOV R1, [R10]
	MOV R9, 30						
	CMP R1, R9						; comparar com a ultima linha
	JZ fim_rot0						; para parar
	
	ADD R1, 1						; incrementa a linha_monstro 
	MOV [R10], R1					; para passar a linha seguinte
	
fim_rot0:	
	CALL desenha_tetramino_x
	POP R9
	POP R10
	POP R1
	POP R0
	RFE

	
; ************************************************
;	Rotina de interrupcao 
;	Move o monstro
;	INPUT - ND
;	OUTPUT - ND (em memoria atualiza coluna_monstro, counter_fim_jogo)
; ************************************************
rot1:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	CALL int_apaga_monstro_x
	MOV R2, coluna_monstro		
	MOV R10, [R2]

	CMP R10, 0				; ver se o monstro ja esta na primeira coluna do pixel screen
	JZ actualiza_rot1		; se sim
	SUB R10, 1				; se nao, decrementa a coluna_monstro para desenhar na linha mais a esq 
	MOV [R2], R10
	JMP fim_rot1

actualiza_rot1:
	MOV R10, 25					; actualiza o coluna_monstro para voltar a coluna inicial
	MOV [R2], R10	
	MOV R2, counter_fim_jogo	
	MOV R3, 1					; coloca a 1 para acabar o jogo e colocar ecra final
	MOV [R2], R3

fim_rot1:
	CALL desenha_monstro_x
	POP R3
	POP R2
	POP R1
	POP R0
	RFE
	