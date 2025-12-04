INCLUDE Contest.inc

.data
menu			BYTE "Choose: 1)Attack  2)Heal  >",0
choice			BYTE "What enemy will you attack? ",0
playerDMG		BYTE "You dealt ",0
enemyDMG		BYTE "Enemy dealt ",0
endDMG			BYTE " damage",0
continue		BYTE "Press any key to continue",0
win				BYTE "You defeated the enemy",0
lose			BYTE "The enemy has defeated you",0
runOut			BYTE "No healing left",0
startHeal		BYTE "You healed for ",0
endHeal			BYTE " HP",0

.code
PrintStats PROC
	INVOKE ClearScreen
	INVOKE DisplayPlayer
	INVOKE DisplayBar
	MOV ECX, 1
	ListEnemies:
		INVOKE DisplayEnemy, ECX
		INC ECX
		CMP ECX, gEnemyCount
		JLE ListEnemies
	INVOKE DisplayBar
	ret
PrintStats ENDP

BattleLoop PROC
MainLoop:
	INVOKE PrintStats
	INVOKE PrintStr, ADDR menu
	call ReadChar
	CMP al, '1'
	JE AttackBegin
	CMP al, '2'
	JE Heal

	JMP MainLoop

AttackBegin:
	CMP gEnemyCount, 1
	JNE ChooseEnemy
	MOV ECX, 1
	JMP AttackEnemy
ChooseEnemy:
	INVOKE PrintStats
	INVOKE PrintStr, ADDR choice
	XOR EAX, EAX
	call ReadDec
	MOV ECX, EAX
AttackEnemy:
	MOV ESI, SIZEOF Enemy
    IMUL ESI, ECX
    SUB ESI, SIZEOF Enemy
	MOV EAX, gPlayerATK
	SHR EAX, 2
	MOV EBX, EAX
	SHR EBX, 1
	INC EAX
	CALL RandomRange
	SUB EAX, EBX
	ADD EAX, gPlayerATK
	SUB EAX, gEnemies[ESI].DEF
	SUB gEnemies[ESI].HP, EAX
	MOV EBX, EAX

	INVOKE PrintStats
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

	INVOKE PrintStats
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
DisplayHeal:
	MOV EBX, EAX
	SUB EBX, gPlayerHP
	MOV gPlayerHP, EAX
	INVOKE PrintStats
	INVOKE PrintStr, ADDR startHeal
	INVOKE PrintNum, EBX
	INVOKE PrintStr, ADDR endHeal
	INVOKE PrintCRLF
	INVOKE PrintStr, ADDR continue
	call ReadChar
	JMP MainLoop
OutOfPots:
	INVOKE PrintStats
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
	MOV EDX, 0
	MUL gLevel
	ADD gGold, EAX
	INVOKE LevelUpEnemy
	ret
BattleLoop ENDP

END