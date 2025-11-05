INCLUDE Contest.inc

.data
playerDMG   BYTE "You dealt ",0
enemyDMG    BYTE "Enemy dealt ",0
endDMG		BYTE " damage",0
continue	BYTE "Press any key to continue",0
win			BYTE "You defeated the enemy",0
lose		BYTE "The enemy has defeated you",0

.code
PrintStats MACRO
	INVOKE ClearScreen
	INVOKE DisplayPlayer
	INVOKE DisplayEnemy
	INVOKE DisplayBar
ENDM

PUBLIC BattleLoop
BattleLoop PROC
MainLoop:
	PrintStats
	INVOKE DisplayMenu
	call ReadChar
	CMP al, '1'
	JE Attack
	CMP al, '2'
	JE Heal

Attack:
	MOV EAX, gPlayerATK
	SHR EAX, 2
	MOV EBX, EAX
	SHR EBX, 1
	CALL RandomRange
	SUB EAX, EBX
	ADD EAX, gPlayerATK
	SUB EAX, gEnemyDEF
	SUB gEnemyHP, EAX
	MOV EBX, EAX

	PrintStats
	INVOKE PrintStr, ADDR playerDMG
	INVOKE PrintNum, EBX
	INVOKE PrintStr, ADDR endDMG
	INVOKE PrintCRLF
	INVOKE PrintStr, ADDR continue
	call ReadChar

	CMP gEnemyHP, 0
	JLE WinBattle

	MOV EAX, gEnemyATK
	SHR EAX, 2
	MOV EBX, EAX
	SHR EBX, 1
	CALL RandomRange
	SUB EAX, EBX
	ADD EAX, gEnemyATK
	SUB EAX, gPlayerDEF
	SUB gPlayerHP, EAX
	MOV EBX, EAX

	PrintStats
	INVOKE PrintStr, ADDR enemyDMG
	INVOKE PrintNum, EBX
	INVOKE PrintStr, ADDR endDMG
	INVOKE PrintCRLF
	INVOKE PrintStr, ADDR continue
	call ReadChar

	CMP gPlayerHP, 0
	JLE LoseBattle

	JMP MainLoop

Heal:
	
LoseBattle:
	MOV gGameState, 0
	ret
WinBattle:
	MOV EAX, 20
	MUL gLevel
	ADD gGold, EAX
	INVOKE CreateEnemy
	ret
BattleLoop ENDP

END