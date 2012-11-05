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
	import util.ScreenConstants;
	 
	public class SelectLevelScreenImpl extends ContentRequester
	{
		
		private var selectLevelScreen:SelectLevelScreen = new SelectLevelScreen();
		private var levelsModel:LevelsModel = LevelsModel.getInstance();
		
		private var levelsBtnArray:Array = new Array();
		
		private var vehiclesArray:Array = new Array();
		
		public function SelectLevelScreenImpl() 
		{
			draw();
			
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
		
		protected function draw():void
		{
			const gapY:Number = ScreenConstants.ActualScreenHeight * 0.05;
			const gapX:Number = ScreenConstants.ActualScreenWidth * 0.05;
			
			if (ScreenConstants.ContentScaleFactor < 1)
			{
				selectLevelScreen.selectLevelTextBox.x = selectLevelScreen.x + gapX;
				selectLevelScreen.selectLevelTextBox.y = gapY;
				
				selectLevelScreen.changeVehicleBtn.x = selectLevelScreen.x + gapX + selectLevelScreen.changeVehicleBtn.width * .5;
				selectLevelScreen.changeVehicleBtn.y = ScreenConstants.ActualScreenHeight - gapY ;
				
				selectLevelScreen.levelEnumeration.x = selectLevelScreen.x + gapX + selectLevelScreen.levelEnumeration.width * .5;
				selectLevelScreen.levelEnumeration.y = selectLevelScreen.selectLevelTextBox.y + selectLevelScreen.selectLevelTextBox.height + 
					selectLevelScreen.levelEnumeration.height * .5 + gapY;
					
				selectLevelScreen.vehicle1.y = selectLevelScreen.vehicle1.height * .5 + gapY;
				selectLevelScreen.vehicle1.x = ScreenConstants.ActualScreenWidth - selectLevelScreen.vehicle1.width * .5 - gapX;
				selectLevelScreen.vehicle2.y = selectLevelScreen.vehicle2.height * .5 + gapY;
				selectLevelScreen.vehicle2.x = ScreenConstants.ActualScreenWidth - selectLevelScreen.vehicle2.width * .5 - gapX;
				selectLevelScreen.vehicle3.y = selectLevelScreen.vehicle3.height * .5 + gapY;
				selectLevelScreen.vehicle3.x = ScreenConstants.ActualScreenWidth - selectLevelScreen.vehicle3.width * .5 - gapX;
				selectLevelScreen.vehicle4.y = selectLevelScreen.vehicle4.height * .5 + gapY;
				selectLevelScreen.vehicle4.x = ScreenConstants.ActualScreenWidth - selectLevelScreen.vehicle4.width * .5 - gapX;
				selectLevelScreen.vehicle5.y = selectLevelScreen.vehicle5.height * .5 + gapY;
				selectLevelScreen.vehicle5.x = ScreenConstants.ActualScreenWidth - selectLevelScreen.vehicle5.width * .5 - gapX;
				
			}
			else if (ScreenConstants.ContentScaleFactor > 1)
			{
				selectLevelScreen.selectLevelTextBox.x = selectLevelScreen.x + gapX;
				selectLevelScreen.selectLevelTextBox.y = gapY;
				
				selectLevelScreen.changeVehicleBtn.x = selectLevelScreen.x + gapX + selectLevelScreen.changeVehicleBtn.width * .5;
				selectLevelScreen.changeVehicleBtn.y = ScreenConstants.ActualScreenHeight - gapY ;
				
				selectLevelScreen.levelEnumeration.x = selectLevelScreen.x + gapX + selectLevelScreen.levelEnumeration.width * .5;
				selectLevelScreen.levelEnumeration.y = selectLevelScreen.selectLevelTextBox.y + selectLevelScreen.selectLevelTextBox.height + 
					selectLevelScreen.levelEnumeration.height * .5+ gapY;
			}
			
			selectLevelScreen.x =  0;
			selectLevelScreen.y =  0;
			
			addChild(selectLevelScreen);
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