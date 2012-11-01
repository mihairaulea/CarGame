package model 
{
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class GameModel 
	{
		
		private static var instance:GameModel;
		
		var levelTimer:Timer = new Timer(1000);
		
		var callbackTimerFunction:Function;
		
		public function GameModel(singletonEnforcer:MySingletonEnforcer) 
		{ 
			levelTimer.addEventListener(TimerEvent.TIMER, timerTick);
		} 
		
		public static function getInstance():GameModel
		{
			if (instance == null) instance = new GameModel();
			
		}
		
		public function resetLevel(timerCallbackFunctionParam:Function)
		{
			this.callbackTimerFunction = timerCallbackFunctionParam;
			levelTimer.start();
		}
		
		private function timerTick(e:TimerEvent)
		{
			//callbackTimerFunction.call( levelTimer.currentCount );
		}
		
		
		public function stopTimerAndGetTotalTime():String
		{
			var time:int = levelTimer.currentCount;
			levelTimer.stop;
			return String(Math.floor(time / 60) + ":" + String( time%60 );
		}
		
	}
	
	class MySingletonEnforcer {}

}