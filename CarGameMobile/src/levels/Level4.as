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
	
	public class Level4 extends Level
	{
		
		private var simpleCar:SimpleCarWithTrolley = new SimpleCarWithTrolley();
		
		public function Level4(stage:Stage, bustCallback:Function, greatCallback:Function, showFeedbackScreen:Function)
		{
			super(stage, bustCallback,greatCallback, showFeedbackScreen);
		}
		
		override public function startLevel():void
		{		
			super.levelParkingTolerance = 30;
			resetLevelGeneral();	
			placeDelimitators();
			
			//environment
			placeRoadTaggedLevel4( -35.2, 0.95);
			placeBarrel(115.35, -0.65);
			placeBarrel(-177.1, -0.65); 
			
			placeParkingSpotCarWithTrolley( -36.7, 1680.2);
			//--- Add the car to the map.		
			simpleCar.init(this.stage);
			map.addObject(simpleCar);
			
			simpleCar.position = new amPoint2d( 16.35, -1168.95);
			
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