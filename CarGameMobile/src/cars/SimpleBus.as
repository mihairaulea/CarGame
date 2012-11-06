package cars 
{
	
	import As3Math.consts.*;
	import As3Math.general.*;
	import As3Math.geo2d.*;
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
	
	public class SimpleBus extends tdCarBody
	{
		
		
		private var busSkin:BusSkin = new BusSkin();
		private var busSkinEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
		
		private var tireSkinEngine1:qb2FlashSpriteActor = new qb2FlashSpriteActor();
		private var tireSkinEngine2:qb2FlashSpriteActor = new qb2FlashSpriteActor();
		private var tireSkinEngine3:qb2FlashSpriteActor = new qb2FlashSpriteActor();
		private var tireSkinEngine4:qb2FlashSpriteActor = new qb2FlashSpriteActor();
		private var tireSkinEngine5:qb2FlashSpriteActor = new qb2FlashSpriteActor();
		private var tireSkinEngine6:qb2FlashSpriteActor = new qb2FlashSpriteActor();
				
		private var stage:Stage;
		
		private var center:amPoint2d;
		
		public function SimpleBus() 
		{
			super();
			this.userData = new Object();
			this.userData.isVehicle = true;
		}
		
		public function init(stageParam:Stage)
		{
			
			this.stage = stageParam;
			this.actor = new qb2FlashSpriteActor();
						
			tireSkinEngine1.addChild(new BusTire());
			tireSkinEngine2.addChild(new BusTire());
			tireSkinEngine3.addChild(new BusTire());
			tireSkinEngine4.addChild(new BusTire());
			tireSkinEngine5.addChild(new BusTire());
			tireSkinEngine6.addChild(new BusTire());
			
			
						
			center = new amPoint2d(stage.stageWidth / 2, stage.stageHeight / 2);
			
			var circle:qb2Body = qb2Stock.newCircleBody(new amPoint2d(0, -70), 23, 67);
			this.addObject(circle);
			
			addTires();		
			
			
			//--- Give the car geometry and mass.  Provide junk in the trunk so that the car has oversteer and can do handbrake turns more easily.
			var carWidth:Number = busSkin.width;
			var carHeight:Number = busSkin.height;
						
			
			// main car body
			
			var rectangle:qb2Body = qb2Stock.newRectBody(new amPoint2d(0, 0), busSkin.width, busSkin.height,10);
			
			busSkinEngine.addChild(busSkin);
			rectangle.actor = busSkinEngine;
			
			this.addObject
			(
				rectangle
			);
			
			rectangle.mass = 1200;  
			
			// tires
			
			
			//--- Set up keyboard controls for the car.
			
			
			//--- Give the car an engine and transmission...both optional, but needed if you want the car to move under its own power.
			this.addObject(new tdEngine(), new tdTransmission());
			
			//--- Gear ratios for the transmission, starting with reverse, then first, second, etc.
			this.tranny.gearRatios = Vector.<Number>([3.5, 3.5, 3, 2.5, 2, 1.5, 1]);
			
			
			//--- A torque curve describes engine performance, in this case relating RPM to torque output in Nm.
			var curve:tdTorqueCurve = this.engine.torqueCurve;
			curve.addEntry(1000, 200); // (engine outputs a maximum torque of 300 Nm at 1000 RPM.
			curve.addEntry(2000, 210);
			curve.addEntry(3000, 120);
			curve.addEntry(4000, 225);
			curve.addEntry(5000, 230); // (this is the maximum torque the engine can produce).
			curve.addEntry(6000, 225);
			curve.addEntry(7000, 220);
			
			
		}
		
		private function addTires()
		{
			var tireFriction:Number = 2.0; // friction coefficient...this is a bit high for everyday life (like nascar or something).
			var tireRollingFriction:Number = 1;  // again a little high for real life, but good for games cause the car comes to a stop a lot faster.
			var tireWidth:Number = 11;
			var tireRadius:Number = 13;
		
			
			var leftSideX:Number = -40.45 ;
			var rightSideX:Number = 40.45 ;
			
			var firstY:Number = -82.9;
			var secondY:Number = 37;
			var thirdY:Number  = 74.05;
			
			var dummyValue:Number = 0;
			
			var tire1:tdTire = new tdTire(new amPoint2d( leftSideX, firstY), tireWidth, tireRadius, true /*driven*/,  true /*turns*/, false /*brakes*/, tireFriction, tireRollingFriction);
			tire1.actor = tireSkinEngine1;
			tire1.actor.setPosition(new amPoint2d( leftSideX, firstY));
			
			var tire2:tdTire = new tdTire(new amPoint2d( rightSideX, firstY), tireWidth, tireRadius, true /*driven*/,  true /*turns*/, false /*brakes*/, tireFriction, tireRollingFriction);
			tire2.actor = tireSkinEngine2;
			tire2.actor.setPosition(new amPoint2d( rightSideX, firstY));
			
			var tire3:tdTire = new tdTire(new amPoint2d( leftSideX,  secondY), tireWidth, tireRadius, false /*driven*/, false /*turns*/, true  /*brakes*/, tireFriction, tireRollingFriction);
			tire3.actor = tireSkinEngine3;
			tire3.actor.setPosition(new amPoint2d( leftSideX, secondY));
			
			var tire4:tdTire = new tdTire(new amPoint2d( rightSideX,  secondY), tireWidth, tireRadius, false /*driven*/, false /*turns*/, true  /*brakes*/, tireFriction, tireRollingFriction);
			tire4.actor = tireSkinEngine4;
			tire4.actor.setPosition(new amPoint2d( rightSideX, secondY));
			
			var tire5:tdTire = new tdTire(new amPoint2d( leftSideX,  thirdY), tireWidth, tireRadius, false /*driven*/, false /*turns*/, true  /*brakes*/, tireFriction, tireRollingFriction);
			tire5.actor = tireSkinEngine5;
			tire5.actor.setPosition(new amPoint2d( leftSideX, thirdY));
			
			var tire6:tdTire = new tdTire(new amPoint2d( rightSideX,  thirdY), tireWidth, tireRadius, false /*driven*/, false /*turns*/, true  /*brakes*/, tireFriction, tireRollingFriction);
			tire6.actor = tireSkinEngine6;
			tire6.actor.setPosition(new amPoint2d( rightSideX, thirdY));
			
			this.addObject
			(
				tire1,
				tire2,
				tire3,
				tire4,
				tire5,
				tire6
			);
		
			this.tractionControl = true; // let the tire's driven wheels spin freely
			this.position.copy(center);
			
			
			var playerBrain:tdControllerBrain = new tdControllerBrain();
			playerBrain.addController(new tdKeyboardCarController(stage));
			this.addObject(playerBrain);
			
		}
		
	}

}