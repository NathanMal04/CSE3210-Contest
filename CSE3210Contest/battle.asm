INCLUDE Contest.inc

.code
PUBLIC BattleLoop
BattleLoop PROC
MainLoop:
	INVOKE ClearScreen
	INVOKE DisplayPlayer
	INVOKE DisplayEnemy
	INVOKE DisplayBar
	INVOKE DisplayMenu

	call ReadChar
	CMP al, '1'
	JE Attack

Attack:
	MOV EAX, gPlayerATK
	SUB gEnemyHP, EAX
	CMP gEnemyHP, 0
	JL WinBattle

	MOV EAX, gEnemyATK
	SUB gPlayerHP, EAX
	CMP gPlayerHP, 0
	JL LoseBattle

	JMP MainLoop

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