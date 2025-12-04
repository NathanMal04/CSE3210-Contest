INCLUDE Contest.inc

.data
; ----Local----
menu	BYTE "Game Over! Choose: 1)Restart  2)Exit >",0

; ----Global----

; misc
PUBLIC gLevel
PUBLIC gGold
PUBLIC gGameState

gLevel		DWORD 1
gGold		DWORD 0
gGameState	DWORD 1

; player
PUBLIC gPlayerHP
PUBLIC gPlayerMaxHP
PUBLIC gPlayerATK 
PUBLIC gPlayerDEF
PUBLIC gHealPots
PUBLIC gHealing

gPlayerHP     DWORD PLAYER_BASE_HP
gPlayerMaxHP  DWORD PLAYER_BASE_HP
gPlayerATK    DWORD PLAYER_BASE_ATK
gPlayerDEF    DWORD PLAYER_BASE_DEF
gHealPots	  DWORD PLAYER_BASE_HEAL
gHealing	  DWORD HEAL_MIN

; enemy
PUBLIC gEnemies
PUBLIC gEnemyCount

gEnemies Enemy 3 DUP(<0,0,0,0>)
gEnemyCount DWORD 1

PUBLIC gEnemyHP 
PUBLIC gEnemyMaxHP
PUBLIC gEnemyATK
PUBLIC gEnemyDEF

gEnemyHP      DWORD ENEMY_BASE_HP
gEnemyMaxHP   DWORD ENEMY_BASE_HP
gEnemyATK     DWORD ENEMY_BASE_ATK
gEnemyDEF     DWORD ENEMY_BASE_DEF

; shop
PUBLIC gShopHP
PUBLIC gShopATK
PUBLIC gShopDEF
PUBLIC gShopHPot

gShopHP		DWORD PLAYER_UPGRADE_HP_PRICE
gShopATK	DWORD PLAYER_UPGRADE_ATK_PRICE
gShopDEF	DWORD PLAYER_UPGRADE_DEF_PRICE
gShopHPot	DWORD PLAYER_UPGRADE_HPot_PRICE


.code
PUBLIC main
init PROC

	INVOKE Randomize
	MOV gLevel, 1
	MOV gGold, 0
	MOV gGameState, 1

	MOV gPlayerHP, PLAYER_BASE_HP
	MOV gPlayerMaxHP, PLAYER_BASE_HP
	MOV gPlayerATK, PLAYER_BASE_ATK
	MOV gPlayerDEF, PLAYER_BASE_DEF
	MOV gHealPots, PLAYER_BASE_HEAL
	MOV gHealing, HEAL_MIN

	MOV gEnemyHP, ENEMY_BASE_HP
	MOV gEnemyMaxHP, ENEMY_BASE_HP
	MOV gEnemyATK, ENEMY_BASE_ATK
	MOV gEnemyDEF, ENEMY_BASE_DEF

	MOV gShopHP, PLAYER_UPGRADE_HP_PRICE
	MOV gShopATK, PLAYER_UPGRADE_ATK_PRICE
	MOV gShopDEF, PLAYER_UPGRADE_DEF_PRICE
	MOV gShopHPot, PLAYER_UPGRADE_HPot_PRICE

	ret
init ENDP

main PROC
Start:
	INVOKE init
Battle:
	INVOKE CreateEnemy
	INVOKE BattleLoop
	MOV EAX, gGameState
	CMP EAX, 0
	JZ gameEnd
	INC gLevel

	INVOKE Shop
	JMP Battle
gameEnd:
	INVOKE ClearScreen
	INVOKE PrintStr, ADDR menu
	call ReadChar
	CMP al, '1'
	JE Start
	CMP al, '2'
	JE Quit

	JMP gameEnd

Quit:
	exit
main ENDP
END main