%macro print 2
	mov rax, 4
	mov rbx, 1
	mov rcx, %1
	mov rdx, %2
	int 0x80
%endmacro

%macro getinput 2
	mov rax, 3
	mov rbx, 0
	mov rcx, %1
	mov rdx, %2
	int 0x80
%endmacro
