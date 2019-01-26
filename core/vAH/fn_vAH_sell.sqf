#include "..\..\script_macros.hpp"
/*
	File: fn_vAH_sell.sqf
	Author: Fresqo
	Description: sells items to our auction house and blah blah too much fml
*/

private["_able","_uid","_dialog","_myListbox","_myQuantity","_onGuy","_details","_tquantity","_myTotal","_price","_typeb","_type","_classname","_realName","_bad","_tax","_action","_selectedSell","_quantity","_tochangePriceText","_tochangePriceNumber","_tochangeQuantityText","_tochangeQuantityNumber","_invItem"];
disableSerialization;
_dialog = findDisplay 15600;
_myListbox = _dialog displayCtrl 15601;
_able = 10;

_bad = false;
_realName = "";

_uid = getPlayerUID player;
if (({_x select 5 IsEqualto _uid} count all_ah_items) >= _able) exitWith {hint format["Vous ne pouvez avoir que %1 articles dans la liste",_able];closeDialog 0;};

_price = ctrlText 15603;
_quantity = ctrlText 15602;

if(! ([_price] call TON_fnc_isnumber)) exitWith {hint "Vous devez entrer un nombre dans le champ de prix.";};
if(! ([_quantity] call TON_fnc_isnumber)) exitWith {hint "Vous devez entrer un nombre dans le champ de quantité.";};
_price = parseNumber _price;
_quantity = parseNumber _quantity;

if (lbCurSel _myListbox < 0) exitWith {hint "Veuillez sélectionner un article";};
_selectedSell = call compile (_myListbox lbData (lbCurSel _myListbox));

_classname = _selectedSell select 0;
if (_classname IsEqualTO "yolo") exitWith {};
_typeb = _selectedSell select 1;
_invItem = [_selectedSell,2,3,[3]] call BIS_fnc_param;
if (_invItem != 3) exitWith {hint "Vous ne pouvez pas vendre un article qui est déjà dans l'HDV"};
if(_typeb IsEqualto "ymenu") then {_type = 0} else {_type = 1};

if (_price < 1) exitWith {hint "valeur invalide"};
if (_price > 9000000) exitWith {hint "Valeur invalide. Doit être inférieur à 9 millions"};

_tax = round (_price * 0.03);

switch (_type) do
{
	case 0: {
				_realName = localize ITEM_NAME(_classname);
				if (_quantity > 100) then {_bad = true; hint "Es-tu en train de te moquer de moi, ne sois pas un connard, mets un montant approprié!"};
			};
	case 1: {if (_quantity > 1) then
			{
				_details = [_classname] call life_fnc_fetchCfgDetails;
				if (!(_details select 6 IsEqualTo "CfgMagazines")) then {
				hint "Vous ne pouvez vendre que 1 de cet article!";_bad = true;};
				_onGuy = {_classname IsEqualTo _x} count (magazines player);
				if (_onGuy < _quantity) then {hint "Vous n'en avez pas autant!";_bad = true;}
			};
			_realName = ([_classname] call life_fnc_fetchCfgDetails) select 1;
			};
};

if (_bad) exitWith {closeDialog 0;};

_action = [format["Vous serez taxé de $%1 . Continuer?",_tax],"Comfirmation de la vente","CONTINUER","ANNULER"] call BIS_fnc_guiMessage;
if(_action) then {
		if(BANK < _tax) exitWith {hint "Vous n'avez pas assez d'argent à la banque pour payer la taxe";_bad = true;};

	switch (_type) do {
		case 0: {if(!([false,_classname,_quantity] call life_fnc_handleInv)) then {hint "Vous n'en avez pas autant!";_bad = true;};};
		case 1: {
			_tquantity = _quantity +1;
			for [{_i=1}, {_i<_tquantity}, {_i=_i+1}] do
			{
				[_classname,false] spawn life_fnc_handleItem;
			};
		};
	};
	if (_bad) exitWith {closeDialog 0;};
	[4,_type,_quantity,_price,getPlayerUID player,_classname,_realName,name player] remoteExec ["TON_fnc_vAH_update"];
	hint "Ajouté a l'HDV";
	BANK = BANK - _tax;
	closeDialog 0;
} else {
	closeDialog 0;
};

[1] call SOCK_fnc_updatePartial;
[3] call SOCK_fnc_updatePartial;
