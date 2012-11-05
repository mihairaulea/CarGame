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
	
	public class Level12 extends Level
	{
				
		private var simpleCar:Truck1 = new Truck1 ();//SimpleCarWithTrolley = new SimpleCarWithTrolley();
		
		
		public function Level12(stage:Stage, bustCallback:Function, greatCallback:Function,showFeedbackScreen:Function)
		{
			super(stage, bustCallback,greatCallback,showFeedbackScreen);
		}
		
		override public function startLevel():void
		{	
			resetLevelGeneral();
			
			placeDelimitators();
			
			placeGreenArrowUpLeft(961.8, 315.4);
			placeGreenArrowUp(972.6, 647.85);
			placeGreenArrowUp(590.6, -241.75);
			placeGreenArrowDownLeft(305.8, -62.2);
			placeGreenArrowDown( -123, 305.8);
			placeGreenArrowDown( 597, 789);
			placeGreenArrowDownRight(56.2, 600.2);
			
			
			placeTrafficCone( 513.8, 875.05);
			placeTrafficCone( 680.2, 881.45);
			placeTrafficCone( 513.8, 971.05);
			placeTrafficCone( 683.4, 961.45);
			placeTrafficCone( -231.8, 423.85);
			placeTrafficCone( -27, 420.65);
			placeTrafficCone( 501, -350.55);
			placeTrafficCone( 683.4, -353.75);
			placeTrafficCone( 507.4, -648.15);
			placeTrafficCone( 677, -648.15);
			placeTrafficCone( 891.4, 468.655);
			placeTrafficCone( 1057.8, 462.25);
			placeTrafficCone( 894.6, 836.65);
			placeTrafficCone( 1057.8, 843.05);
			
			placeBarrel( -334.55, 0);
			placeBarrel( 1166.25, 0);
			
			placeHorizontalBarrel(0, -747.35);
			placeHorizontalBarrel(0, 1387.05);
			
			placeParkingSpotBus(599.6, 1079.5);
			
			//--- Add the car to the map.		
			simpleCar.init(this.stage);
			map.addObject(simpleCar);
			
			//simpleCar.position = new amPoint2d( 961.65, 1188.7);
			simpleCar.putBackwardsAtPosition( new amPoint2d( 961.65, 1288.7) );
			
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