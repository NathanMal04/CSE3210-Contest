.386
.model flat,stdcall
.stack 4096
OPTION PROC:PRIVATE
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc 


; ----Constants----

; base player stats
PLAYER_BASE_ATK EQU 6
PLAYER_BASE_DEF EQU 3
PLAYER_BASE_HP  EQU 30
HEAL_MIN		EQU 6
HEAL_MAX        EQU 12



; base enemy stats
ENEMY_ATK_BASE  EQU 4
ENEMY_DEF_BASE  EQU 2
ENEMY_HP_BASE   EQU 18

; enemy stats scaling 
ENEMY_ATK_STEP  EQU 2
ENEMY_DEF_STEP  EQU 1
ENEMY_HP_STEP   EQU 5

