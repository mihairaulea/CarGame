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
	
	
	public class Truck2IntermediateWheels extends tdCarBody
	{				
		
		var carSkin:TrolleyTurningWheels = new TrolleyTurningWheels();
		var carSkinEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
		
		private var tireSkinEngine1:qb2FlashSpriteActor = new qb2FlashSpriteActor();
		private var tireSkinEngine2:qb2FlashSpriteActor = new qb2FlashSpriteActor();
				
		private var stage:Stage;
		
		var center:amPoint2d;
		
		public function Truck2IntermediateWheels() 
		{
			super();
		}
		
		public function init(stageParam:Stage)
		{
			
			this.stage = stageParam;
			this.actor = new qb2FlashSpriteActor();
						
			tireSkinEngine1.addChild(new TireSkin());
			tireSkinEngine2.addChild(new TireSkin());
			
			
						
			center = new amPoint2d(stage.stageWidth / 2, stage.stageHeight / 2);
			
			addTires();		
			
			
			//--- Give the car geometry and mass.  Provide junk in the trunk so that the car has oversteer and can do handbrake turns more easily.
			var carWidth:Number = carSkin.width;
			var carHeight:Number = carSkin.height;
			
			// main car body
			
			var rectangle:qb2Body = qb2Stock.newRectBody(new amPoint2d(0, 0), carSkin.width, carSkin.height,100);
			
			carSkinEngine.addChild(carSkin);
			rectangle.actor = carSkinEngine;
			
			this.addObject
			(
				rectangle
			);
			
			// tires
			
			
			//--- Set up keyboard controls for the car.
			
			
			//--- Give the car an engine and transmission...both optional, but needed if you want the car to move under its own power.
			
			
			
			this.isBullet = true;
		}
		
		private function addTires()
		{
			var tireFriction:Number = 2.0; // friction coefficient...this is a bit high for everyday life (like nascar or something).
			var tireRollingFriction:Number = 1;  // again a little high for real life, but good for games cause the car comes to a stop a lot faster.
			var tireWidth:Number = 11;
			var tireRadius:Number = 13;
		
			
			var leftSideX:Number = -32.15;
			var rightSideX:Number = 31.1;
			
			var frontY:Number = 10;//-20.75;
			var backY:Number =   33.5;
			
			var dummyValue:Number = 0;
			
			var tire1:tdTire = new tdTire(new amPoint2d( leftSideX, frontY), tireWidth, tireRadius, true /*driven*/,  false /*turns*/, true /*brakes*/, tireFriction, tireRollingFriction);
			tire1.actor = tireSkinEngine1;
			tire1.actor.setPosition(new amPoint2d( leftSideX, frontY));
			
			var tire2:tdTire = new tdTire(new amPoint2d( rightSideX, frontY), tireWidth, tireRadius, true/*driven*/,  false /*turns*/, true /*brakes*/, tireFriction, tireRollingFriction);
			tire2.actor = tireSkinEngine2;
			tire2.actor.setPosition(new amPoint2d( rightSideX, frontY));			
			
			this.addObject
			(
				tire1,
				tire2
			);
		
			var playerBrain:tdControllerBrain = new tdControllerBrain();
			playerBrain.addController(new CustomController(stage));
			
			this.addObject(new tdEngine(), new tdTransmission());
			
			//--- Gear ratios for the transmission, starting with reverse, then first, second, etc.
			this.tranny.gearRatios = Vector.<Number>([3.5, 3.5, 3, 2.5, 2, 1.5, 1]);
			
			var curve:tdTorqueCurve = this.engine.torqueCurve;
			curve.addEntry(1000, 300); // (engine outputs a maximum torque of 300 Nm at 1000 RPM.
			curve.addEntry(2000, 310);
			curve.addEntry(3000, 320);
			curve.addEntry(4000, 325);
			curve.addEntry(5000, 330); // (this is the maximum torque the engine can produce).
			curve.addEntry(6000, 325);
			curve.addEntry(7000, 320);			
		}
		
	}

}