package HUD 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	import flash.display.*;
	import flash.utils.Timer;
	import flash.events.*;
	import model.*;
	
	public class InGameMenuWrapper extends Sprite
	{
		
		private var inGameMenu:InGameMenu = new InGameMenu();
		
		
		private var timer:Timer;
		
		public var menuCallback:Function;
		public var restartCallback:Function;
		
		public function InGameMenuWrapper() 
		{
			addChild(inGameMenu);
			inGameMenu.restartBtn.addEventListener(MouseEvent.CLICK, restartHandler);
			inGameMenu.menuBtn.addEventListener(MouseEvent.CLICK, menuHandler);
		}
		
		public function startCounting(amountInSeconds:int)
		{
			
			//test
			this.inGameMenu.timeLeft.text = "10:00";
			//
			if (timer) timer.stop();
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, timerTick);
			timer.start();
			
		}	
		
		public function stopCounting()
		{
			
			//var levelsModel :LevelsModel = LevelsModel.getInstance();
			timer.stop();
			
		}
		
		private function timerTick(e:TimerEvent):void
		{
			if ( String(timer.currentCount) ) this.inGameMenu.timeLeft.text =  (formatToTimeRemaining(timer.currentCount));
		}
		
		private function formatToTimeRemaining( currentCount:int ):String
		{
			var secondsPassed:int = (600 - currentCount);
			var minutes:int  = Math.floor(secondsPassed / 60);
			var seconds:int  = secondsPassed % 60;
			var secondsString:String = "";
			if (seconds >= 0 && seconds <= 9) secondsString = "0" + String(secondsString);
			else secondsString = String(seconds);
			
			return String(minutes) + ":" + secondsString;
		}
		
		private function restartHandler(e:MouseEvent):void
		{
			restartCallback.call();
		}
		
		private function menuHandler(e:MouseEvent):void
		{
			menuCallback.call();
		}
		
	}

}