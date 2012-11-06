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
	
	public class Level2 extends Level
	{
		
		private var simpleCar:SimpleCarWithTrolley = new SimpleCarWithTrolley();

		public function Level2(stage:Stage, bustCallback:Function, greatCallback:Function,showFeedbackScreen:Function)
		{
			super(stage, bustCallback,greatCallback,showFeedbackScreen);
		}
		
		override public function startLevel():void
		{
			resetLevelGeneral();
			super.levelParkingTolerance = 30;
			//environment
			placeBarrel( -560.35, 0);
			placeBarrel( 351.2, 0);
			
			placeHorizontalBarrel(0, -715.3);
			placeHorizontalBarrel(0, 859);
			
			
			placeGreenArrowDown(19.65,-578.65);
			placeGreenArrowDownLeft(8.05, 260.55);
			
			placeParkingSpotCarWithTrolley( -215, 531.25);//, RAD_45);
			
			
			placeTrafficCone( -58.35, -443.25);
			placeTrafficCone(  91.05, -443.25); 
			
			
			placeTrafficCone( -171.55, 364.75);
			placeTrafficCone(  -55.95, 446.05);
			placeTrafficCone( -273.95, 479.85);
			placeTrafficCone( -167.55, 567.65);
			placeTrafficCone( -380.35, 604.65);
			placeTrafficCone( -286.75, 692.45);
			
			
			
			
			//--- Add the car to the map.		
			simpleCar.init(this.stage);
			map.addObject(simpleCar);
			
			simpleCar.position = new amPoint2d( 19.2, -457.3);
			
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