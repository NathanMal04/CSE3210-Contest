INCLUDE Contest.inc

.data
; ----Local----

; ----Global----

; misc
PUBLIC gLevel
gLevel DWORD 1

; player
PUBLIC gPlayerHP
PUBLIC gPlayerMaxHP
PUBLIC gPlayerATK 
PUBLIC gPlayerDEF

gPlayerHP     DWORD PLAYER_BASE_HP
gPlayerMaxHP  DWORD PLAYER_BASE_HP
gPlayerATK    DWORD PLAYER_BASE_ATK
gPlayerDEF    DWORD PLAYER_BASE_DEF

; enemy
PUBLIC gEnemyHP 
PUBLIC gEnemyMaxHP
PUBLIC gEnemyATK
PUBLIC gEnemyDEF
gEnemyHP      DWORD ENEMY_BASE_HP
gEnemyMaxHP   DWORD ENEMY_BASE_HP
gEnemyATK     DWORD ENEMY_BASE_ATK
gEnemyDEF     DWORD ENEMY_BASE_DEF

.code
END