//if(!isServer) then {waitUntil{!isNull player}};
// **************************************************************************
// BEGIN OF JBOY DOG INIT.SQF CODE
// *************************************************************************// **************************************************************************
// Compiles all JBOY Dog scripts and initializes some settings
// **************************************************************************
call compile preprocessFileLineNumbers "JBOY_Dog\JBOY_DogInit.sqf";

//if jip player and not server then exit
_JIPplayer = not isServer && isNull player;
if (_JIPplayer) exitwith {};

// **************************************************************************
// Add dog menu to player.  In this example mission, the player unit is named handler1 in the editor.
// **************************************************************************
_dogMenu = [handler1] spawn {params["_handler"];sleep 2; _d=[_handler] call JBOY_fnc_DogDisplayEH;};  
saveLoad = addMissionEventHandler ["Loaded",{
[handler1] spawn {params["_handler"];sleep 2; _d=[_handler] call JBOY_fnc_DogDisplayEH;}
}];

// **************************************************************************
// Create a dog, assign a named handler unit to him, and place the dog next to handler.
// The var _dog now references this newly created dog.  
// If 4th parameter=true, then voice commands will use my voice commanding Boomer.
// If 4th parameter=false, then voice commnads will use generic ARMA voice commands to command dog.
// **************************************************************************
_dog = [handler1, "Fin_tricolour_F", (handler1 modelToWorld [2,2,0]), true] call JBOY_dog_create;  // Create dog. 4th parameter true means use Johnnyboy voice for commands.

// **************************************************************************
// Start command listener for the dog and handler pair.
// **************************************************************************
nul = [_dog, handler1, 2.5] execVM "JBOY_Dog\JBOY_dogCommand.sqf";    
// **************************************************************************
// Set variable to allow other units to take control of dog if dog's handler is killed.  Remove this line if you do not want that.
// **************************************************************************
sleep 1; // allow time for some dog variables to get set before doing next few calls
_dog setVariable ["vOtherHandlers",(units group handler1) - [handler1],true];  // Define array of potential handlers who may take control of dog when current handler killed

//* **************************************************************************
// If you want dogs to track units then do this:
// =============================================
// 1. In the Editor, create a unit to be tracked, and give the unit waypoints to move through.
// 2. Put this line in Unit's init line in the editor (or call it from somewhere else):
//  _dmy = [this] spawn {params["_fugitive"]; sleep 2; _dmy=[_fugitive] call JBOY_dogPreyInit;}; 
// Note: The tanoan thug near the flag pole in this mission has this statement in his init, and he will make a trail

// **************************************************************************
// Start loop for dog to detect scent trails
// **************************************************************************
_dmy = [_dog] spawn {params["_dog"]; sleep 1; _d=[_dog] call JBOY_DogScentDetectionLoop;};  

// **************************************************************************
// Code block below adds action to player to start a live camera feed from dog.
// With this activated, player sees what the dog sees.  Thank AZCoder for this awesome feature!
// In this example mission, doggy cam is always on.  If I was using this in a mission 
// I would probably add actions to the action menu to turn the live feed on/off.
// **************************************************************************
player addAction ["Dog Cam Live Feed: Start", 
{   
	waitUntil { !isNil "AZC_FNC_LIVE_FEED" && !isNil "AZC_FNC_PIP" };
	sleep 1;
	_dog = player getVariable "vDog";
	[_dog, player, 0] call AZC_FNC_LIVE_FEED;
}];
// Use this command to terminate doggy cam live feed any time
player addAction ["Dog Cam Live Feed: Terminate",{[] call BIS_fnc_liveFeedTerminate;}];
//[] call BIS_fnc_liveFeedTerminate;

