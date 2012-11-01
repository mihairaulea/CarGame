package levels
{
	
	import As3Math.consts.*;
	import As3Math.general.*;
	import As3Math.geo2d.*;
	import cars.SimpleCar;
	import cars.SimpleCarWithTrolley;
	import cars.SimpleCarWrapper;
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
	
	public class Level1 extends Level
	{
				
		private var simpleCar:SimpleCarWrapper = new SimpleCarWrapper();
				
		public function Level1(stage:Stage, bustCallback:Function, greatCallback:Function,showFeedbackScreen:Function)
		{
			super(stage, bustCallback,greatCallback,showFeedbackScreen);
		}
		
		override public function startLevel():void
		{	
			resetLevelGeneral();
			super.levelParkingTolerance = 10;
			placeRoad(-288,-0.95);
			placeRoadTagged(-161.1,-2048.95); 
			
			placeParkingSpotSimpleCar(25.3,-859.25);
			
			placeBarrel(106.3, 0);
			placeBarrel( -437.5, 0);
						
			placeDummyRectangle(11.25, -982.55);
			placeDummyRectangle(54.9,  -982.55);
			placeDummyRectangle(8.05, -732.95);
			placeDummyRectangle(51.55, -732.95);
			
			for (var i:int = 0; i < 10; i++) 
			 placeDummyRectangle(27.55, -662.55 + 70.4 * i);
			
			//placeDelimitators();
			//--- Add the car to the map.		
			simpleCar.init(this.stageRef);
			map.addObject(simpleCar);
			simpleCar.position = new amPoint2d( -125.55, 1635.3);
			//trace(simpleCar
						
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