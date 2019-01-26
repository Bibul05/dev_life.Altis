/*
*    class:
*        variable = Variable Name
*        displayName = License Name
*        price = License Price
*        illegal = Illegal License
*        side = side indicator
*/
class Licenses {
    //Civilian Licenses
	class convoyeur {
        variable = "convoyeur";
        displayName = "STR_License_convoyeur";
        price = 1500;
        illegal = false;
        side = "civ";
    };
	class dog {
        variable = "dog";
        displayName = "STR_License_dog";
        price = 1500;
        illegal = false;
        side = "civ";
    };
	
	class dog1 {
        variable = "dog1";
        displayName = "STR_License_dog1";
        price = 1500;
        illegal = false;
        side = "civ";
    };
	
    class driver {
        variable = "driver";
        displayName = "STR_License_Driver";
        price = 500;
        illegal = false;
        side = "civ";
    };

    class boat {
        variable = "boat";
        displayName = "STR_License_Boat";
        price = 1000;
        illegal = false;
        side = "civ";
    };

    class pilot {
        variable = "pilot";
        displayName = "STR_License_Pilot";
        price = 25000;
        illegal = false;
        side = "civ";
    };

    class trucking {
        variable = "trucking";
        displayName = "STR_License_Truck";
        price = 20000;
        illegal = false;
        side = "civ";
    };

    class gun {
        variable = "gun";
        displayName = "STR_License_Firearm";
        price = 10000;
        illegal = false;
        side = "civ";
    };

    class dive {
        variable = "dive";
        displayName = "STR_License_Diving";
        price = 2000;
        illegal = false;
        side = "civ";
    };

    class home {
        variable = "home";
        displayName = "STR_License_Home";
        price = 75000;
        illegal = false;
        side = "civ";
    };

    //Processing Licenses
	class Agriculteur {
        variable = "Agriculteur";
        displayName = "STR_License_Agriculteur";
        price = 10000;
        illegal = false;
        side = "civ";
    };
	
	class Artisan {
        variable = "Artisan";
        displayName = "STR_License_Artisan";
        price = 10000;
        illegal = false;
        side = "civ";
    };
	
	class Routier {
        variable = "Routier";
        displayName = "STR_License_Routier";
        price = 10000;
        illegal = false;
        side = "civ";
    };
	
	class Traficant {
        variable = "Traficant";
        displayName = "STR_License_Traficant";
        price = 10000;
        illegal = true;
        side = "civ";
    };

    class rebel {
        variable = "rebel";
        displayName = "STR_License_Rebel";
        price = 75000;
        illegal = true;
        side = "civ";
    };
	
	class gangster {
        variable = "gangster";
        displayName = "STR_License_gangster";
        price = 75000;
        illegal = true;
        side = "civ";
    };

    //Cop Licenses
    class cAir {
        variable = "cAir";
        displayName = "STR_License_Pilot";
        price = 15000;
        illegal = false;
        side = "cop";
    };

    class cg {
        variable = "cg";
        displayName = "STR_License_CG";
        price = 8000;
        illegal = false;
        side = "cop";
    };

    //Medic Licenses
    class mAir {
        variable = "mAir";
        displayName = "STR_License_Pilot";
        price = 15000;
        illegal = false;
        side = "med";
    };
};