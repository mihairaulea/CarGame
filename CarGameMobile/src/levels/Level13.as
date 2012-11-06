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
	
	public class Level13 extends Level
	{
				
		private var simpleCar:Truck1 = new Truck1();//SimpleCarWithTrolley = new SimpleCarWithTrolley();
		
		
		public function Level13(stage:Stage, bustCallback:Function, greatCallback:Function,showFeedbackScreen:Function)
		{
			super(stage, bustCallback,greatCallback,showFeedbackScreen);
		}
		
		override public function startLevel():void
		{
			this.levelParkingTolerance = 35;
			resetLevelGeneral();			
			placeDelimitators();
			
			placeParkingSpotBus(980.4, 330.75);
			placeTrafficCone( 513.8, 875.05);
			placeTrafficCone( 680.2, 881.45);
			
			placeTrafficCone( 888.2, -104.15);
			placeTrafficCone( 971.4, -97.75);
			placeTrafficCone( 1045, -107.35);
			placeTrafficCone( 1054.6, 46.25);
			placeTrafficCone( 1057.8, 193.45);
			placeTrafficCone( 1057.8, 337.45);
			placeTrafficCone( 1057.8, 462.25);
			placeTrafficCone( 1064.2, 654.25);
			placeTrafficCone( 1057.8, 843.05);
			placeTrafficCone( 968.2, 846.25);
			placeTrafficCone( 894.6, 836.65);
			placeTrafficCone( 891.4, 657.45);
			placeTrafficCone( 891.4, 468.65);
			placeTrafficCone( 888.2, 196.65);
			placeTrafficCone( 881.8, 46.25);
			
			placeBarrel( -334.55, 0);
			placeBarrel( 1166.25, 0);
			
			placeHorizontalBarrel(0, -1247.35);
			placeHorizontalBarrel(0, 1687.05);
			
			
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