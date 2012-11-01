package TopDown.ai.controllers 
{
	import As3Math.general.*;
	import flash.display.*;
	import flash.ui.*;
	import TopDown.objects.*;
	import levels.GaugeData;
	
	
	public class tdKeyboardCarController extends tdKeyboardController
	{
		public var turnRate:Number = .01;
		
		private var _leftRight:Number = 0;
		
		public const keysBrake:Vector.<uint>     = new Vector.<uint>();
		public const keysShiftUp:Vector.<uint>   = new Vector.<uint>();
		public const keysShiftDown:Vector.<uint> = new Vector.<uint>();
				
		// the finite state machine only processes forward and back requests;the steering is independent
		internal var currentAction  :String = "none";
		internal var lastAction     :String = "none";
		internal var currentCarState:String = "entry";
		
		private var CAR_NONE:String = "none";
		private var CAR_ACCEL:String = "carAccel";
		private var CAR_DECCEL:String = "carDeccel";
		
		private var ACTION_BREAK:String = "break";
		private var ACTION_UP   : String  = "up";
		private var ACTION_DOWN : String  = "down";
		
		internal var currentSpeed:Number = 0;
		internal var forwardIncrement:Number = 0.005;
		internal var backwardIncrement:Number = 0.005;
		
		internal var currentSteeringAngle:Number = 0;
		internal var steeringIncrement:Number = 0.01;
		
		private var gaugeData:GaugeData;
		
		public function tdKeyboardCarController(keySource:Stage)
		{
			super(keySource);
			
			gaugeData = GaugeData.getInstance();
			
			keysBrake.push(Keyboard.SPACE);
			keysShiftUp.push(221);
			keysShiftDown.push(219);
			//test
			activated();
		}
		
		protected override function activated():void
		{
			if ( host is tdCarBody )
			{
				brainPort.open = true;
				super.activated();
			}
			else
			{
				brainPort.open = false;
			}
		}
		
		protected override function deactivated():void
		{
			super.deactivated();
			_leftRight = 0;
		}
		
		protected override function update():void
		{
			super.update();
			
			brainPort.clear();
			
			lastAction = currentAction;
			
			var brakeDown:Boolean = keyboard.isDown(keysBrake);
			var forwardDown:Boolean = keyboard.isDown(keysForward);
			var backDown:Boolean = keyboard.isDown(keysBack);
			var leftDown:Boolean = keyboard.isDown(keysLeft);
			var rightDown:Boolean = keyboard.isDown(keysRight);
						
			var forwardBack:Number = 0;
			var brake:Number = brakeDown ? 1 : 0;
			
			if (brakeDown) currentAction = "break";
			
			if ( (!backDown && forwardDown) || (backDown && !forwardDown) )
			{
				if (!brakeDown)
				{
				if (backDown) 	 currentAction = "backward";
				if (forwardDown) currentAction = "forward";
				}
			}
			
			if ( !brakeDown && !backDown && !forwardDown ) currentAction = "none";
			
			
			//currentAction = processFiniteStateMachine();
			
			/*
			if (currentAction == "forward") {
				currentCarState = "goForward";
				currentSpeed += forwardIncrement; 
			}
			
			if (currentAction == "backward"){
				currentCarState = "goBackward";
				currentSpeed -= forwardIncrement; 
			}
			if (currentAction == "break")
			{
				currentCarState = "break";
				currentSpeed = 0; 
			}
			
			if (currentAction == "none")
				currentCarState = "noAction";
			*/
			//
			if ( brakeDown == false )
			{
				if ( forwardDown && !backDown )  
				{ 
					currentSpeed += forwardIncrement; 
				}
				else 
				{
				if ( !forwardDown && backDown )					
					currentSpeed -= forwardIncrement;		
				}
			}
			else currentSpeed = 0;
			//
			currentSpeed = amUtils.constrain(currentSpeed, -1, 1);
						
			if ( leftDown || rightDown )
			{
				if ( leftDown  )
				{
					_leftRight -= turnRate;
				}
				if ( rightDown )
				{
					_leftRight += turnRate;
				}
				
				_leftRight = amUtils.constrain(_leftRight, -1, 1);
			}
			
			gaugeData.POWER_MOVE = currentSpeed;
			gaugeData.STEER 	 = _leftRight;
			gaugeData.changed();
			
			
			brainPort.NUMBER_PORT_1 = currentSpeed;
			brainPort.NUMBER_PORT_2 = _leftRight * (host as tdCarBody).maxTurnAngle;
			brainPort.NUMBER_PORT_3 = brake;
		}
		
		private function processFiniteStateMachine():String
		{
			var actionResult:String = "none";
			
			if (currentAction == "break") return "break";
			if (currentAction == "none") return "none";
			if (currentAction == "forward"  && lastAction == "none")  return "forward";
			//if (currentAction == "backward" && lastAction == "forward") return "break";
			//if (currentAction == "backward" && lastAction == "none" && currentSpeed > 0) return "break";
			if (currentAction == "backward" && lastAction == "break")   return "backward";
			if (currentAction == "backward" && lastAction == "none")   return "backward";
			if (currentAction == "backward")   return "backward";
			
			return actionResult;
		}
		
		protected override function keyEvent(keyCode:uint, down:Boolean):void
		{
			super.keyEvent(keyCode, down);
		}
	}
}