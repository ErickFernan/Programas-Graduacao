;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       NOME DO PROJETO                           *
;*                           CLIENTE                               *
;*         DESENVOLVIDO PELO DEL ENGENHARIA E CONSULTORIA      *
;*   VERSÃO: 1.0                           DATA: 17/06/10          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     DESCRIÇÃO DO ARQUIVO                        *
;*-----------------------------------------------------------------*
;*   MODELO PARA PIC 16F877A                                       *
;*                                                                 *
;*                                                                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ARQUIVOS DE DEFINIÇÕES                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#INCLUDE <P16F877A.INC>	;ARQUIVO PADRÃO MICROCHIP PARA 16F877A

	__CONFIG _CP_OFF & _PWRTE_ON & _WDT_OFF & _LVP_OFF & _HS_OSC

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    PAGINAÇÃO DE MEMÓRIA                         *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;DEFINIÇÃO DE COMANDOS DE USUÁRIO PARA ALTERAÇÃO DA PÁGINA DE MEMÓRIA
#DEFINE	BANK0	BCF STATUS,RP0	;SETA BANK 0 DE MEMÓRIA
#DEFINE	BANK1	BSF STATUS,RP0	;SETA BANK 1 DE MAMÓRIA
BANK0 MACRO ;MACRO PARA SELECIONAR BANCO 0

BCF STATUS,RP0

BCF STATUS,RP1

ENDM ;FIM DA MACRO BANK0

BANK1 MACRO ;MACRO PARA SELECIONAR BANCO 1

BSF STATUS,RP0

BCF STATUS,RP1

ENDM ;FIM DA MACRO BANK1

BANK2 MACRO ;MACRO PARA SELECIONAR BANCO 2

BCF STATUS,RP0

BSF STATUS,RP1

ENDM ;FIM DA MACRO BANK2

BANK3 MACRO ;MACRO PARA SELECIONAR BANCO 3

BSF STATUS,RP0

BSF STATUS,RP1

ENDM ;FIM DA MACRO BANK3

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         VARIÁVEIS                               *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DOS NOMES E ENDEREÇOS DE TODAS AS VARIÁVEIS UTILIZADAS 
; PELO SISTEMA
	CBLOCK	0x20	;ENDEREÇO INICIAL DA MEMÓRIA DE
					;USUÁRIO
		W_TEMP		;REGISTRADORES TEMPORÁRIOS PARA USO
		STATUS_TEMP	;JUNTO ÀS INTERRUPÇÕES

		;NOVAS VARIÁVEIS
DEBOUNCE ;0x20, USADO NO DEBOUNCE

COUNT ;0x21, USADO NO DEBOUNCE

CONTADOR ;0x22, ARMAZENA A CONTAGEM

ENDC ;FIM DO BLOCO DE MEMORIA

		

	ENDC			;FIM DO BLOCO DE MEMÓRIA
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                        FLAGS INTERNOS                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODOS OS FLAGS UTILIZADOS PELO SISTEMA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         CONSTANTES 

DEB EQU .200 ;INICIALIZACAO DO REG DEBOUNCE

DEB_CONT EQU .50 ;INICIALIZACAO DO REG COUNT

MINIMO EQU .0 ;VALOR MINIMO DA CONTAGEM

MAXIMO EQU .9 ;VALOR MAXIMO DA CONTAGEM                             *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODAS AS CONSTANTES UTILIZADAS PELO SISTEMA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           ENTRADAS 

#DEFINE BOTAO1 PORTA,1 ;0 --> PRESSIONADO ;1 --> LIBERADO

#DEFINE BOTAO2 PORTA,2 ;0 --> PRESSIONADO ;1 --> LIBERADO                             *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODOS OS PINOS QUE SERÃO UTILIZADOS COMO ENTRADA
; RECOMENDAMOS TAMBÉM COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           SAÍDAS                                *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINIÇÃO DE TODOS OS PINOS QUE SERÃO UTILIZADOS COMO SAÍDA
; RECOMENDAMOS TAMBÉM COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       VETOR DE RESET                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	ORG	0x00			;ENDEREÇO INICIAL DE PROCESSAMENTO
	GOTO	INICIO
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    INÍCIO DA INTERRUPÇÃO                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; ENDEREÇO DE DESVIO DAS INTERRUPÇÕES. A PRIMEIRA TAREFA É SALVAR OS
; VALORES DE "W" E "STATUS" PARA RECUPERAÇÃO FUTURA

	ORG	0x04			;ENDEREÇO INICIAL DA INTERRUPÇÃO
	MOVWF	W_TEMP		;COPIA W PARA W_TEMP
	SWAPF	STATUS,W
	MOVWF	STATUS_TEMP	;COPIA STATUS PARA STATUS_TEMP


;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    ROTINA DE INTERRUPÇÃO                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; AQUI SERÁ ESCRITA AS ROTINAS DE RECONHECIMENTO E TRATAMENTO DAS
; INTERRUPÇÕES

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                 ROTINA DE SAÍDA DA INTERRUPÇÃO                  *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; OS VALORES DE "W" E "STATUS" DEVEM SER RECUPERADOS ANTES DE 
; RETORNAR DA INTERRUPÇÃO

SAI_INT
	SWAPF	STATUS_TEMP,W
	MOVWF	STATUS		;MOVE STATUS_TEMP PARA STATUS
	SWAPF	W_TEMP,F
	SWAPF	W_TEMP,W	;MOVE W_TEMP PARA W
	RETFIE

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*	            	 ROTINAS E SUBROTINAS                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; CADA ROTINA OU SUBROTINA DEVE POSSUIR A DESCRIÇÃO DE FUNCIONAMENTO
; E UM NOME COERENTE ÀS SUAS FUNÇÕES.

