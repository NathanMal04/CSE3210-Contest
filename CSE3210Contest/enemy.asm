INCLUDE Contest.inc

.data
gEnemies Enemy ENEMY_COUNT DUP(<0,0,0,0>)
gEnemyCount DWORD 1

.code
; sets up the enemy to have inceasing stats over time
CreateEnemy PROC
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
CreateEnemy ENDP
END