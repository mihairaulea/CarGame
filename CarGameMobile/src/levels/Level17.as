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
	
	public class Level17 extends Level
	{
				
		private var simpleCar:Truck2 = new Truck2();//SimpleCarWithTrolley = new SimpleCarWithTrolley();
		
		public function Level17(stage:Stage, bustCallback:Function, greatCallback:Function,showFeedbackScreen:Function)
		{
			super(stage, bustCallback,greatCallback,showFeedbackScreen);
		}
		
		override public function startLevel():void
		{	
			resetLevelGeneral();		
			placeDelimitators();
			
			placeParkingSpotBigTruck( -28.8, 1627.2);
			//environment
			placeTrafficCone( 92.05, -607.5);
			placeTrafficCone(  315.05, -607.5); 
			
			placeGreenArrowDown( 190.65, -763.55);
			placeGreenArrowDown(-30.4,651.1);
			
			//left
			placeTrafficCone( -150, 1281.45);
			placeTrafficCone( -150, 1562.45);
			placeTrafficCone( -150, 1961.15);
			//right			
			placeTrafficCone( 92.05, 1281.45);
			placeTrafficCone( 92.05, 1562.45);
			placeTrafficCone( 92.05, 1961.15);
			
			placeBarrel( -587.55, 0);
			placeBarrel( 801.25, 0);
			
			placeHorizontalBarrel(0, -927.25);
			placeHorizontalBarrel(0, 2129.15);
						
			//--- Add the car to the map.		
			simpleCar.init(this.stage);
			map.addObject(simpleCar);
			
			simpleCar.position = new amPoint2d( 206.5, -429.05);
			
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