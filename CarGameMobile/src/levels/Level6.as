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
	
	public class Level6 extends Level
	{
		
		private var simpleCar:SimpleBusWithTrolley = new SimpleBusWithTrolley();
		
		public function Level6(stage:Stage, bustCallback:Function, greatCallback:Function,showFeedbackScreen:Function)
		{
			super(stage, bustCallback,greatCallback,showFeedbackScreen);
		}
		
		override public function startLevel():void
		{	
			super.levelParkingTolerance = 30;
			resetLevelGeneral();			
			//environment
			placeGreenArrowDown(168.85,-604.75);
			
			
			placeParkingSpotBus( -23.8, 1168.5);
			
			placeTrafficCone( 67.05, -464.7);
			placeTrafficCone(  261.25, -464.7); 
			//placeGreenArrowDown(-17, 310.70);
			
			placeTrafficCone( -130.15, 912.25);
			placeTrafficCone(  74.85, 912.25);
			placeTrafficCone( -130.15, 1145.25);
			placeTrafficCone( 74.85, 1145.25);
			placeTrafficCone( -130.15, 1426.25);
			placeTrafficCone( 74.85, 1426.25);
			
			placeBarrel( -532.55, 0);
			placeBarrel( 606.65, 0);
			
			placeHorizontalBarrel(0, -724.85);
			placeHorizontalBarrel(0, 1835.95);
									
			//--- Add the car to the map.		
			simpleCar.init(this.stage);
			map.addObject(simpleCar);
			
			simpleCar.position = new amPoint2d( 165.3, -367.3);
			
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