SUBROTINA1

MAIN

MOVLW DEB ;INICIALIZA DEBOUNCE COM 200

MOVWF DEBOUNCE

MOVLW DEB_CONT ;INICIALIZA COUNT COM 50

MOVWF COUNT

TESTA_BT1

BTFSC BOTAO1 ;BOTAO1 ESTA PRESSIONADO?

GOTO TESTA_BT2 ;NAO, DESVIA

GOTO FAZER_DEBOUNCE1 ;SIM, DESVIA

TESTA_BT2

BTFSC BOTAO2 ;BOTAO2 ESTA PRESSIONADO?

GOTO MAIN ;NAO, DESVIA

GOTO FAZER_DEBOUNCE2 ;SIM, DESVIA

FAZER_DEBOUNCE1

DECFSZ DEBOUNCE,F ;DECREMENTA DEBOUNCE, = 0?

GOTO TESTA_BT1 ;NAO, DESVIA

MOVLW DEB ;SIM, CONTINUA

MOVWF DEBOUNCE ;INICIALIZA DEBOUNCE COM 200

DECFSZ COUNT,F ;DECREMENTA COUNT, COUNT=0?

GOTO TESTA_BT1 ;NAO, DESVIA

GOTO TRATA_BT1 ;SIM, DESVIA

FAZER_DEBOUNCE2

DECFSZ DEBOUNCE,F ;DECREMENTA DEBOUNCE, = 0?

GOTO TESTA_BT2 ;NAO, DESVIA

MOVLW DEB ;SIM, CONTINUA

MOVWF DEBOUNCE ;INICIALIZA DEBOUNCE COM 200

DECFSZ COUNT,F ;DECREMENTA COUNT, COUNT=0?

GOTO TESTA_BT2 ;NAO, DESVIA

;SIM, CONTINUA

TRATA_BT2

MOVLW .0 ;W RECEBE 0

XORWF CONTADOR,W ;W = W xor CONTADOR

BTFSC STATUS,Z ;CONTADOR = 0?

GOTO SOLTAR_BOTAO ;SIM, AGUARDA SOLTAR BOTAO

DECF CONTADOR,F ;NAO, DECREMENTA CONTADOR

CALL CONV_DISP ;CHAMA SUB- ROTINA.

MOVWF PORTB ;ATUALIZA DISPLAY

GOTO SOLTAR_BOTAO ;DESVIA

TRATA_BT1

MOVLW .9 ;W RECEBE 9

XORWF CONTADOR,W ;W = W xor CONTADOR

BTFSC STATUS,Z ;CONTADOR = 9?

GOTO SOLTAR_BOTAO ;SIM, AGUARDA SOLTAR BOTAO

INCF CONTADOR,F ;NAO, INCREMENTA CONTADOR

CALL CONV_DISP ;CHAMA SUB- ROTINA. MOVWF PORTB ;ATUALIZA DISPLAY

SOLTAR_BOTAO

BTFSS BOTAO1 ;BOTAO1 ESTA SOLTO?

GOTO $-1 ;NAO, AGUARDA SOLTAR BOTAO1

BTFSS BOTAO2 ;BOTAO2 ESTA SOLTO?

GOTO $-1 ;NAO, AGUARDA SOLTAR BOTAO2

GOTO MAIN ;SIM, DESVIA
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIO DO PROGRAMA                          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	
INICIO
	BANK1				;ALTERA PARA O BANCO 1
    MOVLW	B'00000000'
	MOVWF	TRISD		;DEFINE ENTRADAS E SAÍDAS DO PORT
	MOVLW	B'11111111'
	MOVWF	TRISB		;DEFINE ENTRADAS E SAÍDAS DO PORTB
	MOVLW	B'00000100'
	MOVWF	OPTION_REG	;DEFINE OPÇÕES DE OPERAÇÃO
	MOVLW	B'10000000'
	MOVWF	INTCON	
    	

	;DEFINE OPÇÕES DE INTERRUPÇÕES
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00101011'
    MOVWF	T1CON
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZAÇÃO DAS VARIÁVEIS                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ROTINA PRINCIPAL                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAIN


      ;CORPO DA ROTINA PRINCIPAL


GOTO  MAIN

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       FIM DO PROGRAMA                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;ESTA SUB-ROTINA CONVERTE O VALOR ARMAZENADO NO REGISTRADOR CONTADOR PARA

;DISPLAY DE SETE SEGMENTOS, RETORNANDO O VALOR CONVERTIDO EM W.

CONV_DISP

MOVF CONTADOR,W ;W RECEBE CONTEUDO DE CONTADOR

ADDWF PCL,F ;PCL RECEBE (W + PCL)

;OS COMENTARIOS ABAIXO SE REFEREM AOS VALORES VISTOS NO DISPLAY

;.GFEDCBA ;POSICAO DOS SEGMENTOS DO DISPLAY LIGADO NO PORTB

RETLW B'00111111' ;0

RETLW B'00000110' ;1

RETLW B'01011011' ;2

RETLW B'01001111' ;3

RETLW B'01100110' ;4

RETLW B'01101101' ;5

RETLW B'01111101' ;6

RETLW B'00000111' ;7

RETLW B'01111111' ;8

RETLW B'01100111' ;9

	END
