INCLUDE Contest.inc


.data
lvlLab    BYTE "LVL: ",0
plLab     BYTE "YOU  HP: ",0
enLab     BYTE "Enemy  HP: ",0
atkLab    BYTE "  ATK: ",0
defLab    BYTE "  DEF: ",0
slash     BYTE " / ",0
bar      BYTE "------------------------------",0

.code
; Print Functions
PrintCRLF PROC
    call Crlf
    ret
PrintCRLF ENDP

ClearScreen PROC
    call Clrscr
    ret
ClearScreen ENDP

PrintStr PROC pStr:PTR BYTE
    mov  edx, pStr
    call WriteString
    ret
PrintStr ENDP

PrintNum PROC val:DWORD
    mov eax, val
    call WriteDec
    ret
PrintNum ENDP

; Display information
DisplayPlayer PROC
    INVOKE PrintStr, ADDR plLab
    INVOKE PrintNum, gPlayerMaxHP
    INVOKE PrintStr, ADDR slash
    INVOKE PrintNum, gPlayerHP
    INVOKE PrintStr, ADDR defLab
    INVOKE PrintNum, gPlayerDEF
    INVOKE PrintStr, ADDR atkLab
    INVOKE PrintNum, gPlayerATK
    INVOKE PrintCRLF
    ret
DisplayPlayer ENDP

DisplayEnemy PROC
    INVOKE PrintStr, ADDR enLab
    INVOKE PrintNum, gEnemyMaxHP
    INVOKE PrintStr, ADDR slash
    INVOKE PrintNum, gEnemyHP
    INVOKE PrintStr, ADDR defLab
    INVOKE PrintNum, gEnemyDEF
    INVOKE PrintStr, ADDR atkLab
    INVOKE PrintNum, gEnemyATK
    INVOKE PrintCRLF
    ret
DisplayEnemy ENDP
END