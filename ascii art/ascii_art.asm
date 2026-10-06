; ==============================================================================
; NASM 32-bit Assembly Program: Full ASCII Art Skull
; Target: Linux (x86)
; Assemble: nasm -f elf32 ascii_art.asm -o ascii_art.o
; Link:     ld -m elf_i386 ascii_art.o -o ascii_art
; Run:      ./ascii_art
; ==============================================================================

section .data
    ; The complete ASCII art string. 
    ; To prevent the image from being "cut", the left and right sides of the 
    ; skull are placed on the exact same lines, separated by spaces.
    ; Each line ends with a newline character (10) to move the cursor down.
    artwork db "       /  ,ccccccccccA,,/''.", 10
            db "      (   aeccccccccccccv'", 10
            db "      / \aecccccccccccccc(", 10
            db "     (   ,ccccccccccccc*''',cc0,ABB", 10
            db "      \  |ccccccccccccv'      .dCCCCdBBB)", 10
            db "       \ (cccccccccccci      )ccc*abbb*       _..-", 10
            db "        Vccccccccccccck. @    ac*abbbb*)     .ccc..", 10
            db "        'ccccccccccckn.._ d*abbbbb*)          'cccyp", 10
            db "         'cccccccccccccccccyabby*_)          (ccn'cccc.", 10
            db "          *yc\Am.dccc*B*__)H.               '*(cccccccccccec.", 10
            db "             -..*~*~dcc1d*_)MMM\            ,cccccccccc*'", 10
            db "            '~. (c@c,cUMMMMMMM~.            ,cccccccccc*", 10
            db "              'i*~*cCA\MMMMMMMbm*C/ ' ( .   ,cccccccccccy", 10
            db "                   '*Cc'*MMMM*cc0' \  ) . -,'ndcccccccccccccy", 10
            db "      _              'CCboQBB*'~'~~ / / .   Ycccccccccccc'", 10
            db "     (cb.             VBBB*'       | /       Yccccccccccc'", 10
            db "      Vcb.              '*          *         ?cccccccc'", 10
            db "  _  -..*ccb_           |                      Vccccccp", 10
            db " (cccckc.c~cccb          \                     ~* ~**cc'", 10
            db " **YcvccA*cc~c)           \", 10
            db "   Yb**ccccccpcc. _ _..>    \", 10
            db "   *ccccccccccccccccccccccb   \", 10
            db "    >cccccccccccccccccccccc.   |", 10
            db "    'vcccccccccccccccccccccc    |", 10
            db "     'cccccccccccccccccccc)     |", 10
            db "      *cccccccccccccccccc|      |", 10
            db "       '*cccccccccc*'           |", 10
            db "          '*~'                 /", 10
            db "                                |", 10
            db "          ,.._                  |", 10
            db "          A/DDD.                |              .-~*adDDDDDDDDDDDDDDDDDDDDDDDDDDDDD*", 10
            db "          Co 'DDb               |             .dDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD*", 10
            db "          V!!!o'Db           _.-~*adDDDDDDDDDDDDDDDDDDDDDDDDDDDDD* .D.'VDDDDDDDDDD'", 10
            db "           '!!!!!o'*D:DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD*   CDDbb.'VDDDDDDV", 10
            db "            '!!!!!!!!oo'DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD*   AUA*ODDbrn..._n'", 10
            db "             '!!!!!!!!!!!o*ODDDDDDDDDDDDDDDDDDDDDDDDDP*    (MAUAUAw**DDDDDV", 10
            db "              '+!!!*nADD)DDDn.**+++**..dDU             U*AUAUAUAUAUAU'", 10
            db "                nADDDDP*/DDDDDDDDDDDDDDD'              *UAUAUAUAUAU'", 10
            db "                DD*..n.DDU ADDDDDDDDDDDDDP              UAUAUAUAU'", 10
            db "                VDDDDDV ADDDDDDDDDDDDDDD'              UAUAUAUAU/", 10
            db "                 VDDD*DDDDDDDDDDDDDDDD/                \UAUAUAU'", 10
            db "                 'DDDDDDDDDDDDDDDDDDD'                  UAUAUAU'", 10
            db "                  'DDDDDDDDDDDDDDDDP'                    '*AU*'", 10
            db "                   *DDDDDDDDDDDDD*", 10
            db "                    *DDDDDDDDD*", 10
            db "                      '**'", 10, 0

section .text
    global _start

_start:
    ; --- Print the main artwork ---
    mov eax, artwork
    call print_string

    ; --- Exit Program ---
    mov eax, 1          ; System call number for sys_exit
    xor ebx, ebx        ; Return status code 0
    int 0x80            ; Call kernel

; ------------------------------------------------------------------------------
; Procedure: print_string
; Description: Prints a null-terminated string to stdout using Linux sys_write.
; Input: eax - pointer to the null-terminated string
; ------------------------------------------------------------------------------
print_string:
    push eax            ; Save the pointer to string
    push ebx            ; Save ebx
    push ecx            ; Save ecx
    push edx            ; Save edx

    mov ecx, eax        ; sys_write expects the string pointer in ecx
    mov edx, 0          ; Initialize length counter to 0

; Calculate the length of the string by looking for the null terminator
.strlen_loop:
    cmp byte [ecx + edx], 0 ; Check for null terminator (0)
    je .print           ; If null terminator found, break loop
    inc edx             ; Increment length
    jmp .strlen_loop

.print:
    mov eax, 4          ; System call number for sys_write
    mov ebx, 1          ; File descriptor 1 (stdout)
    int 0x80            ; Call kernel to write the string

    pop edx             ; Restore edx
    pop ecx             ; Restore ecx
    pop ebx             ; Restore ebx
    pop eax             ; Restore eax
    ret                 ; Return from procedure