package menu.screens 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	import flash.display.*;
	import flash.events.*;
	import menu.ContentRequester;
	import model.LevelsModel;
	 
	public class SelectLevelScreenImpl extends ContentRequester
	{
		
		private var selectLevelScreen:SelectLevelScreen = new SelectLevelScreen();
		private var levelsModel:LevelsModel = LevelsModel.getInstance();
		
		private var levelsBtnArray:Array = new Array();
		
		private var vehiclesArray:Array = new Array();
		
		public function SelectLevelScreenImpl() 
		{
			addChild(selectLevelScreen);
			
			levelsBtnArray[0] = selectLevelScreen.levelEnumeration.level1;
			levelsBtnArray[1] = selectLevelScreen.levelEnumeration.level2;
			levelsBtnArray[2] = selectLevelScreen.levelEnumeration.level3;
			levelsBtnArray[3] = selectLevelScreen.levelEnumeration.level4;
			levelsBtnArray[4] = selectLevelScreen.levelEnumeration.level5;
			levelsBtnArray[5] = selectLevelScreen.levelEnumeration.level6;
			levelsBtnArray[6] = selectLevelScreen.levelEnumeration.level7;
			levelsBtnArray[7] = selectLevelScreen.levelEnumeration.level8;
			
			vehiclesArray[0] = selectLevelScreen.vehicle1;
			vehiclesArray[1] = selectLevelScreen.vehicle2;
			vehiclesArray[2] = selectLevelScreen.vehicle3;
			vehiclesArray[3] = selectLevelScreen.vehicle4;
			vehiclesArray[4] = selectLevelScreen.vehicle5;
			
			//event listeners
			for (var i:int = 0; i < levelsBtnArray.length; i++)
			{
				levelsBtnArray[i].value = i;
				levelsBtnArray[i].addEventListener(MouseEvent.CLICK, levelSelectedHandler);
			}
		
			selectLevelScreen.changeVehicleBtn.addEventListener(MouseEvent.CLICK, changeVehicleClickHandler);
		}
		
		private function levelSelectedHandler(e:MouseEvent):void
		{
			trace(e.target.parent.value + " level selected");
			levelsModel.currentLevel = e.target.parent.value;
			
			trace(levelsModel.currentVehicleId);
			trace(levelsModel.currentLevel);
			
			requestContent(4);
		}
		
		private function changeVehicleClickHandler(e:MouseEvent)
		{
			super.requestContent(1);
		}
		
		override public function init()
		{
			showProperVehicle( levelsModel.currentVehicleId );
			invalidateInactiveBtns( levelsModel.getNumberOfLevelsForVehicle( levelsModel.currentVehicleId ) );
		}
		
		private function showProperVehicle(vehicleId:int)
		{
			trace(vehicleId + " vehicleId");
			for (var i:int = 0; i < vehiclesArray.length; i++)
			{
				if (i != vehicleId) vehiclesArray[i].visible = false;
				else vehiclesArray[i].visible = true;
			}
		}
		
		private function invalidateInactiveBtns(noOfLevels:int)
		{
			for (var i:int = 0; i < levelsBtnArray.length; i++)
			{
				if (i < noOfLevels) levelsBtnArray[i].visible = true;
				else
				levelsBtnArray[i].visible = false;
			}
		}
		
	}

}