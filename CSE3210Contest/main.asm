INCLUDE Contest.inc

.data
; ----Local----

; ----Global----

; misc
PUBLIC gLevel
PUBLIC gGold
PUBLIC gGameState

gLevel		DWORD 0
gGold		DWORD 0
gGameState	DWORD 1

; player
PUBLIC gPlayerHP
PUBLIC gPlayerMaxHP
PUBLIC gPlayerATK 
PUBLIC gPlayerDEF
PUBLIC gHealPots

gPlayerHP     DWORD PLAYER_BASE_HP
gPlayerMaxHP  DWORD PLAYER_BASE_HP
gPlayerATK    DWORD PLAYER_BASE_ATK
gPlayerDEF    DWORD PLAYER_BASE_DEF
gHealPots	  DWORD PLAYER_BASE_HEAL

; enemy
PUBLIC gEnemyHP 
PUBLIC gEnemyMaxHP
PUBLIC gEnemyATK
PUBLIC gEnemyDEF

gEnemyHP      DWORD ENEMY_BASE_HP
gEnemyMaxHP   DWORD ENEMY_BASE_HP
gEnemyATK     DWORD ENEMY_BASE_ATK
gEnemyDEF     DWORD ENEMY_BASE_DEF

.code
PUBLIC main
main PROC
Battle:
	INVOKE BattleLoop
	MOV EAX, gGameState
	CMP EAX, 0
	JZ Quit
Shop:
	MOV EAX, gGameState
	CMP EAX, 0
	JNZ Battle
Quit:
	exit
main ENDP
END main