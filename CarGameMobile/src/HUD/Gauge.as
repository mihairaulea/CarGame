package HUD 
{
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import util.ScreenConstants;
	
	public class Gauge extends Sprite
	{
				
		private var steerIndicator:SteerIndicator = new SteerIndicator();
		private var speedIndicator:SpeedIndicator = new SpeedIndicator();
		
		private var steeringWheel:SteeringWheel = new SteeringWheel();	
		private var dragBounds:Rectangle;
		public var steeringValue:Number;
		
		private var startDragRotation:Number;
		
		public function Gauge() 
		{
			const gapY:Number = ScreenConstants.ActualScreenHeight * 0.05;
			const gapX:Number = ScreenConstants.ActualScreenWidth * 0.05;
			
			addChild(steerIndicator);
			steerIndicator.x = 130;

			addChild(speedIndicator);
			
			steeringWheel.addEventListener(TouchEvent.TOUCH_BEGIN, touchBeginHandler);
			steeringWheel.addEventListener(TouchEvent.TOUCH_MOVE, touchMoveHandler);
			dragBounds = new Rectangle(0, 0, ScreenConstants.ActualScreenWidth, ScreenConstants.ActualScreenHeight);
			addChild(steeringWheel);
			if (ScreenConstants.ActualScreenHeight < ScreenConstants.InitialScreenHeight);
			{
				steeringWheel.scaleX = steeringWheel.scaleY = ScreenConstants.ActualScreenHeight / ScreenConstants.InitialScreenHeight;
			}
			steeringWheel.x = ScreenConstants.ActualScreenWidth - steeringWheel.width;
			steeringWheel.y = ScreenConstants.ActualScreenHeight;
			steeringWheel.rotation = -90;
		}
		
		public function updateSteer(newSteerValue:Number):void
		{
			steerIndicator.indicatorBar.x = newSteerValue * 103.5 + 103.5;
		}
		
		public function updateSpeed(newSpeedValue:Number):void
		{
			speedIndicator.indicatorBar.y = -newSpeedValue * 103.5 + 103.5;
		}
		
		private function touchBeginHandler(event:TouchEvent):void
		{
			trace("TOUCHBEGIN");
			startDragRotation = convertToAngle(event.stageX, event.stageY);
		}
		
		private function touchMoveHandler(event:TouchEvent):void
		{
			trace("TOUCHMOVE");
			convertCoords(event.stageX, event.stageY);
		}
		
		private function convertCoords(posX:Number, posY:Number):void
		{
			var rotationValue:Number = convertToAngle(posX, posY);
			
			trace(rotationValue, "ROTATION VALUE", startDragRotation, "STEERWHEEL ROTATION");
			
			if (startDragRotation > rotationValue && steeringWheel.rotation + (rotationValue - startDragRotation) > -180)
				steeringWheel.rotation += (rotationValue - startDragRotation);
			else if (startDragRotation < rotationValue && steeringWheel.rotation + (rotationValue - startDragRotation) < 0)
				steeringWheel.rotation += (rotationValue - startDragRotation);
			
			startDragRotation = rotationValue;	
			steeringValue = ((rotationValue * -1) + 90) / 90;
		}
		
		private function convertToAngle(posX:Number, posY:Number):Number
		{
			var x:Number = posX - steeringWheel.x;
			var y:Number = steeringWheel.y - steeringWheel.height / 16 - posY;
			var rotationValue:Number = (Math.atan(y/x) * 180 / Math.PI);
			if (x < 0) 
				rotationValue += 180;
			if (x>=0 && y<0) 
				rotationValue += 360;
			
			rotationValue *= -1;		
				
			if (rotationValue < -180)
				rotationValue = -180;
			else if (rotationValue > 0)
				rotationValue = 0;
			 
			return rotationValue;	
		}
	}

}