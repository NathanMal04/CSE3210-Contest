INCLUDE Contest.inc

.data
menu1		BYTE "Choose: 1)HP: $",0
menu2		BYTE "  2)ATK: $",0
menu3		BYTE "  3)DEF: $",0
menu4		BYTE "  4)Health Potion: $",0
menu5		BYTE "  5)Exit  >",0
gold		BYTE "Gold: ",0
broke		BYTE "Not enough gold",0
purchase	BYTE "Upgrade purchased",0
continue	BYTE "Press any key to continue",0

.code
Shop PROC
MainLoop:
	INVOKE DisplayPlayer
	INVOKE PrintStr, ADDR gold
	INVOKE PrintNum, gGold
	INVOKE PrintCRLF
	INVOKE PrintStr, ADDR menu1
	INVOKE PrintNum, gShopHP
	INVOKE PrintStr, ADDR menu2
	INVOKE PrintNum, gShopATK
	INVOKE PrintStr, ADDR menu3
	INVOKE PrintNum, gShopDEF
	INVOKE PrintStr, ADDR menu4
	INVOKE PrintNum, gShopHPot
	INVOKE PrintStr, ADDR menu5
	INVOKE PrintCRLF
	call ReadChar
	CMP al, '1'
	JE HP
	CMP al, '2'
	JE ATK
	CMP al, '3'
	JE DEF
	CMP al, '4'
	JE HPot
	CMP al, '5'
	JE Quit

HP:
	INVOKE ClearScreen
	MOV EAX, gGold
	CMP EAX, gShopHP
	JGE uHP
	INVOKE PrintStr, ADDR broke
	INVOKE PrintStr, ADDR continue
	call ReadChar
	JMP MainLoop
uHP:
	MOV EAX, gGold
	SUB EAX, gShopHP
	MOV gGold, EAX
	ADD gShopHP, PLAYER_UPGRADE_HP_PRICE_INC
	ADD gPlayerHP, PLAYER_UPGRADE_HP
	ADD gPlayerMaxHP, PLAYER_UPGRADE_HP
	INVOKE PrintStr, ADDR purchase
	INVOKE PrintStr, ADDR continue
	call ReadChar
	JMP MainLoop
ATK:
	INVOKE ClearScreen
	MOV EAX, gGold
	CMP EAX, gShopATK
	JGE uHP
	INVOKE PrintStr, ADDR broke
	INVOKE PrintStr, ADDR continue
	call ReadChar
	JMP MainLoop
uATK:
	MOV EAX, gGold
	SUB EAX, gShopATK
	MOV gGold, EAX
	ADD gShopATK, PLAYER_UPGRADE_ATK_PRICE_INC
	ADD gPlayerATK, PLAYER_UPGRADE_ATK
	INVOKE PrintStr, ADDR purchase
	INVOKE PrintStr, ADDR continue
	call ReadChar
	JMP MainLoop
DEF:
	INVOKE ClearScreen
	MOV EAX, gGold
	CMP EAX, gShopDEF
	JGE uHP
	INVOKE PrintStr, ADDR broke
	INVOKE PrintStr, ADDR continue
	call ReadChar
	JMP MainLoop
uDEF:
	MOV EAX, gGold
	SUB EAX, gShopDEF
	MOV gGold, EAX
	ADD gShopDEF, PLAYER_UPGRADE_DEF_PRICE_INC
	ADD gPlayerDEF, PLAYER_UPGRADE_DEF
	INVOKE PrintStr, ADDR purchase
	INVOKE PrintStr, ADDR continue
	call ReadChar
	JMP MainLoop
HPot:
	INVOKE ClearScreen
	MOV EAX, gGold
	CMP EAX, gShopHP
	JGE uHP
	INVOKE PrintStr, ADDR broke
	INVOKE PrintStr, ADDR continue
	call ReadChar
	JMP MainLoop
uHPot:
	MOV EAX, gGold
	SUB EAX, gShopHPot
	MOV gGold, EAX
	ADD gShopHPot, PLAYER_UPGRADE_HPot_PRICE_INC
	INC gHealPots
	INVOKE PrintStr, ADDR purchase
	INVOKE PrintStr, ADDR continue
	call ReadChar
	JMP MainLoop
Quit:
	ret
Shop ENDP

END