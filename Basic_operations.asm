.DEFINE
tabla1 0000H;
tabla2 0100H;
tabla3 0200H;

.DATA 0000H
db 10H, 20H, 05H, 4H;

.ORG 1000H

LXI H, tabla1;

CONTAR:

	MOV A, M;
	INR A;
	DCR A;
		JZ A_ES_CERO;
	INR B;
	INX H;
	JMP CONTAR;

A_ES_CERO:
PUSH B;

ORDENAR:

LXI H, tabla1; 

CONTINUAR_ORDENANDO:

	MOV A, M;
	INR A;
	DCR A;
		JZ FOR;

	INX H;
	CMP M;
		JNC A_MAYOR_QUE;

	MOV D, M;
	MOV M, A;
	DCX H;
	MOV M, D;
	INX H;
		JMP CONTINUAR_ORDENANDO;


A_MAYOR_QUE:
	JMP CONTINUAR_ORDENANDO;

FOR:
	DCR B;
		JNZ ORDENAR;	

POP B;
LXI D, tabla2;

SUMAR_REGISTROS:

	DCR B;
		JZ ORDENAR_MENOR_MAYOR;
	INX D;
	JMP SUMAR_REGISTROS;
	

ORDENAR_MENOR_MAYOR:

	MOV H, B;
	MOV L, C;
	MOV A, M;
	INR A;
	DCR A;
		JZ SUMAR_MEMORIA;
	INX B;
	MOV H, D;
	MOV L, E;
	MOV M, A;
	DCX D;
		JMP ORDENAR_MENOR_MAYOR;

SUMAR_MEMORIA:

LXI H, tabla1;
LXI D, tabla2;
LXI B, tabla3;

PUSH H;

SUMAR:

	INX D;

	POP H;

	MOV A, M;
	INR A;
	DCR A;
		JZ STOP;

	INX H;

	PUSH H;

	MOV H, D;
	MOV L, E;

	ADD M;

	MOV H, B;
	MOV L, C;

	MOV M, A;
	INX B;

JMP SUMAR;

STOP:


HLT