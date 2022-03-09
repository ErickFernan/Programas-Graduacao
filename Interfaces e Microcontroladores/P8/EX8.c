;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       NOME DO PROJETO                           *
;*                           CLIENTE                               *
;*         DESENVOLVIDO PELO DEL ENGENHARIA E CONSULTORIA      *
;*   VERS�O: 1.0                           DATA: 17/06/10          *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     DESCRI��O DO ARQUIVO                        *
;*-----------------------------------------------------------------*
;*   MODELO PARA PIC 16F877A                                       *
;*                                                                 *
;*                                                                 *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     ARQUIVOS DE DEFINI��ES                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#INCLUDE <P16F877A.INC>	;ARQUIVO PADR�O MICROCHIP PARA 16F877A

	__CONFIG _CP_OFF & _PWRTE_ON & _WDT_OFF & _LVP_OFF & _HS_OSC

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    PAGINA��O DE MEM�RIA                         *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;DEFINI��O DE COMANDOS DE USU�RIO PARA ALTERA��O DA P�GINA DE MEM�RIA
#DEFINE	BANK0	BCF STATUS,RP0	;SETA BANK 0 DE MEM�RIA
#DEFINE	BANK1	BSF STATUS,RP0	;SETA BANK 1 DE MAM�RIA
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
;*                         VARI�VEIS                               *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DOS NOMES E ENDERE�OS DE TODAS AS VARI�VEIS UTILIZADAS 
; PELO SISTEMA
	CBLOCK	0x20	;ENDERE�O INICIAL DA MEM�RIA DE
					;USU�RIO
		W_TEMP		;REGISTRADORES TEMPOR�RIOS PARA USO
		STATUS_TEMP	;JUNTO �S INTERRUP��ES

		;NOVAS VARI�VEIS
DEBOUNCE ;0x20, USADO NO DEBOUNCE

COUNT ;0x21, USADO NO DEBOUNCE

CONTADOR ;0x22, ARMAZENA A CONTAGEM

ENDC ;FIM DO BLOCO DE MEMORIA

		

	ENDC			;FIM DO BLOCO DE MEM�RIA
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                        FLAGS INTERNOS                           *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DE TODOS OS FLAGS UTILIZADOS PELO SISTEMA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                         CONSTANTES 

DEB EQU .200 ;INICIALIZACAO DO REG DEBOUNCE

DEB_CONT EQU .50 ;INICIALIZACAO DO REG COUNT

MINIMO EQU .0 ;VALOR MINIMO DA CONTAGEM

MAXIMO EQU .9 ;VALOR MAXIMO DA CONTAGEM                             *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DE TODAS AS CONSTANTES UTILIZADAS PELO SISTEMA

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           ENTRADAS 

#DEFINE BOTAO1 PORTA,1 ;0 --> PRESSIONADO ;1 --> LIBERADO

#DEFINE BOTAO2 PORTA,2 ;0 --> PRESSIONADO ;1 --> LIBERADO                             *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DE TODOS OS PINOS QUE SER�O UTILIZADOS COMO ENTRADA
; RECOMENDAMOS TAMB�M COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                           SA�DAS                                *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; DEFINI��O DE TODOS OS PINOS QUE SER�O UTILIZADOS COMO SA�DA
; RECOMENDAMOS TAMB�M COMENTAR O SIGNIFICADO DE SEUS ESTADOS (0 E 1)

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                       VETOR DE RESET                            *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	ORG	0x00			;ENDERE�O INICIAL DE PROCESSAMENTO
	GOTO	INICIO
	
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    IN�CIO DA INTERRUP��O                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; ENDERE�O DE DESVIO DAS INTERRUP��ES. A PRIMEIRA TAREFA � SALVAR OS
; VALORES DE "W" E "STATUS" PARA RECUPERA��O FUTURA

	ORG	0x04			;ENDERE�O INICIAL DA INTERRUP��O
	MOVWF	W_TEMP		;COPIA W PARA W_TEMP
	SWAPF	STATUS,W
	MOVWF	STATUS_TEMP	;COPIA STATUS PARA STATUS_TEMP


;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                    ROTINA DE INTERRUP��O                        *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; AQUI SER� ESCRITA AS ROTINAS DE RECONHECIMENTO E TRATAMENTO DAS
; INTERRUP��ES

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                 ROTINA DE SA�DA DA INTERRUP��O                  *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; OS VALORES DE "W" E "STATUS" DEVEM SER RECUPERADOS ANTES DE 
; RETORNAR DA INTERRUP��O

SAI_INT
	SWAPF	STATUS_TEMP,W
	MOVWF	STATUS		;MOVE STATUS_TEMP PARA STATUS
	SWAPF	W_TEMP,F
	SWAPF	W_TEMP,W	;MOVE W_TEMP PARA W
	RETFIE

;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*	            	 ROTINAS E SUBROTINAS                      *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; CADA ROTINA OU SUBROTINA DEVE POSSUIR A DESCRI��O DE FUNCIONAMENTO
; E UM NOME COERENTE �S SUAS FUN��ES.

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
	MOVWF	TRISD		;DEFINE ENTRADAS E SA�DAS DO PORT
	MOVLW	B'11111111'
	MOVWF	TRISB		;DEFINE ENTRADAS E SA�DAS DO PORTB
	MOVLW	B'00000100'
	MOVWF	OPTION_REG	;DEFINE OP��ES DE OPERA��O
	MOVLW	B'10000000'
	MOVWF	INTCON	
    	

	;DEFINE OP��ES DE INTERRUP��ES
	BANK0				;RETORNA PARA O BANCO
	MOVLW	B'00101011'
    MOVWF	T1CON
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                     INICIALIZA��O DAS VARI�VEIS                 *
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
