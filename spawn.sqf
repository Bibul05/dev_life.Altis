///Olegan///

_target = _this select 0;  // Object that had the Action (also _target in the addAction command)
_caller = _this select 1;  // Unit that used the Action (also _this in the addAction command)
_action = _this select 2;  // ID of the Action

_target removeAction _action;



if ((side player) == license_civ_dog && civilian) then {

// Spawn dog
OLE_dog = createAgent ["Fin_random_F", getPos player, [], 5, "CAN_COLLIDE"];

// Disable animal behaviour
OLE_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];

// Following loop
0 = [OLE_dog] spawn {
	params ["_dog"];

	// Force dog to sprint
	OLE_dog playMove "Dog_Sprint";
	
	while {alive OLE_dog} do 
	{
		OLE_dog moveTo getPos player;

		sleep 0.5;
	};
};

hint "Vous avez acheté un chien";
execVM "oledog\doginit.sqf";
};

if ((side player) == blufor) then {
    hint "Les gendarme ne peuvent pas acheter de chien ici !";
};

