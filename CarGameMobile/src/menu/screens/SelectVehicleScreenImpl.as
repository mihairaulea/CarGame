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
	 
	public class SelectVehicleScreenImpl extends ContentRequester
	{
		
		private var selectVehicleScreen:SelectVehicleScreen = new SelectVehicleScreen();
		private var levelsModel:LevelsModel = LevelsModel.getInstance();
		
		public function SelectVehicleScreenImpl() 
		{
			draw();
			
			
			selectVehicleScreen.vehicle1.addEventListener(MouseEvent.CLICK, vehicleSelectedHandler);
			selectVehicleScreen.vehicle1.value = 0;
			
			selectVehicleScreen.vehicle2.addEventListener(MouseEvent.CLICK, vehicleSelectedHandler);
			selectVehicleScreen.vehicle2.value = 1;
		
			
			selectVehicleScreen.vehicle3.addEventListener(MouseEvent.CLICK, vehicleSelectedHandler);
			selectVehicleScreen.vehicle3.value = 2;
		
			
			selectVehicleScreen.vehicle4.addEventListener(MouseEvent.CLICK, vehicleSelectedHandler);
			selectVehicleScreen.vehicle4.value = 3;
		
			
			selectVehicleScreen.vehicle5.addEventListener(MouseEvent.CLICK, vehicleSelectedHandler);
			selectVehicleScreen.vehicle5.value = 4;
		}
		
		protected function draw():void
		{
			if (selectVehicleScreen.height > ScreenConstants.ActualScreenHeight)
			{
				selectVehicleScreen.scaleY = selectVehicleScreen.scaleX = ScreenConstants.ContentScaleFactor;
			}
			
			selectVehicleScreen.x = (ScreenConstants.ActualScreenWidth - selectVehicleScreen.width) * .5;
			selectVehicleScreen.y = (ScreenConstants.ActualScreenHeight - selectVehicleScreen.height) * .5;
			
			addChild(selectVehicleScreen);
		}
		
		private function vehicleSelectedHandler(e:MouseEvent)
		{
			levelsModel.currentVehicleId = (e.target.parent.value);
			requestContent(2);
		}
		
	}

}