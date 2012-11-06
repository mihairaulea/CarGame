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
			addChild(firstScreen);
			firstScreen.x = (ScreenConstants.ActualScreenWidth - firstScreen.width) * .5;
			firstScreen.y = (ScreenConstants.ActualScreenHeight - firstScreen.height) * .5;
			firstScreen.addEventListener(MouseEvent.CLICK, firstScreenClickedHandler);
		}
		
		private function firstScreenClickedHandler(e:MouseEvent)
		{
			requestContent(1);
		}
		
	}

}