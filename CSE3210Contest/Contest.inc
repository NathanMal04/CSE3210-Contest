.386
.model flat,stdcall
.stack 4096
OPTION PROC:PRIVATE
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc 


; ----Constants----

; base player stats
PLAYER_BASE_ATK		EQU 16
PLAYER_BASE_DEF		EQU 8
PLAYER_BASE_HP		EQU 100
HEAL_MIN			EQU 20
HEAL_MAX			EQU 40
PLAYER_BASE_HEAL	EQU 0



; base enemy stats
ENEMY_BASE_ATK  EQU 12
ENEMY_BASE_DEF  EQU 4
ENEMY_BASE_HP   EQU 50

; enemy stats scaling 
ENEMY_STEP_ATK  EQU 4
ENEMY_STEP_DEF  EQU 2
ENEMY_STEP_HP   EQU 15



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
EXTERNDEF gGold:DWORD
EXTERNDEF gGameState:DWORD
EXTERNDEF gHealPots:DWORD

; ----Prototypes----

; ui
PrintCRLF		PROTO
ClearScreen		PROTO
PrintStr		PROTO pStr:PTR BYTE
PrintNum		PROTO val:DWORD
DisplayPlayer	PROTO
DisplayEnemy	PROTO
DisplayBar		PROTO
DisplayMenu		PROTO

; enemy
CreateEnemy		PROTO

; battle
BattleLoop		PROTO