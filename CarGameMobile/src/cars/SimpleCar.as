package cars 
{
	
	import As3Math.consts.*;
	import As3Math.general.*;
	import As3Math.geo2d.*;
	import Box2DAS.Common.V2;
	import flash.display.*;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import QuickB2.events.*;
	import QuickB2.misc.qb2Keyboard;
	import QuickB2.objects.qb2Object;
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
	
	
	public class SimpleCar extends tdCarBody
	{
		
		private var carSkin:CarSkin = new CarSkin();
		private var carSkinEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
		
		private var tireSkinEngine1:qb2FlashSpriteActor = new qb2FlashSpriteActor();
		private var tireSkinEngine2:qb2FlashSpriteActor = new qb2FlashSpriteActor();
		private var tireSkinEngine3:qb2FlashSpriteActor = new qb2FlashSpriteActor();
		private var tireSkinEngine4:qb2FlashSpriteActor = new qb2FlashSpriteActor();
				
		private var stage:Stage;
		
		private var center:amPoint2d;
		
		private var contactCallback:Function;
		
		public function SimpleCar() 
		{
			super();
		}
		
		public function init(stageParam:Stage):void
		{
			
			this.stage = stageParam;
			this.actor = new qb2FlashSpriteActor();
			
			tireSkinEngine1.addChild(new TireSkin());
			tireSkinEngine2.addChild(new TireSkin());
			tireSkinEngine3.addChild(new TireSkin());
			tireSkinEngine4.addChild(new TireSkin());
			
			
			this.restitution = 0;	
			this.linearDamping = 1;
			this.angularDamping = 1;
			center = new amPoint2d(0,0);
			
			addTires();		
			
			
			//--- Give the car geometry and mass.  Provide junk in the trunk so that the car has oversteer and can do handbrake turns more easily.
			var carWidth:Number = carSkin.width;
			var carHeight:Number = carSkin.height;
						
			
			// main car body
			
			var rectangle:qb2Body = qb2Stock.newRectBody(new amPoint2d(0, 0), carSkin.width, carSkin.height-20,10);
			
			carSkinEngine.addChild(carSkin);
			rectangle.actor = carSkinEngine;
			
			this.addObject
			(
				rectangle
			);
			
			var circle:qb2Body = qb2Stock.newCircleBody(new amPoint2d(0, -40), 23, 67);
			this.addObject(circle);
			
			trace(rectangle.ancestorBody + " ancestor body");
			// tires
			
			
			//--- Set up keyboard controls for the car.
			
			
			//--- Give the car an engine and transmission...both optional, but needed if you want the car to move under its own power.
						
			this.mass = 1200;  
			//this.isBullet = true;
		}
		
		private function contact(e:qb2ContactEvent):void
		{
			trace("simple car made contact");
			
			var otherObject:qb2Object = e.otherObject;
			//trace("contact!!!!!!!");
			//trace("otherObject " + otherObject.toString() );
			
			
			//contactCallback.call();
			/*
			if ( evt.type == qb2ContactEvent.CONTACT_STARTED )
			{
				if ( !shapeContactDict[otherShape] )
				{
					shapeContactDict[otherShape] = 0 as int;
					
					otherShape.registerContactTerrain(this);
				}
				
				shapeContactDict[otherShape]++;
			}
			else
			{
				shapeContactDict[otherShape]--;
				
				if ( shapeContactDict[otherShape] == 0 ) 
				{
					delete shapeContactDict[otherShape];
					otherShape.unregisterContactTerrain(this);
				}
			}
			*/
		}
		
		private function addTires():void
		{
			var tireFriction:Number = 2.0; // friction coefficient...this is a bit high for everyday life (like nascar or something).
			var tireRollingFriction:Number = 1;  // again a little high for real life, but good for games cause the car comes to a stop a lot faster.
			var tireWidth:Number = 11;
			var tireRadius:Number = 13;
		
			
			var leftSideX:Number = -32.15;
			var rightSideX:Number = 31.1;
			
			var frontY:Number = -22.75;
			var backY:Number =   33.5;
			
			var dummyValue:Number = 0;
			
			var tire1:tdTire = new tdTire(new amPoint2d( leftSideX, frontY), tireWidth, tireRadius, true /*driven*/,  true /*turns*/, false /*brakes*/, tireFriction, tireRollingFriction);
			tire1.actor = tireSkinEngine1;
			tire1.actor.setPosition(new amPoint2d( leftSideX, frontY));
			
			var tire2:tdTire = new tdTire(new amPoint2d( rightSideX, frontY), tireWidth, tireRadius, true /*driven*/,  true /*turns*/, false /*brakes*/, tireFriction, tireRollingFriction);
			tire2.actor = tireSkinEngine2;
			tire2.actor.setPosition(new amPoint2d( rightSideX, frontY));
			
			var tire3:tdTire = new tdTire(new amPoint2d( leftSideX,  backY), tireWidth, tireRadius, true /*driven*/, false /*turns*/, true  /*brakes*/, tireFriction, tireRollingFriction);
			tire3.actor = tireSkinEngine3;
			tire3.actor.setPosition(new amPoint2d( leftSideX, backY));
			
			var tire4:tdTire = new tdTire(new amPoint2d( rightSideX,  backY), tireWidth, tireRadius, true /*driven*/, false /*turns*/, true  /*brakes*/, tireFriction, tireRollingFriction);
			tire4.actor = tireSkinEngine4;
			tire4.actor.setPosition(new amPoint2d( rightSideX, backY));
			
			this.addObject
			(
				tire1,
				tire2,
				tire3,
				tire4				
			);
		
			this.tractionControl = true; // let the tire's driven wheels spin freely
			this.position.copy(center);
			
			
			var playerBrain:tdControllerBrain = new tdControllerBrain();
			playerBrain.addController(new tdKeyboardCarController(stage));
			this.addObject(playerBrain);
			
			this.addObject(new tdEngine(), new tdTransmission());
			
			//--- Gear ratios for the transmission, starting with reverse, then first, second, etc.
			this.tranny.gearRatios = Vector.<Number>([3.5, 3.5, 3, 2.5, 2, 1.5, 1]);
			
			
			//--- A torque curve describes engine performance, in this case relating RPM to torque output in Nm.
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