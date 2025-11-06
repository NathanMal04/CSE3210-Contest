INCLUDE Contest.inc

.data
menu1		BYTE "Choose: 1)HP: $",0
menu2		BYTE "  2)ATK: $",0
menu3		BYTE "  3)DEF: $",0
menu4		BYTE "  4)Health Potion: $",0
menu5		BYTE "  5)Exit  >",0
gold		BYTE "Gold: ",0
broke		BYTE "Not enough gold",0

.code
Shop PROC
MainLoop:
	INVOKE DisplayPlayer
	INVOKE PrintStr, ADDR gold
	INVOKE PrintNum, gold
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
	ATK:
	DEF:
	HPot:
	Quit:
	JMP MainLoop

Shop ENDP

END