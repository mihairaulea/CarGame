package levels
{
	
	import As3Math.consts.*;
	import As3Math.general.*;
	import As3Math.geo2d.*;
	import cars.*;
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
	
	public class Level16 extends Level
	{
				
		private var simpleCar:Truck2 = new Truck2();//SimpleCarWithTrolley = new SimpleCarWithTrolley();
		
		public function Level16(stage:Stage, bustCallback:Function, greatCallback:Function,showFeedbackScreen:Function)
		{
			super(stage, bustCallback,greatCallback,showFeedbackScreen);
		}
		
		override public function startLevel():void
		{	
			this.levelParkingTolerance = 30;
			resetLevelGeneral();		
			placeDelimitators();
			
			placeParkingSpotBigTruck( -143.3, 1292.4, RAD_45);
			
			
			//environment
			placeTrafficCone( 137.05, -396.1);
			placeTrafficCone(  322.55, -409.9); 
			placeGreenArrowDownLeft(400.55, 772.65);
			placeGreenArrowDown(231.85,-534.45);
			
			placeTrafficCone( -27.35, 1016.05);
			placeTrafficCone(  137.05, 1143.85);
			placeTrafficCone( -221.75, 1218.85);
			placeTrafficCone( -70.55, 1358.45);
			placeTrafficCone( -403.35, 1412.45);
			placeTrafficCone( -276.95, 1543.85);
			
			placeBarrel( -532.95, 0);
			placeBarrel( 727.85, 0);
			
			//placeHorizontalBarrel(0, -724.95);
			//placeHorizontalBarrel(0, 1748.65);
						
			//--- Add the car to the map.		
			simpleCar.init(this.stage);
			map.addObject(simpleCar);
			
			simpleCar.position = new amPoint2d( 238.45, -277.65);
			
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