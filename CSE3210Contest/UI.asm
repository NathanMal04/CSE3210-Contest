INCLUDE Contest.inc


.data
lvlLab    BYTE "LVL: ",0
plLab     BYTE "YOU  HP: ",0
foeLab    BYTE "FOE  HP: ",0
slash     BYTE " / ",0
atkLab    BYTE "  ATK: ",0
defLab    BYTE "  DEF: ",0

.code
; Print Functions
PrintCRLF PROC
    call Crlf
    ret
PrintCRLF ENDP

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
    INVOKE PrintStr, ADDR defLAB
    INVOKE PrintNum, gPlayerDEF
    INVOKE PrintStr, ADDR atkLAB
    INVOKE PrintNum, gPlayerATK
    INVOKE PrintCRLF
    ret
DisplayPlayer ENDP
END