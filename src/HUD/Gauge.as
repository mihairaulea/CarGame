package HUD 
{
	
	import flash.display.*;
	import flash.events.*;
	
	public class Gauge extends Sprite
	{
				
		private var steerIndicator:SteerIndicator = new SteerIndicator();
		private var speedIndicator:SpeedIndicator = new SpeedIndicator();
			
		public function Gauge() 
		{
			addChild(steerIndicator);
			steerIndicator.x = 130;

			addChild(speedIndicator);
		}
		
		public function updateSteer(newSteerValue:Number):void
		{
			steerIndicator.indicatorBar.x = newSteerValue * 103.5 + 103.5;
		}
		
		public function updateSpeed(newSpeedValue:Number):void
		{
			speedIndicator.indicatorBar.y = -newSpeedValue * 103.5 + 103.5;
		}
		
	}

}