///Olegan///

_target = _this select 0;  // Object that had the Action (also _target in the addAction command)
_caller = _this select 1;  // Unit that used the Action (also _this in the addAction command)
_action = _this select 2;  // ID of the Action

_target removeAction _action;

if ((side player) == civilian) then {

_dog = [player, "Fin_tricolour_F", (player modelToWorld [2,2,0]), true] call JBOY_dog_create;
nul = [_dog, player, 2.5] execVM "JBOY_Dog\JBOY_dogCommand.sqf";
hint "Vous avez acheté un chien";
sleep 5;
hint "Appuyer sur T pour lui donner des ordres";
};

if ((side player) == blufor) then {
    hint "Les gendarme ne peuvent pas acheter de chien ici !";
};

