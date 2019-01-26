#include "..\..\script_macros.hpp"
/*
	File: fn_vAH_takeBack.sqf
	Author: Fresqo
	Description: takes back the item from auction house if its still for sale or expired.
*/
private["_dialog","_myListbox","_data","_typeb","_type","_status","_item","_diff","_iCheck","_amount","_tamount","_id","_checkid","_found","_d","_e"];
disableSerialization;
_dialog = findDisplay 15600;
_myListbox = _dialog displayCtrl 15601;

if (!vAH_loaded) exitWith {hint "L'HDV est occupée en ce moment, veuillez réessayer dans quelques instants!"};

if (lbCurSel _myListbox < 0) exitWith {hint "Veuillez sélectionner un article";};
_data = call compile (_myListbox lbData (lbCurSel _myListbox));

_item = _data select 0;
if (_item IsEqualTo "yolo") exitWith {};
_typeb = _data select 1;
_status = [_data,2,3,[3]] call BIS_fnc_param;
_amount = [_data,3,0,[0]] call BIS_fnc_param;
_id = _data select 4;
_iCheck = true;

if (_status IsEqualTo 3) exitWith {hint "Vous ne pouvez pas récupérer un article déjà dans votre inventaire!";};

_e = missionNamespace getVariable [format["ahItem_%1",_id],false];
if (player getVariable["ahID",0] != _id && !_e) exitWith {hint "Quelqu'un peut acheter ou récupérer cet article en ce moment même!";};

if(_typeb IsEqualTo "ymenu") then {_type = 0} else {_type = 1};

_found = [];
{_checkid = _x select 0;if (_checkid IsEqualTo _id) then {_found pushBack _checkid};}forEach all_ah_items;
if (count _found IsEqualTo 0) exitWith {hint "Cet article a été vendu récemment";};

if (_type IsEqualTo 0) then {
_diff = [_item,_amount,life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
if(_diff < _amount) then {_iCheck = false;};
} else {if (_type IsEqualTo 1)then { if (_amount > 1) then {
_iCheck = [_item,_amount] call life_fnc_vAH_checkItem;
		};
	};
};

if(!_iCheck) exitWith {hint localize "STR_NOTF_InvFull";};

switch (_type) do {
	case 0: {[true,_item,_diff] call life_fnc_handleInv;};
	case 1: {
	_tamount = _amount + 1;
			for [{_i=1}, {_i<_tamount}, {_i=_i+1}] do
		{
			[_item,true] call life_fnc_handleItem;
		};
	};
};

[1,_id] remoteExec ["TON_fnc_vAH_update"];

hint "Article récupéré avec succès";
closedialog 0;

[3] call SOCK_fnc_updatePartial;
