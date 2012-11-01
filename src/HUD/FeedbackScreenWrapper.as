package HUD 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	import flash.display.*; 
	import flash.events.*; 
	
	public class FeedbackScreenWrapper extends Sprite
	{
		private var feedbackScreen:FeedbackScreen = new FeedbackScreen();
		
		public var menuCallback:Function;
		public var prevCallback:Function;
		public var nextCallback:Function;
		
		public function FeedbackScreenWrapper() 
		{
			addChild(feedbackScreen);
			feedbackScreen.menuBtn.addEventListener(MouseEvent.CLICK, menuHandler);
			feedbackScreen.prevBtn.addEventListener(MouseEvent.CLICK, prevHandler);
			feedbackScreen.nextBtn.addEventListener(MouseEvent.CLICK, nextHanler);
		}
		
		private function menuHandler(e:MouseEvent)
		{
			menuCallback.call();
		}
		
		private function prevHandler(e:MouseEvent)
		{
			prevCallback.call();
		}
		
		private function nextHanler(e:MouseEvent)
		{
			nextCallback.call();
		}
		
		public function setTime(time:String)
		{
			this.feedbackScreen.yourTimeDisplay.text = time;
		}
		
	}

}