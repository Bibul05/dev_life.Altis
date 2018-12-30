///Olegan///

if (license_civ_dog) then {
// Following player
ole_dogaupied = {
	OLE_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];
	
	OLE_dogaupied = true;
	
	0 = [] spawn {
		while {ole_dogaupied} do 
		{
			if (alive OLE_dog) then 
			{
				OLE_dog moveTo getPos player;				
				
				sleep 0.5;
			};
		};
	};
};
};
if (license_civ_dog) then {
// Actions for following
player addAction ["Au pied", {[] call ole_dogaupied;}];

// Actions for behaviour override
player addAction ["Stop", {OLE_dog playMove "Dog_Stop";}];
player addAction ["Assis", {OLE_dog playMove "Dog_Sit";}];
player addAction ["Calme", {OLE_dog playMove "Dog_Walk";}];
player addAction ["Au pas", {OLE_dog playMove "Dog_Run";}];
player addAction ["go", {OLE_dog playMove "Dog_Sprint";}];};

if (license_civ_dog1) then {
// Following player
ole_dogaupied1 = {
	OLE_dog1 setVariable ["BIS_fnc_animalBehaviour_disable", true];
	
	OLE_dogaupied1 = true;
	
	0 = [] spawn {
		while {ole_dogaupied1} do 
		{
			if (alive OLE_dog1) then 
			{
				OLE_dog1 moveTo getPos player;				
				
				sleep 0.5;
			};
		};
	};
};
};
if (license_civ_dog1) then {
// Actions for following
player addAction ["Au pied", {[] call ole_dogaupied1;}];

// Actions for behaviour override
player addAction ["Stop", {OLE_dog1 playMove "Dog_Stop";}];
player addAction ["Assis", {OLE_dog1 playMove "Dog_Sit";}];
player addAction ["Calme", {OLE_dog1 playMove "Dog_Walk";}];
player addAction ["Au pas", {OLE_dog1 playMove "Dog_Run";}];
player addAction ["go", {OLE_dog1 playMove "Dog_Sprint";}];
}: