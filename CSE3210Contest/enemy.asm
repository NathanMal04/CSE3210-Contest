INCLUDE Contest.inc

.data
PUBLIC gEnemies
PUBLIC gEnemyCount

gEnemies Enemy 3 DUP(<0,0,0,0>)
gEnemyCount DWORD 1

.code
; sets up the enemy to have inceasing stats over time
LevelUpEnemy PROC
	MOV EAX, ENEMY_STEP_HP
	INC EAX
	CALL RandomRange
	ADD gEnemyMaxHP, EAX
	MOV EAX, gEnemyMaxHP
	MOV gEnemyHP, EAX

	MOV EAX, ENEMY_STEP_ATK
	INC EAX
	CALL RandomRange
	ADD gEnemyATK, EAX

	MOV EAX, ENEMY_STEP_DEF
	INC EAX
	CALL RandomRange
	ADD gEnemyDEF, EAX
	ret
LevelUpEnemy ENDP
	
CreateEnemy PROC
	MOV EAX, 3
	call RandomRange
	INC EAX
	MOV gEnemyCount, EAX
	MOV ECX, gEnemyCount
	InitEnemyLoop:
		MOV ESI, SIZEOF Enemy
		IMUL ESI, ECX
		MOV EAX, gEnemyMaxHP
		MOV gEnemies[ESI].HP, EAX
		MOV gEnemies[ESI].MaxHP, EAX
		MOV EAX, gEnemyATK
		MOV gEnemies[ESI].ATK, EAX
		MOV EAX, gEnemyDEF
		MOV gEnemies[ESI].DEF, EAX
		LOOP InitEnemyLoop
	ret
CreateEnemy ENDP

END