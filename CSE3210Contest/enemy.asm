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
	ret
CreateEnemy ENDP

CreateSingleEnemy PROC
	MOV gEnemyCount, 1
	MOV EAX, gEnemyMaxHP
	MOV gEnemies[SIZEOF Enemy].HP, EAX
	MOV gEnemies[SIZEOF Enemy].MaxHP, EAX
	MOV EAX, gEnemyATK
	MOV gEnemies[SIZEOF Enemy].ATK, EAX
	MOV EAX, gEnemyDEF
	MOV gEnemies[SIZEOF Enemy].DEF, EAX
	ret
CreateSingleEnemy ENDP

END