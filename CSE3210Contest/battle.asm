INCLUDE Contest.inc

.data
menu		BYTE "Choose: 1)Attack  2)Heal  >",0
playerDMG   BYTE "You dealt ",0
enemyDMG    BYTE "Enemy dealt ",0
endDMG		BYTE " damage",0
continue	BYTE "Press any key to continue",0
win			BYTE "You defeated the enemy",0
lose		BYTE "The enemy has defeated you",0
runOut		BYTE "No healing left",0
startHeal	BYTE "You healed for ",0
endHeal		BYTE " HP",0

.code
PrintStats MACRO
	INVOKE ClearScreen
	INVOKE DisplayPlayer
	INVOKE DisplayEnemy
	INVOKE DisplayBar
ENDM

BattleLoop PROC
MainLoop:
	PrintStats
	INVOKE PrintStr, ADDR menu
	call ReadChar
	CMP al, '1'
	JE Attack
	CMP al, '2'
	JE Heal

	JMP MainLoop

Attack:
	MOV EAX, gPlayerATK
	SHR EAX, 2
	MOV EBX, EAX
	SHR EBX, 1
	INC EAX
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
	INC EAX
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
	CMP gHealPots, 0
	JE OutOfPots
	DEC gHealPots
	MOV EAX, gHealing
	INC EAX
	call RandomRange
	ADD EAX, gHealing
	ADD EAX, gPlayerHP
	CMP EAX, gPlayerMaxHP
	JLE DisplayHeal
	MOV EAX, gPlayerMaxHP
	SUB EAX, gPlayerHP
	MOV EBX, EAX
DisplayHeal:
	ADD gPlayerHP, EAX
	PrintStats
	INVOKE PrintStr, ADDR startHeal
	INVOKE PrintNum, EBX
	INVOKE PrintStr, ADDR endHeal
	INVOKE PrintCRLF
	INVOKE PrintStr, ADDR continue
	call ReadChar
	JMP MainLoop
OutOfPots:
	PrintStats
	INVOKE PrintSTR, ADDR runOut
	call ReadChar
	JMP MainLoop
LoseBattle:
	INVOKE ClearScreen
	INVOKE PrintStr, ADDR lose
	INVOKE PrintCRLF
	INVOKE PrintStr, ADDR continue
	call ReadChar
	MOV gGameState, 0
	ret
WinBattle:
	INVOKE ClearScreen
	INVOKE PrintStr, ADDR win
	INVOKE PrintCRLF
	INVOKE PrintStr, ADDR continue
	call ReadChar
	MOV EAX, 20
	MUL gLevel
	ADD gGold, EAX
	INVOKE CreateEnemy
	ret
BattleLoop ENDP

END