package model 
{
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class LevelsModel 
	{
		
		private static var instance:LevelsModel = null;
		
		private var vehiclesIdsArray:Array = new Array();
		private var noOfLevelsForVehicle:Array = new Array();
		private var intervalsVehicles:Array = new Array();
		
		public var numberOfVehicles:int = 5;
		public var currentVehicleId:int = 0;
		public var currentLevel:int = 0;
		public var noOfLevels:int;
		
		public var timeTookToSolveLevel:int;
		
		public function LevelsModel() 
		{ 
			populateArrays();
		} 
		
		private function populateArrays()
		{
			for (var i:int = 0; i < numberOfVehicles; i++)
			{
				vehiclesIdsArray[i] = i;
			}
			
			noOfLevelsForVehicle[0] = 1;
			noOfLevelsForVehicle[1] = 3;
			noOfLevelsForVehicle[2] = 4;
			noOfLevelsForVehicle[3] = 5;
			noOfLevelsForVehicle[4] = 4;
						
			intervalsVehicles[0] = "0-0";
			intervalsVehicles[1] = "1-3";
			intervalsVehicles[2] = "4-7";
			intervalsVehicles[3] = "8-12";
			intervalsVehicles[4] = "13-17";
		}
		
		public static function getInstance():LevelsModel
		{
			if (instance == null) instance = new LevelsModel();
			return instance;
		}
						
		public function getNumberOfLevelsForVehicle(vehicleId:int):int
		{
			return noOfLevelsForVehicle[vehicleId];
		}
		
		public function getCurrentLevel():int
		{
			var currentLevelId:int = 0;
			for (var i:int = 0; i < currentVehicleId; i++)
				currentLevelId += noOfLevelsForVehicle[i];
			
			currentLevelId += currentLevel;
			
			return currentLevelId;
		}
		
		
		
	}
	

}