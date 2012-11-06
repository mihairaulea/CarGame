package levels
{
	
	import As3Math.consts.*;
	import As3Math.general.*;
	import As3Math.geo2d.*;
	import cars.Truck2;
	import flash.display.*;
	import flash.display.DisplayObjectContainer;
	import QuickB2.events.*;
	import QuickB2.misc.qb2Keyboard;
	import QuickB2.objects.tangibles.*;
	import QuickB2.stock.*;
	import TopDown.ai.*;
	import TopDown.ai.brains.*;
	import TopDown.ai.controllers.*;
	import TopDown.carparts.*;
	import TopDown.debugging.*;
	import TopDown.objects.*;
	import TopDown.stock.*;
	import QuickB2.misc.acting.*;
	
	public class Level15 extends Level
	{
				
		private var simpleCar:Truck2 = new Truck2();
		
		
		public function Level15(stage:Stage, bustCallback:Function, greatCallback:Function,showFeedbackScreen:Function)
		{
			super(stage, bustCallback,greatCallback,showFeedbackScreen);
		}
		
		override public function startLevel():void
		{	
			this.levelParkingTolerance = 30;
			resetLevelGeneral();		
			placeRoad(-36.8,0.65);
			
			placeBarrel(-180.8, 0);
			placeBarrel( 105.6, 0);
			
			
			placeDelimitators();
			
			placeGreenArrowDown(9.95, -1963.8);
			placeGreenArrowDown(9.95, -792.6);
			placeGreenArrowDown(9.95, 1455.4);
			
			placeParkingSpotBigTruck( -36.7, 1681);
			
			
						
			//--- Add the car to the map.		
			simpleCar.init(this.stage);
			map.addObject(simpleCar);
			simpleCar.position = new amPoint2d( -47.55, -1715.95);
			//trace(simpleCar
			
			//finishDoNotTouchGroupSetUp();
			
			this.addEventListener(qb2UpdateEvent.PRE_UPDATE,  updateManager);
		}
				
		private function updateManager(evt:qb2UpdateEvent):void
		{
			var cameraPos:amPoint2d = cameraPoint;
		}
		
		protected override function update():void
		{
			super.update();
			
			cameraPoint.copy(simpleCar.position);
			cameraTargetPoint.copy(simpleCar.position);
		}
		
	}
}