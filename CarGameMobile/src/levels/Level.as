package levels
{
	import As3Math.consts.*;
	import As3Math.general.*;
	import As3Math.geo2d.*;
	import cars.SimpleCar;
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
	import QuickB2.objects.qb2Object;
	
	import flash.utils.setTimeout;

	public class Level extends qb2Group
	{
		
		public var map:tdMap = new tdMap(); // special subclass of qb2Group that you can add tracks and other car-related goodies to.	
		
		private var postMass:Number = 200;	
		
		// lose block
		private var bustCallback:Function;
		private var levelBusted:Boolean = false;
		
		
		
		public var levelParkingTolerance:int = 10;
		public var noOfFramesToKeepInSpace:int = 120;
						
		public var stageRef:Stage;
		
		// win block
		public var greatCallback:Function;
		private var levelIsCompleted:Boolean = false;
		private var parkingSpaceTouched:Boolean = false;
		private var showFeedbackCallback:Function;
		
		var boundingBoxVehicle:amBoundBox2d 
		private var vehcilePointer:qb2Group;
		var boundingBoxParkingSpace:amBoundBox2d;
		private var parkingSpacePointer:tdTerrain;
		private var interactionHistoryArray:Array = new Array();
		
		public function Level(stageParam:Stage,bustContactCallback:Function,greatCallback:Function,showFeedbackCallback:Function) 
		{
			this.stageRef = stageParam;
			this.bustCallback = bustContactCallback;
			this.greatCallback = greatCallback;
			this.showFeedbackCallback = showFeedbackCallback;
			
			this.actor = new qb2FlashSpriteActor();
			map.actor = new qb2FlashSpriteActor();
			
			//doNotTouchGroup.actor = new qb2FlashSpriteActor();
			
			var center:amPoint2d = new amPoint2d(0, 0);//stage.stageWidth / 2, stage.stageHeight / 2);		
			
			//--- Make a terrain that encompasses the whole map, basically so skids are drawn everywhere.
			var defaultTerrain:tdTerrain = new tdTerrain(true /*ubiquitous*/ );
			defaultTerrain.frictionZMultiplier = 4.5;
			map.addObject(defaultTerrain);
						
			//--- Set up some properties for the tracks, the "roads" that traffic will drive on.
			var roadWid:Number = 100;
			var rectWidth:Number = 4096;
			var rectHeight:Number = 4096;
			var speedLimit:Number = 10;
			
			//--- Tracks can only be meaningfully added to a special subclass of qb2Group, called tdMap.
			map.addObjects(tdTrackStock.newTrackRect(center, roadWid, roadWid, rectWidth / 2+roadWid, rectHeight / 2+roadWid, false, speedLimit));
			map.addObjects(tdTrackStock.newTrackRect(center, rectWidth - roadWid, rectHeight-roadWid, roadWid*2, roadWid*2, true, speedLimit));
			map.addObjects(tdTrackStock.newTrackRect(center, rectWidth + roadWid, rectHeight+roadWid, roadWid, roadWid, false, speedLimit));
			addObject(map); 
			
			
			this.addEventListener(qb2ContainerEvent.ADDED_TO_WORLD, afterAdd);
		}
		
		public function afterAdd(evt:qb2ContainerEvent)
		{			
			this.world.gravity.set(0, 0);
			this.world.gravityZ = 9.8;
		
			world.addEventListener(qb2UpdateEvent.POST_UPDATE, updateFromLevel);
			stageWalls.contactMaskFlags = 0;
		}
		
		private function updateFromLevel(e:qb2UpdateEvent)
		{
			
			if (parkingSpaceTouched && !levelBusted)
			{
								
				//trace("level not busted, parking space touched");
				
				//trace(boundingBoxVehicle);
				//trace(boundingBoxParkingSpace);
				trace("parking space touched");
				
				boundingBoxParkingSpace = parkingSpacePointer.getBoundBox();
				boundingBoxVehicle = qb2Group( vehcilePointer ).getBoundBox();
				
				if ( boundingBoxParkingSpace.containsArea(boundingBoxVehicle, levelParkingTolerance,false)) //boundingBoxParkingSpace.containsAllPoints(boundingBoxVehicle.getAllPoints()) ) 
				{
				//	trace("contains area!! ===================");
					interactionHistoryArray.push("GOOD");
					if (isParkingHistoryAllGood()) 
					{
						//trace("all is good");
						if (greatCallback != null) 
						{
							greatCallback.call();
							showFeedbackScreen();
						}
						levelIsCompleted = true;
					}
				}
			}
		}
		
		private function showFeedbackScreen()
		{
			trace("show feedbackscreen");
			showFeedbackCallback.call();
		}
		
		private function isParkingHistoryAllGood():Boolean
		{
			if (interactionHistoryArray.length < 100) return false;
			for (var i:int = 0; i < interactionHistoryArray.length; i++)
				if (interactionHistoryArray[i] != "GOOD")
				{
					interactionHistoryArray.splice(0, interactionHistoryArray.length);
					return false;
				}
			return true;
		}
		
		public function startLevel():void
		{			 
			
		}
		
		public function restartLevel()
		{
			levelBusted = false;
			levelIsCompleted = false;
			parkingSpaceTouched = false; 
			interactionHistoryArray.splice(0, interactionHistoryArray.length);
			
			map.removeAllObjects();
			map.removeAllEventListeners();
			
			if(parkingSpacePointer) if(parkingSpacePointer.hasEventListener(qb2ContactEvent.CONTACT_STARTED)) parkingSpacePointer.removeEventListener(qb2ContactEvent.CONTACT_STARTED, parkingSpaceContactHandler);
			if(world) if( world.hasEventListener(qb2UpdateEvent.POST_UPDATE) )   world.removeEventListener(qb2UpdateEvent.POST_UPDATE, updateFromLevel);
		}
		
		public function resetLevelGeneral():void
		{
			levelBusted = false;
			levelIsCompleted = false;
			parkingSpaceTouched = false;
			if(parkingSpacePointer) if(parkingSpacePointer.hasEventListener(qb2ContactEvent.CONTACT_STARTED)) parkingSpacePointer.removeEventListener(qb2ContactEvent.CONTACT_STARTED, parkingSpaceContactHandler);
			// reset ui
		}
		
		public function resetLevelOverride():void
		{
			
		}
		
		public function placeParkingSpotSimpleCar(posX:Number, posY:Number):void
		{
			var roadSkin:ParkingSpaceSimpleCar = new ParkingSpaceSimpleCar();
			var roadEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			roadEngine.addChild(roadSkin);
			
			var roadShape:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0, 0), roadSkin.width, roadSkin.height, 0, 0);
			roadShape.actor = roadEngine;
			
			parkingSpacePointer = new tdTerrain();
			parkingSpacePointer.actor = new qb2FlashSpriteActor();
			parkingSpacePointer.addObject(roadShape);
			parkingSpacePointer.position = new amPoint2d(posX, posY);
			map.addObject(parkingSpacePointer);
			
			parkingSpacePointer.addEventListener(qb2ContactEvent.CONTACT_STARTED, parkingSpaceContactHandler);
		}
		
		public function placeParkingSpotCarWithTrolley(posX:Number, posY:Number, radiansRotateBy:Number = 0):void
		{		
			var roadSkin:ParkingSpaceIndicator = new ParkingSpaceIndicator();
			var roadEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			roadEngine.addChild(roadSkin);
			
			var roadShape:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0, 0), roadSkin.width, roadSkin.height, 0, 0);
			roadShape.actor = roadEngine;
			
			parkingSpacePointer = new tdTerrain();
			parkingSpacePointer.actor = new qb2FlashSpriteActor();
			parkingSpacePointer.addObject(roadShape);
			parkingSpacePointer.rotateBy(radiansRotateBy);
			parkingSpacePointer.position = new amPoint2d(posX, posY);
			
			map.addObject(parkingSpacePointer);
			
			parkingSpacePointer.addEventListener(qb2ContactEvent.CONTACT_STARTED, parkingSpaceContactHandler);
		}
		
		public function placeParkingSpotBus(posX:Number, posY:Number, radiansRotateBy:Number = 0):void
		{		
			var roadSkin:ParkingSpaceBus = new ParkingSpaceBus();
			var roadEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			roadEngine.addChild(roadSkin);
			
			var roadShape:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0, 0), roadSkin.width, roadSkin.height, 0, 0);
			roadShape.actor = roadEngine;
			
			parkingSpacePointer = new tdTerrain();
			parkingSpacePointer.actor = new qb2FlashSpriteActor();
			parkingSpacePointer.addObject(roadShape);
			parkingSpacePointer.rotateBy(radiansRotateBy);
			parkingSpacePointer.position = new amPoint2d(posX, posY);
			
			map.addObject(parkingSpacePointer);
			
			parkingSpacePointer.addEventListener(qb2ContactEvent.CONTACT_STARTED, parkingSpaceContactHandler);
		}
		
		public function placeParkingSpotBigTruck(posX:Number, posY:Number, radiansRotateBy:Number = 0):void
		{		
			var roadSkin:ParkingSpaceBigTruck = new ParkingSpaceBigTruck();
			var roadEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			roadEngine.addChild(roadSkin);
			
			var roadShape:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0, 0), roadSkin.width, roadSkin.height, 0, 0);
			roadShape.actor = roadEngine;
			
			parkingSpacePointer = new tdTerrain();
			parkingSpacePointer.actor = new qb2FlashSpriteActor();
			parkingSpacePointer.addObject(roadShape);
			parkingSpacePointer.rotateBy(radiansRotateBy);
			parkingSpacePointer.position = new amPoint2d(posX, posY);
			
			map.addObject(parkingSpacePointer);
			
			parkingSpacePointer.addEventListener(qb2ContactEvent.CONTACT_STARTED, parkingSpaceContactHandler);
		}
		
		private function parkingSpaceContactHandler(e:qb2ContactEvent)
		{
			//trace("parking space contact!!!");
			var contactObject:tdTerrain = e.localObject as tdTerrain;
			var otherObject:qb2Object = e.otherObject;
					
			//trace("parking space contact");
			
			//trace(otherObject.userData);
			//trace(contactObject);
			
			if(otherObject.userData)
			if (otherObject.userData.isVehicle == true && otherObject is qb2Group)
			{
				trace("acquired vehicle pointer, parking space pointer");
				this.vehcilePointer = otherObject as qb2Group;
				this.parkingSpacePointer = contactObject;
				boundingBoxParkingSpace = parkingSpacePointer.getBoundBox();
				boundingBoxVehicle = qb2Group( vehcilePointer ).getBoundBox();
				parkingSpaceTouched = true;
			}
		}
				
		public  function placeBarrel(posX:Number, posY:Number):void
		{
			var roadSkin:Barrels = new Barrels();
			var roadEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			roadEngine.addChild(roadSkin);
			
			var roadShape:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0, 0), roadSkin.width, roadSkin.height, 0, 0);
			roadShape.actor = roadEngine;
			
			var roadTerrain:tdTerrain = new tdTerrain();
			roadTerrain.actor = new qb2FlashSpriteActor();
			roadTerrain.addObject(roadShape);
			roadTerrain.position = new amPoint2d(posX, posY);
			map.addObject(roadTerrain);
			
			roadTerrain.addEventListener(qb2ContactEvent.CONTACT_STARTED, contactFunct, null, true);
		}
		
		public  function placeHorizontalBarrel(posX:Number, posY:Number):void
		{
			var roadSkin:BarrelsHorizontal = new BarrelsHorizontal();
			var roadEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			roadEngine.addChild(roadSkin);
			
			var roadShape:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0, 0), roadSkin.width, roadSkin.height, 0, 0);
			roadShape.actor = roadEngine;
			
			var roadTerrain:tdTerrain = new tdTerrain();
			roadTerrain.actor = new qb2FlashSpriteActor();
			roadTerrain.addObject(roadShape);
			roadTerrain.position = new amPoint2d(posX, posY);
			map.addObject(roadTerrain);
			
			roadTerrain.addEventListener(qb2ContactEvent.CONTACT_STARTED, contactFunct, null, true);
		}
		
		public function placeGreenArrowDown(posX:Number, posY:Number):void
		{
			var roadSkin:GreenArrowDown = new GreenArrowDown();
			var roadEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			roadEngine.addChild(roadSkin);
			
			var roadShape:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0, 0), roadSkin.width, roadSkin.height, 0, 0);
			roadShape.actor = roadEngine;
			
			var roadTerrain:tdTerrain = new tdTerrain();
			roadTerrain.actor = new qb2FlashSpriteActor();
			roadTerrain.addObject(roadShape);
			roadTerrain.position = new amPoint2d(posX, posY);
			map.addObject(roadTerrain);
		}
		
		public function placeGreenArrowDownLeft(posX:Number, posY:Number):void
		{
			var roadSkin:GreenArrowDownLeft = new GreenArrowDownLeft();
			var roadEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			roadEngine.addChild(roadSkin);
			
			var roadShape:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0, 0), roadSkin.width, roadSkin.height, 0, 0);
			roadShape.actor = roadEngine;
			
			var roadTerrain:tdTerrain = new tdTerrain();
			roadTerrain.actor = new qb2FlashSpriteActor();
			roadTerrain.addObject(roadShape);
			roadTerrain.position = new amPoint2d(posX, posY);
			map.addObject(roadTerrain);
		}
		
		public function placeGreenArrowDownRight(posX:Number, posY:Number):void
		{
			var roadSkin:GreenArrowDownRight = new GreenArrowDownRight();
			var roadEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			roadEngine.addChild(roadSkin);
			
			var roadShape:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0, 0), roadSkin.width, roadSkin.height, 0, 0);
			roadShape.actor = roadEngine;
			
			var roadTerrain:tdTerrain = new tdTerrain();
			roadTerrain.actor = new qb2FlashSpriteActor();
			roadTerrain.addObject(roadShape);
			roadTerrain.position = new amPoint2d(posX, posY);
			map.addObject(roadTerrain);
		}
		
		public function placeGreenArrowUp(posX:Number, posY:Number):void
		{	
			var roadSkin:GreenArrowUp = new GreenArrowUp();
			var roadEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			roadEngine.addChild(roadSkin);
			
			var roadShape:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0, 0), roadSkin.width, roadSkin.height, 0, 0);
			roadShape.actor = roadEngine;
			
			var roadTerrain:tdTerrain = new tdTerrain();
			roadTerrain.actor = new qb2FlashSpriteActor();
			roadTerrain.addObject(roadShape);
			roadTerrain.position = new amPoint2d(posX, posY);
			map.addObject(roadTerrain);			
		}
		
		public function placeGreenArrowUpLeft(posX:Number, posY:Number):void
		{	
			var roadSkin:GreenArrowUpLeft = new GreenArrowUpLeft();
			var roadEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			roadEngine.addChild(roadSkin);
			
			var roadShape:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0, 0), roadSkin.width, roadSkin.height, 0, 0);
			roadShape.actor = roadEngine;
			
			var roadTerrain:tdTerrain = new tdTerrain();
			roadTerrain.actor = new qb2FlashSpriteActor();
			roadTerrain.addObject(roadShape);
			roadTerrain.position = new amPoint2d(posX, posY);
			map.addObject(roadTerrain);						
		}
		
		public function placeGreenArrowUpLeftMild(posX:Number, posY:Number):void
		{	
			var roadSkin:GreenArrowUpLeftMild = new GreenArrowUpLeftMild();
			var roadEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			roadEngine.addChild(roadSkin);
			
			var roadShape:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0, 0), roadSkin.width, roadSkin.height, 0, 0);
			roadShape.actor = roadEngine;
			
			var roadTerrain:tdTerrain = new tdTerrain();
			roadTerrain.actor = new qb2FlashSpriteActor();
			roadTerrain.addObject(roadShape);
			roadTerrain.position = new amPoint2d(posX, posY);
			map.addObject(roadTerrain);						
		}
		
		public function placeGreenArrowUpRight(posX:Number, posY:Number):void
		{	
			var roadSkin:GreenArrowUpRight = new GreenArrowUpRight();
			var roadEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			roadEngine.addChild(roadSkin);
			
			var roadShape:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0, 0), roadSkin.width, roadSkin.height, 0, 0);
			roadShape.actor = roadEngine;
			
			var roadTerrain:tdTerrain = new tdTerrain();
			roadTerrain.actor = new qb2FlashSpriteActor();
			roadTerrain.addObject(roadShape);
			roadTerrain.position = new amPoint2d(posX, posY);
			map.addObject(roadTerrain);						
		}
		
		public function placeRoadTagged(posX:Number, posY:Number):void
		{
			var roadSkin:RoadTagged = new RoadTagged();
			var roadEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			roadEngine.addChild(roadSkin);
			
			var roadShape:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0, 0), roadSkin.width, roadSkin.height, 0, 0);
			roadShape.actor = roadEngine;
			
			var roadTerrain:tdTerrain = new tdTerrain();
			roadTerrain.actor = new qb2FlashSpriteActor();
			roadTerrain.addObject(roadShape);
			roadTerrain.position = new amPoint2d(posX, posY);
			map.addObject(roadTerrain);
		}
		
		public  function placeRoad(posX:Number, posY:Number):void
		{
			var roadSkin:Road = new Road();
			var roadEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			roadEngine.addChild(roadSkin);
			
			var roadShape:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0, 0), roadSkin.width, roadSkin.height, 0, 0);
			roadShape.actor = roadEngine;
			
			var roadTerrain:tdTerrain = new tdTerrain();
			roadTerrain.actor = new qb2FlashSpriteActor();
			roadTerrain.addObject(roadShape);
			roadTerrain.position = new amPoint2d(posX, posY);
			map.addObject(roadTerrain);
		}
		
		public function placeRoadTaggedLevel4(posX:Number, posY:Number):void
		{
			var roadSkin:RoadTaggedLevel4 = new RoadTaggedLevel4();
			var roadEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			roadEngine.addChild(roadSkin);
			
			var roadShape:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0, 0), roadSkin.width, roadSkin.height, 0, 0);
			roadShape.actor = roadEngine;
			
			var roadTerrain:tdTerrain = new tdTerrain();
			roadTerrain.actor = new qb2FlashSpriteActor();
			roadTerrain.addObject(roadShape);
			roadTerrain.position = new amPoint2d(posX, posY);
			map.addObject(roadTerrain);
		}
		
		public function placeDelimitators():void
		{
			/*
			placeTopDelimitator();
			placeLeftDelimitator();
			placeRightDelimitator();
			placeBottomDelimitator();
			*/
		}
		
		public  function placeTopDelimitator():void
		{
			var boxY:Number = -1998;
			var boxX:Number = -1968;
			
			var boxesPut:int = 82;
			
			while(boxesPut > 0)			
			{
				placeDummyRectangle(boxX, boxY);						
				boxX += 50; 
				boxesPut--;
			}
			
		}
		
		public  function placeLeftDelimitator():void
		{
			var boxY:Number = -1998;
			var boxX:Number = -1968;
			
			var boxesPut:int = 82;
			
			while (boxesPut > 0)	
			{
				placeDummyRectangle(boxX, boxY);						
				boxY += 50; 
				boxesPut--;
			}
		}
		
		public  function placeRightDelimitator():void
		{
			var boxY:Number = 1968;
			var boxX:Number = 1998;
			
			var boxesPut:int = 82;
			
			while (boxesPut > 0)	
			{
				placeDummyRectangle(boxX, boxY);							
				boxY -= 50; 
				boxesPut--;
			}
		}
		
		public function placeBottomDelimitator():void
		{
			var boxY:Number = 1968;
			var boxX:Number = 1998;
			
			var boxesPut:int = 82;
			
			while (boxesPut > 0)	
			{
				placeDummyRectangle(boxX, boxY);
				boxX -= 50; 
				boxesPut--;
			}
		}
		
		public function placeDummyRectangle(boxX:Number,boxY:Number):void
		{
			
			var dummySkin:DummySkin = new DummySkin();
			var dummySkinEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			dummySkinEngine.addChild(dummySkin);
			
			var rectBody:qb2Shape = qb2Stock.newRectShape(new amPoint2d(0,0), dummySkin.width, dummySkin.height, postMass, 0);
			rectBody.actor = dummySkinEngine;	
			rectBody.position = new amPoint2d(boxX, boxY);			
			rectBody.frictionZ = 3.4;
			
			map.addObject(rectBody);
			rectBody.addEventListener(qb2ContactEvent.CONTACT_STARTED, contactWithObjectFunct, null, true);
		}
		
		public function placeTrafficCone(boxX:Number, boxY:Number):void
		{
			
			var dummySkin:TrafficCone = new TrafficCone();
			var dummySkinEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
			dummySkinEngine.addChild(dummySkin);
			
			var rectBody:qb2Body = qb2Stock.newRectBody(new amPoint2d(0,0), dummySkin.width, dummySkin.height, postMass, 0);
			rectBody.actor = dummySkinEngine;	
			rectBody.position = new amPoint2d(boxX, boxY);			
			rectBody.frictionZ = 3.4;
			
			map.addObject(rectBody);
			rectBody.addEventListener(qb2ContactEvent.CONTACT_STARTED, contactWithObjectFunct, null, true);
		}
				
		
		public function contactWithObjectFunct(e:qb2ContactEvent):void
		{
			trace("contact with object!!!");
			trace(e.localObject);
			
			if(e.otherObject && e.otherObject.userData)
			{
			if (e.otherObject.userData.isVehicle && levelIsCompleted == false)
			{
					trace("obj is veh = bust *** 2");
					//bustCallback.call();
					//this.levelBusted = true;
			}
			}
		}
		
		public function contactFunct(e:qb2ContactEvent):void
		{
			//trace("contact!!!!!!");
			var otherObject:qb2Object = e.otherObject;
			//trace("otherObject is "+otherObject);
			if (otherObject.userData)
			if(otherObject.userData.isVehicle && levelIsCompleted == false)
			{
					trace("obj is veh = bust");
					//bustCallback.call();
					//this.levelBusted = true;
			}
		}
		
		public function beforeLevelRemove()
		{
			trace("before level remove");
			resetLevelGeneral();
		}
		
		public function get stageWalls():qb2StageWalls
			{  return CarGameMain.singleton.stageWalls;  }
			
		private var _stageWalls:qb2StageWalls = null;
		
		public function get cameraRotation():Number
			{  return CarGameMain.singleton.cameraRotation;  }
			
		public function set cameraRotation(value:Number):void
			{  CarGameMain.singleton.cameraRotation = value;  }
		
		public function get cameraTargetRotation():Number
			{  return CarGameMain.singleton.cameraTargetRotation;  }
			
		public function set cameraTargetRotation(value:Number):void
			{  CarGameMain.singleton.cameraTargetRotation = value;  }
						
		public function get cameraTargetPoint():amPoint2d
			{  return CarGameMain.singleton.cameraTargetPoint;  }
			
		public function get cameraPoint():amPoint2d
			{  return CarGameMain.singleton.cameraPoint;  }
					
		protected function get stageWidth():Number
			{  return CarGameMain.singleton.stageRef.stageWidth;  }
			
		protected function get stageHeight():Number
			{  return CarGameMain.singleton.stageRef.stageHeight;  }
			
		protected function get stage():Stage
			{  return CarGameMain.singleton.stageRef;  }
			
		public virtual function resized():void
		{
			
		}
	}
}