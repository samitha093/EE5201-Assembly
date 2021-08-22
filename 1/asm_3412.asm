%include "macrofile.inc"

section .data
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
	var1 db '3412'
	var2 db '2143'
		;divider msgs
	remaindermsg db "Your remainder is : ",0
	remaindermsgsize equ $-remaindermsg
		;Operation select msgs
	summationselectmsg db "Addition Operation is selected",10,0
	summationselectmsgsize equ $-summationselectmsg
	differenceselectmsg db "Subtraction Operation is selected",10,0
	differenceselectmsgsize equ $-differenceselectmsg
		;Operation msgs
	summationmsg db "summation of var1 and var2 : ",0
	summationmsgsize equ $-summationmsg
	differencemsg db "difference between var1 and var2 : ",0
	differencemsgsize equ $-differencemsg
		;get input Digit message
	inputcharmsg db "Enter a Character: ",0
	inputcharmsgsize equ $-inputcharmsg
		;Digit message
	digitmsg db "This is a Digit",10,0
	digitmsgsize equ $-digitmsg
		;Not Digit message
	notdigitmsg db "This is not a Digit",10,0
	notdigitmsgsize equ $-notdigitmsg
		;even odd message
	evenmsg db "This is an Even Number",10,0
	evenmsgsize equ $-evenmsg
	oddmsg db "This is an Odd Number",10,0
	oddmsgsize equ $-oddmsg
		
section .bss
	remainder resb 1
	total resb 4
	character resb 1	
	
section .text
global _start
_start:
	call greeting
	call division
	mov rax, [remainder]
	cmp rax,48
	je summation
	jg subtraction
	call getcharacter
	call end
	
greeting:
	print greetingmsg,greetingmsgsize
	print msgone,msgonesize
	print var1,4
	print nextline,nextlinesize
	print msgtwo,msgtwosize
	print var2,4
	print nextline,nextlinesize
	ret

division:
	mov rsi, 0
	mov cl, 0
	loop1:
		mov al, [var1+rsi]
		sub al, '0'
		mov bl, '2'
		sub bl, '0'
		add al, cl
		xor ah,ah
		mov cl, 0
		div bl
		add ah, '0'
		cmp ah , 1
		je remainder
		save:
			inc rsi
			cmp rsi, 4
			jl loop1
			mov [remainder], ah
			print remaindermsg,remaindermsgsize
			print remainder,1
			print nextline,nextlinesize
			ret
		remainderbit:
			mov cl,10
			jmp save	
		

summation:
	print summationselectmsg,summationselectmsgsize
	mov rsi, 3
	mov cl, 0
	loop2:
		mov al, [var1+rsi]
		sub al, '0'
		mov bl, [var2+rsi]
		add al, bl
		add al, cl
		mov cl, 0
		cmp al, 57
		jg carrerbit
		savebit:
			mov [total + rsi], al
			dec rsi
			cmp rsi,0
			jge loop2
			print summationmsg,summationmsgsize
			print total,4
			print nextline,nextlinesize
			call getcharacter
		carrerbit:
			sub al,10
			mov cl,1
			jmp savebit
			
subtraction:
	print differenceselectmsg,differenceselectmsgsize
	mov rsi, 3
	mov cl, 0
	loop3:
		mov al, [var1+rsi]
		mov bl, [var2+rsi]
		sub al, bl
		sub al, cl
		mov cl, 0
		cmp al, 0
		jl carrerbit2
		savebit2:
			add al, 48
			mov [total + rsi], al
			dec rsi
			cmp rsi,0
			jge loop3
			print differencemsg,differencemsgsize
			print total,4
			print nextline,nextlinesize
			call getcharacter
		carrerbit2:
			add al,10
			mov cl,1
			jmp savebit2
	
			
getcharacter:
	print inputcharmsg,inputcharmsgsize
	getinput character, 1
	mov rbx , [character]
	cmp rbx, 57
	jg not_digit
	jle check_more
	check_more:
		cmp rbx, 48
		jl not_digit
		print digitmsg,digitmsgsize
		call evenodd
	not_digit:
		print notdigitmsg,notdigitmsgsize
		call end

evenodd:
	mov al, [character]
	sub al, '0'
	mov bl, '2'
	sub bl, '0'
	div bl
	add ah, '0'
	cmp ah , 49
	je odd
	jl even
	even:
		print evenmsg,evenmsgsize
		call end
	odd:
		print oddmsg,oddmsgsize
		call end
end:
	mov rax,1
	mov rbx,0
	int 0x80
