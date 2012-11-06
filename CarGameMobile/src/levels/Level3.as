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
	
	public class Level3 extends Level
	{
		
		private var simpleCar:SimpleCarWithTrolley = new SimpleCarWithTrolley();
		
		public function Level3(stage:Stage, bustCallback:Function, greatCallback:Function,showFeedbackScreen:Function)
		{
			super(stage, bustCallback,greatCallback,showFeedbackScreen);
		}
		
		override public function startLevel():void
		{	
			resetLevelGeneral();	
			super.levelParkingTolerance = 30;	
			//environment
			placeGreenArrowDown(19.65,-578.65);
				
			
			placeTrafficCone( -58.35, -443.25);
			placeTrafficCone(  91.05, -443.25); 
		
			
			placeGreenArrowDown( -150.55, 112);
			
			
			//left
			placeTrafficCone( -237.55, 604.75);
			placeTrafficCone( -237.55, 769.75);
			placeTrafficCone( -237.55, 984.75);
			//right			
			placeTrafficCone( -72.55, 604.75);
			placeTrafficCone( -72.55, 769.75);
			placeTrafficCone( -72.55, 984.75);
			
			
			placeBarrel( -560.35, 0);
			placeBarrel( 351.2, 0);
			
			placeHorizontalBarrel(0, -715.3);
			placeHorizontalBarrel(0, 1059);
						
			placeParkingSpotCarWithTrolley( -144.25, 766.1);
			
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