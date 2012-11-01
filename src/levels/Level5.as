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
	
	public class Level5 extends Level
	{
		
		private var simpleCar:SimpleBusWithTrolley = new SimpleBusWithTrolley();
		
		public function Level5(stage:Stage, bustCallback:Function, greatCallback:Function,showFeedbackScreen:Function)
		{
			super(stage, bustCallback,greatCallback,showFeedbackScreen);
		}
		
		override public function startLevel():void
		{	
			super.levelParkingTolerance = 30;
			resetLevelGeneral();		
			placeDelimitators();
			
			placeParkingSpotBus(-168.2, 902.4, RAD_45);
			
			placeGreenArrowDown(19.65,-578.65);
			
			//environment
			placeTrafficCone( -58.35, -443.25);
			placeTrafficCone(  91.05, -443.25); 
			placeGreenArrowDownLeft(259.55, 204.85);
			
			//left
			placeTrafficCone( -93.15, 711.95);
			placeTrafficCone( -257.95, 892.65);
			placeTrafficCone( -401.95, 1074.65);
			//right
			placeTrafficCone( 68.05, 841.25);
			placeTrafficCone( -111.55, 1047.65);
			placeTrafficCone( -275.55, 1196.45);
			
			placeBarrel( -560.35, 0);
			placeBarrel( 351.2, 0);
			
			placeHorizontalBarrel(0, -715.3);
			placeHorizontalBarrel(0, 1259);
						
			//--- Add the car to the map.		
			simpleCar.init(this.stage);// , contactBustHandler);
			map.addObject(simpleCar);
			
			simpleCar.position = new amPoint2d( 19.2, -367.3);
			
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