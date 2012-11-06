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
	
	public class Level8 extends Level
	{
		
		private var simpleCar:SimpleBusWithTrolley = new SimpleBusWithTrolley();//SimpleCarWithTrolley = new SimpleCarWithTrolley();
		
		public function Level8(stage:Stage, bustCallback:Function, greatCallback:Function,showFeedbackScreen:Function)
		{
			super(stage, bustCallback,greatCallback,showFeedbackScreen);
		}
		
		override public function startLevel():void
		{
			this.levelParkingTolerance = 30;
			resetLevelGeneral();
			placeDelimitators();
			
			placeParkingSpotBus( -368, 3.2, RAD_90);
			
			placeGreenArrowDown( 751.7, 527.95);
			
			
			
			placeTrafficCone( 673.8, 1441.45);
			placeTrafficCone( 673.45, 1287.85);
			placeTrafficCone( 673.45, 1070.05);
			placeTrafficCone( 673.45, 915.05);
			
			placeTrafficCone( 859.4, 1447.85);
			placeTrafficCone( 863.45, 1287.85);
			placeTrafficCone( 863.45, 1070.05);
			placeTrafficCone( 863.45, 915.05);
			
			placeTrafficCone( 1224.2, 916.65);
			placeTrafficCone( 1025.8, 910.25);
			placeTrafficCone( 478.6, 935.85);
			placeTrafficCone( 309, 932.65);
			placeTrafficCone( 113.8, 932.65);
			placeTrafficCone( -65.4, 916.65);
			
			placeTrafficCone( -68.6, 807.85);
			placeTrafficCone( -68.6, 606.25);
			placeTrafficCone( -78.2, 427.05);
			placeTrafficCone( -78.2, 286.25);
			placeTrafficCone( -78.35, 143.2);
			placeTrafficCone( -81.55, -127.95);
			placeTrafficCone( -78.2, -315.35);
			placeTrafficCone( -84.6, -475.35);
			placeTrafficCone( -97.4, -632.15);
			placeTrafficCone( -84.6, -776.15);
			placeTrafficCone( -87.8, -904.15);
			
			placeTrafficCone( 117, -907.35);
			placeTrafficCone( 350.6, -916.95);
			placeTrafficCone( 600.2, -913.75);
			placeTrafficCone( 849.88, -920.15);
			placeTrafficCone( 1086.6, -913.75);
			
			placeTrafficCone( -308.6, 135.85);
			placeTrafficCone( -529.4, 139.05);
			placeTrafficCone( -734.2, 129.45);
			placeTrafficCone( -727.8, -120.15);
			placeTrafficCone( -529.4, -123.35);
			placeTrafficCone( -311.8, -123.35);
			
			placeBarrel( 1303.85, 0);
			placeBarrel( -814.55, 0);
			
			placeHorizontalBarrel(0, -1422.55);
			placeHorizontalBarrel(0, 1479.85);
						
			//--- Add the car to the map.		
			simpleCar.init(this.stage);
			map.addObject(simpleCar);
			
			simpleCar.position = new amPoint2d( 769.7, 1039.35);
			
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