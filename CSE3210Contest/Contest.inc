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
ENEMY_BASE_ATK  EQU 4
ENEMY_BASE_DEF  EQU 2
ENEMY_BASE_HP   EQU 18

; enemy stats scaling 
ENEMY_STEP_ATK  EQU 2
ENEMY_STEP_DEF  EQU 1
ENEMY_STEP_HP   EQU 5



; ----Shared Variables----

; player stats
EXTERNDEF gPlayerHP:DWORD
EXTERNDEF gPlayerMaxHP:DWORD
EXTERNDEF gPlayerATK:DWORD
EXTERNDEF gPlayerDEF:DWORD

; enemy stats
EXTERNDEF gEnemyHP:DWORD
EXTERNDEF gEnemyMaxHP:DWORD
EXTERNDEF gEnemyATK:DWORD
EXTERNDEF gEnemyDEF:DWORD

; misc values
EXTERNDEF gLevel:DWORD

; ----Prototypes----

; ui
PrintCRLF		PROTO
ClearScreen		PROTO
PrintStr		PROTO pStr:PTR BYTE
PrintNum		PROTO val:DWORD
DisplayPlayer	PROTO
DisplayEnemy	PROTO