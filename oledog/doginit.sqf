///Olegan///


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


// Actions for following
player addAction ["Au pied", {[] call ole_dogaupied;}];

// Actions for behaviour override
player addAction ["Stop", {OLE_dog playMove "Dog_Stop";}];
player addAction ["Assis", {OLE_dog playMove "Dog_Sit";}];
player addAction ["Calme", {OLE_dog playMove "Dog_Walk";}];
player addAction ["Au pas", {OLE_dog playMove "Dog_Run";}];
player addAction ["go", {OLE_dog playMove "Dog_Sprint";}];