package  
{
	
	import flash.display.Sprite;
	import As3Math.consts.TO_DEG;
	import As3Math.consts.TO_RAD;
	import As3Math.geo2d.*;
	import com.bit101.components.*;
	import com.greensock.core.SimpleTimeline;
	import HUD.DebugArrows;
	import HUD.FeedbackScreenWrapper;
	import HUD.InGameMenuWrapper;
	import levels.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextFieldAutoSize;
	import flash.utils.*;
	import menu.ContentRequester;
	import model.LevelsModel;
	import QuickB2.debugging.*;
	import QuickB2.debugging.drawing.qb2_debugDrawSettings;
	import QuickB2.debugging.gui.qb2DebugPanel;
	import QuickB2.effects.qb2EffectField;
	import QuickB2.effects.qb2GravityField;
	import QuickB2.events.qb2UpdateEvent;
	import QuickB2.internals.qb2InternalPropertyAndFlagCollection;
	import QuickB2.loaders.proxies.qb2ProxyBody;
	import QuickB2.loaders.qb2FlashLoader;
	import QuickB2.misc.acting.qb2FlashSpriteActor;
	import QuickB2.objects.*;
	import QuickB2.objects.tangibles.*;
	import QuickB2.stock.*;
	import surrender.srVectorGraphics2d;
	
	import HUD.Gauge;
	
	public class CarGameMain extends ContentRequester {	
	
	    // HUD stuff
		private var HUDgauge:Gauge = new Gauge();
		
		//--- The physics world, kinda like what the stage is for the flash display hierarchy.
		public var world:qb2World = new qb2World();
		
		public const cameraPoint:amPoint2d = new amPoint2d();
		public const cameraTargetPoint:amPoint2d = new amPoint2d();
		private var _cameraRotation:Number = 0;
		private var _cameraTargetRotation:Number = 0;
		public var rotationContainer:Sprite = new Sprite();
				
		
		private var gaugeData:GaugeData;
		
		private var debugArrows:DebugArrows = new DebugArrows();
		private var inGameMenuWrapper:InGameMenuWrapper = new InGameMenuWrapper();
		
		//private var carSkin:CarSkin = new CarSkin();
		
		private var firstTimeInit:Boolean = true;
		private var levelsArray:Array = new Array();
		private var levelsArrayClasses:Array = new Array();
		
		private var levelsInitArray:Array = new Array();
		private var oldLevelPointer:Level;
		private var currentLevelPointer:Level;
		private var currentLevelId:int = 0;
		
		private var bust:BustNotification = new BustNotification();
		private var great:NotifGreatMC = new NotifGreatMC();	
		private var feedbackScreen:FeedbackScreenWrapper = new FeedbackScreenWrapper();
			
		
		public var stageRef:Stage;
		
		private var levelsModel:LevelsModel = LevelsModel.getInstance();
				
		var scaleFactor:Number = 0.4;
		
		public function CarGameMain(stageParam:Stage)
		{			
			this.stageRef = stageParam;
			initCarGame();
			initLevel(0);
			//if (stageRef) initCarGame();
			//else addEventListener(Event.ADDED_TO_STAGE, initCarGame);			
			
			stage.addChild(bust);
			stage.addChild(great);
			stage.addChild(feedbackScreen);
			feedbackScreen.menuCallback = menuRequestHandler;
			feedbackScreen.nextCallback = requestNextLevel;
			feedbackScreen.prevCallback = requestPrevLevel;
			//
			
			this.scaleX = scaleFactor;
			this.scaleY = scaleFactor;
		}
		
		private function carGameClickedHandler(e:MouseEvent)
		{
			super.requestContent(2);
		}
		
		override public function init()
		{
			addEventListener(MouseEvent.DOUBLE_CLICK, carGameClickedHandler);
			trace(levelsModel.getCurrentLevel() + " current level");
			requestNewLevel( levelsModel.getCurrentLevel() );
			makeVisible();
		}
		
		override public function destroy()
		{
			trace("DESTORY");
			inGameMenuWrapper.stopCounting();
			makeInvisible();
		}
		
		private function playerWinLevel():void
		{
			trace("player win level!!!");
			great.visible = true;
		}
		
		private function playerBustLevel():void
		{
			trace("player bust level");
			bust.visible = true;				
		}
		
		private function showFeedbackScreen():void
		{
			feedbackScreen.visible = true;
		}
		
		private function setLevels():void
		{
			var level1:Level1 = new Level1(stageRef, playerBustLevel,playerWinLevel,showFeedbackScreen);
			var level2:Level2 = new Level2(stageRef,playerBustLevel,playerWinLevel,showFeedbackScreen);
			var level3:Level3 = new Level3(stageRef,playerBustLevel,playerWinLevel,showFeedbackScreen);
			var level4:Level4 = new Level4(stageRef,playerBustLevel,playerWinLevel,showFeedbackScreen);
			var level5:Level5 = new Level5(stageRef,playerBustLevel,playerWinLevel,showFeedbackScreen);
			var level6:Level6 = new Level6(stageRef,playerBustLevel,playerWinLevel,showFeedbackScreen);
			var level7:Level7 = new Level7(stageRef,playerBustLevel,playerWinLevel,showFeedbackScreen);
			var level8:Level8 = new Level8(stageRef,playerBustLevel,playerWinLevel,showFeedbackScreen);
			var level9:Level9 = new Level9(stageRef,playerBustLevel,playerWinLevel,showFeedbackScreen);
			var level10:Level10 = new Level10(stageRef,playerBustLevel,playerWinLevel,showFeedbackScreen);
			var level11:Level11 = new Level11(stageRef,playerBustLevel,playerWinLevel,showFeedbackScreen);
			var level12:Level12 = new Level12(stageRef,playerBustLevel,playerWinLevel,showFeedbackScreen);
			var level13:Level13 = new Level13(stageRef,playerBustLevel,playerWinLevel,showFeedbackScreen);
			var level14:Level14 = new Level14(stageRef,playerBustLevel,playerWinLevel,showFeedbackScreen);
			var level15:Level15 = new Level15(stageRef,playerBustLevel,playerWinLevel,showFeedbackScreen);	
			var level16:Level16 = new Level16(stageRef,playerBustLevel,playerWinLevel,showFeedbackScreen);	
			var level17:Level17 = new Level17(stageRef,playerBustLevel,playerWinLevel,showFeedbackScreen);	
			
			//levelsArray[0] = carDriving2;
			
			levelsArray[0] =  level1;			
			levelsArray[1] =  level2;
			levelsArray[2] =  level3;
			levelsArray[3] =  level4;
			levelsArray[4] =  level5;
			levelsArray[5] =  level6;
			levelsArray[6] =  level7;
			levelsArray[7] =  level8;
			levelsArray[8] =  level9;
			levelsArray[9] =  level10;
			levelsArray[10] = level11;
			levelsArray[11] = level12;
			levelsArray[12] = level13;
			levelsArray[13] = level14;
			levelsArray[14] = level15;
			levelsArray[15] = level16;
			levelsArray[16] = level17;
			
			levelsArrayClasses[0] = Level1 as Class;
			levelsArrayClasses[1] = Level2 as Class;
			levelsArrayClasses[2] = Level3 as Class;
			levelsArrayClasses[3] = Level4 as Class;
			levelsArrayClasses[4] = Level5 as Class;
			levelsArrayClasses[5] = Level6 as Class;
			levelsArrayClasses[6] = Level7 as Class;
			levelsArrayClasses[7] = Level8 as Class;
			levelsArrayClasses[8] = Level9 as Class;
			levelsArrayClasses[9] = Level10 as Class;
			levelsArrayClasses[10] = Level11 as Class;
			levelsArrayClasses[11] = Level12 as Class;
			levelsArrayClasses[12] = Level13 as Class;
			levelsArrayClasses[13] = Level14 as Class;
			levelsArrayClasses[14] = Level15 as Class;
			levelsArrayClasses[15] = Level16 as Class;
			levelsArrayClasses[16] = Level17 as Class;
						
			currentLevelPointer = levelsArray[currentLevelId];
			
			for (var i:int = 0; i < levelsArray.length; i++)
			{
				levelsInitArray[i] = false;			
			}
		}
		
		private function setLevelArrows():void
		{
			debugArrows.setLevelArrows(this.stageRef);
			debugArrows.noOfLevels = levelsArray.length;
			//stage.addChild(debugArrows);
			debugArrows.addEventListener(DebugArrows.NEW_LEVEL_REQUEST, newLevelRequestHandler);
		}
		
		private function setInGameMenu():void
		{
			stage.addChild( inGameMenuWrapper );
			inGameMenuWrapper.menuCallback =  menuRequestHandler;
			inGameMenuWrapper.restartCallback =  restartRequestHandler;
			inGameMenuWrapper.x = 762.25;
			inGameMenuWrapper.y = 64.2;
			inGameMenuWrapper.visible = false;
		}
		
		private function menuRequestHandler()
		{
			trace("menu request handler");
			restartRequestHandler();
			makeInvisible();
			makeVisible();
			this.requestContent(1);
		}
		
		private function restartRequestHandler()
		{
			trace("restart from car game main");	
			world.removeObject(this.currentLevelPointer);
			this.currentLevelPointer.restartLevel();
			this.currentLevelPointer = new (levelsArrayClasses[ this.currentLevelId ] )(stageRef, playerBustLevel, playerWinLevel,showFeedbackScreen );
			world.addObject(this.currentLevelPointer);
			this.currentLevelPointer.startLevel();
			makeInvisible();
			makeVisible();
			
			//this.currentLevelPointer.greatCallback = null;
				/*
			this.currentLevelPointer.startLevel();
			this.currentLevelPointer.restartLevel();
			this.oldLevelPointer = this.currentLevelPointer;
			makeInvisible();
			makeVisible();
			*/
			//requestNewLevel(levelsModel.getCurrentLevel());
		}
		
		private function newLevelRequestHandler(e:Event):void
		{
			if (debugArrows.currentPointer >= 0 && debugArrows.currentPointer < levelsArray.length )
			{
				requestNewLevel(debugArrows.currentPointer);
			}
			else trace("debug arrays error!!!");
		}
		
		private function initLevel(levelId:int)
		{
			currentLevelId = levelId;
			currentLevelPointer = levelsArray[levelId];			
			world.addObject(currentLevelPointer);			
			currentLevelPointer.startLevel();
			
			levelsInitArray[levelId] = true;
		}
		
		private function requestNewLevel(levelId:int)
		{
			if (oldLevelPointer) 
			{
				//restartRequestHandler();
				oldLevelPointer.beforeLevelRemove();
			}
			oldLevelPointer = currentLevelPointer;
			currentLevelPointer = levelsArray[levelId];
			world.removeObject(oldLevelPointer);
			world.addObject(currentLevelPointer);			
			if (levelsInitArray[levelId] == false) currentLevelPointer.startLevel();
			
			if (levelsInitArray[levelId] == true) restartRequestHandler();
				
			levelsInitArray[levelId] = true;
			
			this.currentLevelId = levelId;
		}
		
		private function requestNextLevel()
		{
			if (currentLevelId + 1 < levelsArray.length - 1) 
			{
				currentLevelId++;
				restartRequestHandler();
				makeInvisible();
				makeVisible();
				requestNewLevel(currentLevelId);
			}
		}
		
		private function requestPrevLevel()
		{
			
			if (currentLevelId - 1 >= 0) 
			{
				currentLevelId--;
				restartRequestHandler();
				makeInvisible();
				makeVisible();
				requestNewLevel(currentLevelId);
			}
		}
		
		private function initCarGame(e:Event = null):void 
		{						
			removeEventListener(Event.ADDED_TO_STAGE, initCarGame);
			
			_singleton = this;
			visible = false;
			
			bust.visible = false;
			bust.x = 200;
			bust.y = 200;
			
			great.visible = false;
			great.x = 200;
			great.y = 200;
			
			stageRef.addChild(rotationContainer);
			//stage.removeChild(this);
			rotationContainer.addChild(this);
			
			// un-comment to enable mouse drag
			world.debugDragSource = this;
			world.actor = addChild(new qb2FlashSpriteActor()) as qb2FlashSpriteActor;
			var debugDrawSprite:Sprite = (addChild(new Sprite()) as Sprite);
			debugDrawSprite.mouseEnabled = false; // so physics drawing doesn't interfere with gui.
			
			// un-comment to enable debug mode!!
			//world.debugDrawGraphics = new srVectorGraphics2d(debugDrawSprite.graphics);
			
			world.realtimeUpdate = true;
			world.maximumRealtimeStep = 1.0 / 10.0 // make it so a simulation step is never longer than this.
			world.gravity.y = 10;
			world.defaultPositionIterations = 10;
			world.defaultVelocityIterations = 10;
			
			
			if (firstTimeInit == false) world.removeObject( oldLevelPointer );
			
			if (firstTimeInit)
			{
				setLevels();
				setLevelArrows();
				setInGameMenu();
				gaugeData = GaugeData.getInstance();
				gaugeData.addEventListener(GaugeData.CHANGE, onGaugeDataChange);
				
				firstTimeInit = false;
			}			
			
			world.addObject(_stageWalls = new qb2StageWalls(stageRef));	
			
			world.start(); // sets up an ENTER_FRAME loop automatically.  Manual 'step()' method can also be used.
			world.addEventListener(qb2UpdateEvent.POST_UPDATE, update);
			world.step();
			world.wakeUp();
			//rotationContainer.x = stageRef.stageWidth / 2;
			//rotationContainer.y = stageRef.stageHeight / 2;				
			
			// test init
			//initLevel(0);
			stageRef.addChild(HUDgauge);
			
			makeInvisible();
			//makeVisible();
		}
		
		private function onGaugeDataChange(e:Event):void
		{
			HUDgauge.updateSpeed( gaugeData.POWER_MOVE );
			HUDgauge.updateSteer( gaugeData.STEER );
		}
		
		private function makeVisible():void
		{
			visible = true;
			HUDgauge.visible = true;
			debugArrows.visible = true;
			inGameMenuWrapper.visible = true;
			inGameMenuWrapper.startCounting(600);
			feedbackScreen.visible = false;
		}
		
		private function makeInvisible():void
		{
			visible = false;
			HUDgauge.visible = false;
			debugArrows.visible = false;
			bust.visible = false;
			great.visible = false;
			inGameMenuWrapper.visible = false;
			feedbackScreen.visible = false;
		}
		
		public function get cameraRotation():Number
			{  return _cameraRotation * TO_RAD;  }
		public function set cameraRotation(value:Number):void
			{  _cameraRotation = value * TO_DEG;  }
		
		public function get cameraTargetRotation():Number
			{  return _cameraTargetRotation * TO_RAD;  }
		public function set cameraTargetRotation(value:Number):void
		{
			value = value * TO_DEG
			var modulus:Number = value >= 0 ? 360 : -360;
			var newValue:Number = value % modulus + 360;
			
			if ( Math.abs(_cameraRotation - newValue) > 180 )
			{
				if( _cameraRotation - newValue < 0 )
					_cameraRotation += 360;
				else
					cameraRotation -= 360;
			}
	
			_cameraTargetRotation = newValue;
		}
	
		private var distanceCut:Number  = .4;//.05;
		private var snapDistance:Number = 4.7;//.2;
		private var snapRotation:Number = .01;
		
		private function update(evt:qb2UpdateEvent):void
		{
			//--- Move the camera asymptotically closer to the target point until a certain snap tolerance is reached.			
			if ( cameraPoint.distanceTo(cameraTargetPoint) <= snapDistance )
			{
				cameraPoint.copy(cameraTargetPoint);
			}
			else
			{
				var vec:amVector2d = cameraTargetPoint.minus(cameraPoint);
				vec.scaleBy(distanceCut);
				cameraPoint.translateBy(vec);
			}
			
			if ( _cameraRotation != _cameraTargetRotation )
			{
				var rotMove:Number = _cameraTargetRotation - _cameraRotation;
				if ( Math.abs(rotMove) < snapRotation )
				{
					_cameraRotation = _cameraTargetRotation;
				}
				else
				{
					rotMove *= distanceCut;
					_cameraRotation += rotMove;
				}
			}
			
			this.x = -cameraPoint.x*scaleFactor;
			this.y = -cameraPoint.y*scaleFactor;
			
			this.scaleX = scaleFactor;
			this.scaleY = scaleFactor;
			
			rotationContainer.rotation = _cameraRotation;
			rotationContainer.x = (stageRef.stageWidth) / 2;
			rotationContainer.y = (stageRef.stageHeight)/ 2;
		}
		
		public function get stageWalls():qb2StageWalls
			{  return _stageWalls;  }
		private var _stageWalls:qb2StageWalls = null;
		
		/// Let other classes get some info like stage width easier through this.
		public static function get singleton():CarGameMain
			{  return _singleton;  }
		private static var _singleton:CarGameMain;
	
	}
}