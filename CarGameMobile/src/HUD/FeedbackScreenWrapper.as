package HUD 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	import flash.display.*; 
	import flash.events.*; 
	import util.ScreenConstants;
	
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
		
		public function draw():void
		{
			const gapY:Number = ScreenConstants.ActualScreenHeight * 0.05;
			const gapX:Number = ScreenConstants.ActualScreenWidth * 0.05;
			
			feedbackScreen.menuBtn.x = ScreenConstants.ActualScreenWidth - feedbackScreen.menuBtn.width * .5 - gapX;
			feedbackScreen.menuBtn.y = gapY;
			
			feedbackScreen.prevBtn.x = feedbackScreen.prevBtn.width * .5 + gapX;
			feedbackScreen.prevBtn.y = ScreenConstants.ActualScreenHeight - feedbackScreen.prevBtn.height * .5 - gapY;
			
			feedbackScreen.nextBtn.x = ScreenConstants.ActualScreenWidth - feedbackScreen.nextBtn.width * .5 - gapX;
			feedbackScreen.nextBtn.y = ScreenConstants.ActualScreenHeight - feedbackScreen.prevBtn.height * .5 - gapY;
			
			feedbackScreen.backgroundImage.width = ScreenConstants.ActualScreenWidth;
			feedbackScreen.backgroundImage.height = ScreenConstants.ActualScreenHeight;
			feedbackScreen.backgroundImage.x = ScreenConstants.ActualScreenWidth * .5;
			feedbackScreen.backgroundImage.y = ScreenConstants.ActualScreenHeight * .5;

		}
		
	}

}