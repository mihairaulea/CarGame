package menu.screens 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	 import menu.ContentRequester;
	 import flash.display.*;
	 import flash.events.*;
	 
	 import util.ScreenConstants;
	 
	 public class FirstScreenImpl extends ContentRequester 
	{
		
		private var firstScreen:FirstScreen = new FirstScreen();
		
		public function FirstScreenImpl() 
		{
			draw();
			firstScreen.addEventListener(MouseEvent.CLICK, firstScreenClickedHandler);
		}
		
		protected function draw():void
		{	
			ScreenConstants.ContentScaleFactor = ScreenConstants.ActualScreenHeight / firstScreen.height;
			ScreenConstants.ReverseScaleFactor = 1 / ScreenConstants.ContentScaleFactor;
			
			if (ScreenConstants.ContentScaleFactor < 1)
			{
				firstScreen.FirstScreenBackground.width = ScreenConstants.ActualScreenWidth * ScreenConstants.ReverseScaleFactor;
				firstScreen.FirstScreenBackground.height = ScreenConstants.ActualScreenHeight * ScreenConstants.ReverseScaleFactor;
				firstScreen.FirstScreenBackground.x = firstScreen.width * .5;	
				firstScreen.FirstScreenBackground.y = firstScreen.height * .5;
				firstScreen.FirstScreenContent.x = firstScreen.width * .5;
				firstScreen.FirstScreenContent.y = firstScreen.height * .5;
				firstScreen.scaleY = firstScreen.scaleX = ScreenConstants.ContentScaleFactor;
			}
			else if (ScreenConstants.ContentScaleFactor > 1)
			{
				firstScreen.FirstScreenBackground.width = ScreenConstants.ActualScreenWidth;
				firstScreen.FirstScreenBackground.height = ScreenConstants.ActualScreenHeight;
			
				firstScreen.FirstScreenBackground.x = firstScreen.width * .5;	
				firstScreen.FirstScreenBackground.y = firstScreen.height * .5;
				firstScreen.FirstScreenContent.x = firstScreen.width * .5;
				firstScreen.FirstScreenContent.y = firstScreen.height * .5;
			}
			
			firstScreen.x = (ScreenConstants.ActualScreenWidth - firstScreen.width) * .5;
			firstScreen.y = (ScreenConstants.ActualScreenHeight - firstScreen.height) * .5;
			
			addChild(firstScreen);
		}
		
		private function firstScreenClickedHandler(e:MouseEvent)
		{
			requestContent(1);
		}
		
	}

}