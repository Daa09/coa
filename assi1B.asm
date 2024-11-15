data segment
msg1 db 10,13,"Enter 5 numbers : $"
msg2 db 10,13,"No $"
msg3 db 10,13,"Number is : $"
no dw 05h dup(0) ; dw for reserving the 2 byte space for word. Dup for creating the arrray
n db 30h
n1 db 30h
data ends

code segment
assume cs : code, ds : data
start: mov ax, data
mov ds,ax
        mov si,0000h ; Source index pointer initialization
back12 : lea dx, msg2
        mov ah, 09h
        int 21h
        mov dl, [n] ;displaying the content of the memory location pointed by n
        mov ah, 02h
        int 21h
        call take ;procedure for taking the 4 byte number
        mov [no + si], bx ;shifting the number in the first position pointed by si
        inc si ; as we want to save 2 byte, increment the si by 2 location.
        inc si
        inc [n] ; increment the content of n by 1 therefore [n] will be 31h
        cmp [n], 34h ; as we need to take 5 numbers, comparing it with 35h
        jbe back12
      mov si, 0000h ; initializing the si at first position
      
  back13: lea dx, msg3
        mov ah, 09h
        int 21h
       mov bx, [no+si] ; taking first number in bx
        call display
        inc [n1] ; increment the content of n by 1 therefore [n] will be 31h
        INC SI
        INC SI
        cmp [n1], 34h ; as we need to take 5 numbers, comparing it with 35h
        jbe back13
      mov ah, 4ch
        int 21h
take proc near
        mov ah, 01h
        int 21h
        cmp al, 39h
        jbe down
        sub al, 07h
down : sub al, 30h
        mov cl, 04h
        rol al, cl
        mov bh, al
        mov ah, 01h
        int 21h
        cmp al, 39h
        jbe down1
        sub al, 07h
down1 : sub al, 30h
        add bh, al ; taking the first byte in bh register ie 12h
        mov ah, 01h
        int 21h
        cmp al, 39h
        jbe down2
        sub al, 07h
down2 : sub al, 30h
        mov cl, 04
        rol al, cl
        mov bl, al
        mov ah, 01h
        int 21h
        cmp al, 39h
        jbe down3
        sub al, 07h
down3 : sub al, 30h
        add bl, al ; taking the first byte in bl =34h register ie after this the complet number is in bx register ie bx=1234h
        ret
        take endp
display proc near
        mov ch, bh ; displaying the first two MSB byte
        and ch, 0f0h
        mov cl, 04h
        rol ch, cl
        cmp ch, 09h
        jbe down4
        add ch, 07h
down4 :
        add ch, 30h
        mov dl, ch
        mov ah, 02h
        int 21h
        mov ch, bh
        and ch, 0fh
        cmp ch, 09h
        jbe down5
        add ch, 07h
down5 : add ch, 30h
        mov dl, ch
        mov ah, 02h
        int 21h
        mov bh, bl ; displaying the last two LSB byte
        mov ch, bh
        and ch, 0f0h
        mov cl, 04h
        rol ch, cl
        cmp ch, 09h
        jbe down6
        add ch, 07h
down6 :
        add ch, 30h
        mov dl, ch
        mov ah, 02h
        int 21h
        mov ch, bh
        and ch, 0fh
        cmp ch, 09h
        jbe down7
        add ch, 07h
down7 : add ch, 30h
        mov dl, ch
        mov ah, 02h
        int 21h
        ret
        display endp
code ends
end start