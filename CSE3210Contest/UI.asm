INCLUDE Contest.inc


.data
healLab   BYTE "  Heal Pots: ",0
plLab     BYTE "YOU  HP: ",0
enLab     BYTE "  HP: ",0
atkLab    BYTE "  ATK: ",0
defLab    BYTE "  DEF: ",0
slash     BYTE " / ",0
enNumLab  BYTE "Enemy #",0
enDead	  BYTE "  DEAD",0
bar       BYTE "------------------------------",0

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
    MOV  EDX, pStr
    call WriteString
    ret
PrintStr ENDP

PrintNum PROC val:DWORD
    MOV EAX, val
    TEST EAX, EAX
    JNS Positive

    PUSH EAX
    MOV AL, '-'
    call WriteChar
    POP EAX
    NEG EAX
Positive:
    call WriteDec
    ret
PrintNum ENDP

; Display information
DisplayPlayer PROC
    INVOKE PrintStr, ADDR plLab
    INVOKE PrintNum, gPlayerHP
    INVOKE PrintStr, ADDR slash
    INVOKE PrintNum, gPlayerMaxHP
    INVOKE PrintStr, ADDR defLab
    INVOKE PrintNum, gPlayerDEF
    INVOKE PrintStr, ADDR atkLab
    INVOKE PrintNum, gPlayerATK
    INVOKE PrintStr, ADDR healLab
    INVOKE PrintNum, gHealPots
    INVOKE PrintCRLF
    ret
DisplayPlayer ENDP

DisplayEnemy PROC EnemyNumber:DWORD
    MOV ESI, SIZEOF Enemy
    IMUL ESI, EnemyNumber
    SUB ESI, SIZEOF Enemy
    INVOKE PrintStr, ADDR enNumLab
    INVOKE PrintNum, EnemyNumber
    CMP gEnemies[ESI].HP, 0
    JLE Dead
    INVOKE PrintStr, ADDR enLab
    INVOKE PrintNum, gEnemies[ESI].HP
    INVOKE PrintStr, ADDR slash
    INVOKE PrintNum, gEnemies[ESI].MaxHP
    INVOKE PrintStr, ADDR defLab
    INVOKE PrintNum, gEnemies[ESI].DEF
    INVOKE PrintStr, ADDR atkLab
    INVOKE PrintNum, gEnemies[ESI].ATK
    INVOKE PrintCRLF
    ret
    Dead:
        INVOKE PrintStr, ADDR enDead
        INVOKE PrintCRLF
        ret
DisplayEnemy ENDP

DisplayBar PROC
    INVOKE PrintStr, ADDR bar
    INVOKE PrintCRLF
    ret
DisplayBar ENDP

END