/* **************************************************************************
How to have a dog follow an AI handler:  	
THIS V1.4 SAMPLE MISSION NOW HAS A SENTRY AI NAMED sentry1 DOING EXACTLY THIS, AND WALKING WAYPOINTS UNTIL DOG SENSES ENEMY.
======================================
1. Create an AI unit, name him, and give him move waypoints.  Speed set to Limited works best for keeping dog close to handler.
2. Paste the code below into the unit's init field.  In this case I am giving him 2 dogs. (one named Zagor, and one named GrumpyOldDog).
3. This example reduces enemy detection distance down to 40 meters instead of default of 70 meters
4. Also in code below you see I named the dog "Zagor".  For non-boomer dogs, you can now name the dog to another name.
5. I also decided to make this handler french, so he commands his two dogs in French
    _randomDog = selectRandom ["Fin_blackwhite_F","Fin_ocherwhite_F","Fin_tricolour_F","Alsatian_Sand_F","Alsatian_Black_F","Alsatian_Sandblack_F"];
    _dog = [_handler, _randomDog, (_handler modelToWorld [3,4,0]), false] call JBOY_dog_create; 


_dmy= [this] spawn 
{ 
    params["_handler"]; 
 [_handler, "Male04FRE"] remoteExecCall ["setSpeaker", 0]; 
    sleep 1; 
    _dog = [_handler, "Fin_blackwhite_F", (_handler modelToWorld [3,4,0]), false] call JBOY_dog_create; 
 _dog setVariable ["vEnemyDetectDistance", 40, true];  
    _dmy = [_dog, _handler, 2.5] execVM "JBOY_Dog\JBOY_dogCommand.sqf";  
 _dog setVariable ["vDogName", "Zagor", true]; 
 sleep 1; 
    _dog setVariable ["vCommand", 'heel', true]; 
};

_dmy= [this] spawn 
{ 
    params["_handler"]; 
 [_handler, "Male04FRE"] remoteExecCall ["setSpeaker", 0]; 
    sleep 1; 
    _dog = [_handler, "Alsatian_Sandblack_F", (_handler modelToWorld [3,4,0]), false] call JBOY_dog_create; 
 _dog setVariable ["vEnemyDetectDistance", 40, true];  
    _dmy = [_dog, _handler, 2.5] execVM "JBOY_Dog\JBOY_dogCommand.sqf";  
 _dog setVariable ["vDogName", "GrumpyOldDog", true]; 
 sleep 1; 
    _dog setVariable ["vCommand", 'heel', true]; 
}; 

*****************************************************************************/

// **************************************************************************
// Uncomment the following lines to create some animals for dog to attack and fetch.
// **************************************************************************
/*
R1 = createAgent ['Rabbit_F', player modelToWorld [0,30,0], [], 0, "NONE"];
R2 = createAgent ['Rabbit_F', player modelToWorld [2,30,0], [], 0, "NONE"];
R3 = createAgent ['Rabbit_F', player modelToWorld [-2,30,0], [], 0, "NONE"];
C1 = createAgent ['Cock_random_F', player modelToWorld [3, 20, 0], [], 0, "NONE"];
C2 = createAgent ['Cock_white_F', player modelToWorld [0, 20,0], [], 0, "NONE"];
{[_x] execVM "JBOY\addBirdDamageEH.sqf";}   foreach [R1,R2,R3]; // add feather effect to chickens when shot
{nul = [_x,true] execVM "JBOY\JBOY_animalScatter.sqf";} foreach [R1,R2,R3,C1,C2]; // rabbits will scatter when dog or man near.
S1 = createAgent ['Snake_random_F', player modelToWorld [3, 10, 0], [], 0, "NONE"];
S2 = createAgent ['Snake_random_F', player modelToWorld [1, 12, 0], [], 0, "NONE"];
*/

// **************************************************************************
// To spawn a feral dog pack, place a trigger on the map, and name it dogPackTrigger1.
// Then paste the code below into that trigger.
// Make trigger radius 400 x 400 (or larger...you don't want player to see pack spawn)
// Make trigger activated by anybody present
// **************************************************************************
/*
_dmy=[] spawn 
{
    _pos = getpos dogPackTrigger1; 
    _followerDogTypes = ["Fin_blackwhite_F","Fin_ocherwhite_F","Fin_tricolour_F","Alsatian_Black_F","Alsatian_Sandblack_F"];   
    _pack = [_pos, 7, "Alsatian_Sand_F", _followerDogTypes, 50] call JBOY_dogPackCreate; 
}; 
*/
hint "Use T key to see dog command menu.  Move towards red flag pole if you want dog to detect a scent trail.  In the editor, look at the unit init of the unit by the flag pole for the code that stars dropping a scent trail.
To spawn a dog pack walk on to the runway.  Look at the code in trigger covering runway to see how to spawn the dog pack.";
// **************************************************************************
// END OF JBOY DOG INIT.SQF CODE
// **************************************************************************