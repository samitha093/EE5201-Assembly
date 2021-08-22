%include "macrofile.inc"

section .data
	data1 db '34.12'
	data2 db '21.43'
	data3 dq  2143
		;greeting message
	greetingmsg db "....Welcome....",10,0
	greetingmsgsize equ $-greetingmsg
	msgone db "Last four digits : ",0
	msgonesize equ $-msgone
	msgtwo db "Reversed the last four digits : ",0
	msgtwosize equ $-msgtwo
	nextline db " ",10,0
	nextlinesize equ $-nextline
		;number set
	var1 dq 34.12
	var2 dq 21.43
	var3 dq 50.00
		;divider msgs
	remaindermsg db "Your remainder is : ",0
	remaindermsgsize equ $-remaindermsg
		;get input Digit message
	inputcharmsg db "Enter Your Operation: ",0
	inputcharmsgsize equ $-inputcharmsg
		;error message
	errormsg db "Warning :  invalid operation",10,0
	errormsgsize equ $-errormsg
		;operation message
	summsg db "Subtracting operation starts to work",10,0
	summsgsize equ $-summsg
	divmsg db "Dividing operation starts to work",10,0
	divmsgsize equ $-divmsg
		;operation message
	textequal db 'Answer is equals to 50 ',10,0
	size4 equ $ - textequal
	textgreat db 'Answer is larger than 50 ',10,0
	size5 equ $ - textgreat
	textless db 'Answer is less than 50 ',10,0
	size6 equ $ - textless

		
section .bss
	character resb 1
	result resb 4
	
section .text
global _start
_start:
	call greeting
	call division
	
	
greeting:
	print greetingmsg,greetingmsgsize
	print msgone,msgonesize
	print data1,5
	print nextline,nextlinesize
	print msgtwo,msgtwosize
	print data2,5
	print nextline,nextlinesize
	ret
division:
	mov rax,[data3]
	mov rdx,0
	mov rbx, 4
	div rbx
	add rdx, 48
	mov [result],rdx
	print remaindermsg,remaindermsgsize
	print result,4
	print nextline,nextlinesize
	call getcharacter

getcharacter:
	print inputcharmsg,inputcharmsgsize
	getinput character, 1
	mov bl , [character]
	cmp bl, 45
	jl notinoperate
	jg check_more
	je subtracting
	check_more:
		cmp bl, 47
		jl notinoperate
		jg notinoperate
		je Dividing
		call end
	notinoperate:
		print errormsg,errormsgsize
		call end
Dividing:
	print divmsg,divmsgsize
	finit
	fld qword[var1]
	fdiv qword[var2]
	fcomp qword[var3]
	fstsw ax
	sahf
	je equal
	ja great
	jb less

	
subtracting:
	print summsg,summsgsize
	finit
	fld qword[var1]
	fsub qword[var2]
	fcomp qword[var3]
	fstsw ax
	sahf
	je equal
	ja great
	jb less
	
equal:
	print textequal, size4
	call end
	
great:
	print textgreat, size5
	call end
	
less:
	print textless, size6
	call end


end:
	mov rax,1
	mov rbx,0
	int 0x80
