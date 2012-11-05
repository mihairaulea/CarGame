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
	
	public class Level11 extends Level
	{
				
		private var simpleCar:Truck1 = new Truck1();
		
		public function Level11(stage:Stage, bustCallback:Function, greatCallback:Function,showFeedbackScreen:Function)
		{
			super(stage, bustCallback,greatCallback,showFeedbackScreen);
		}
		
		override public function startLevel():void
		{
			resetLevelGeneral();			
			placeDelimitators();
						
			placeGreenArrowUpLeftMild(595.85, 837.05);
			placeGreenArrowUp( -132.6, 514.5);
			placeGreenArrowUpRight(249.9, 118.7);
			placeGreenArrowUp(591.8, -189.05);
			placeGreenArrowDown(977.8, 387.95);
			
			placeTrafficCone( 513.8, 875.05);
			placeTrafficCone( 680.2, 881.45);
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
			
			placeBarrel( -333.85, 0);
			placeBarrel( 1166.25, 0);
			
			placeHorizontalBarrel(0, -747.35);
			placeHorizontalBarrel(0, 1387.05);
			
			placeParkingSpotBus(975.2, 659.15);
			
			//--- Add the car to the map.		
			simpleCar.init(this.stage);
			map.addObject(simpleCar);
			
			simpleCar.position = new amPoint2d( 597, 987.05);
			
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