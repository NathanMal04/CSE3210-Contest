INCLUDE Contest.inc

.code

; sets up the enemy to have inceasing stats over time
PUBLIC CreateEnemy
CreateEnemy PROC
	MOV EAX, ENEMY_STEP_HP
	CALL RandomRange
	ADD gEnemyMaxHP, EAX
	MOV EAX, gEnemyMaxHP
	MOV gEnemyHP, EAX

	MOV EAX, ENEMY_STEP_ATK
	CALL RandomRange
	ADD gEnemyATK, EAX

	MOV EAX, ENEMY_STEP_DEF
	CALL RandomRange
	ADD gEnemyDEF, EAX
	ret
CreateEnemy ENDP
END