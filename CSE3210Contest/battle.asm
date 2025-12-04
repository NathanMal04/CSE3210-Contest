INCLUDE Contest.inc

.data
menu			BYTE "Choose: 1)Attack  2)Heal  >",0
choice			BYTE "What enemy will you attack? ",0
playerDMG		BYTE "You dealt ",0
enemyDMGNUM		BYTE "Enemy #",0
enemyDMGVAL		BYTE " dealt ",0
endDMG			BYTE " damage",0
continue		BYTE "Press any key to continue",0
win				BYTE "You defeated the enemy",0
lose			BYTE "The enemy has defeated you",0
runOut			BYTE "No healing left",0
startHeal		BYTE "You healed for ",0
endHeal			BYTE " HP",0

battleTracker	DWORD 0

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
MOV EAX, gEnemyCount
MOV battleTracker, EAX
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
	CMP EAX, gEnemyCount
	JG ChooseEnemy
	CMP EAX, 0
	JLE ChooseEnemy
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
	CMP gEnemies[ESI].HP, 0
	JG Results
	DEC battleTracker

Results:
	INVOKE PrintStats
	INVOKE PrintStr, ADDR playerDMG
	INVOKE PrintNum, EBX
	INVOKE PrintStr, ADDR endDMG
	INVOKE PrintCRLF
	INVOKE PrintStr, ADDR continue
	call ReadChar

	CMP battleTracker, 0
	JE WinBattle

	MOV EDI, 1
EnemyAttack:
	MOV ESI, SIZEOF Enemy
    IMUL ESI, EDI
    SUB ESI, SIZEOF Enemy

	CMP gEnemies[ESI].HP, 0
	JG EnemyAlive
	INC EDI
	JMP EnemyAttack

EnemyAlive:
	MOV EAX, gEnemies[ESI].ATK
	SHR EAX, 2
	MOV EBX, EAX
	SHR EBX, 1
	INC EAX
	CALL RandomRange
	SUB EAX, EBX
	ADD EAX, gEnemies[ESI].ATK
	SUB EAX, gPlayerDEF
	CMP EAX, 0
	JGE NoNegDMG
	MOV EAX, 0
	NoNegDMG:
	SUB gPlayerHP, EAX
	MOV EBX, EAX

	INVOKE PrintStats
	INVOKE PrintStr, ADDR enemyDMGNUM
	INVOKE PrintNum, EDI
	INVOKE PrintStr, ADDR enemyDMGVAL
	INVOKE PrintNum, EBX
	INVOKE PrintStr, ADDR endDMG
	INVOKE PrintCRLF
	INVOKE PrintStr, ADDR continue
	call ReadChar

	CMP gPlayerHP, 0
	JLE LoseBattle

	INC EDI
	CMP EDI, gEnemyCount
	JLE EnemyAttack

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