package menu.screens 
{
	/**
	 * ...
	 * @author Mihai Raulea
	 */
	
	 import menu.ContentRequester;
	 import flash.display.*;
	 import flash.events.*;
	 
	 public class FirstScreenImpl extends ContentRequester 
	{
		
		private var firstScreen:FirstScreen = new FirstScreen();
		
		public function FirstScreenImpl() 
		{
			addChild(firstScreen);
			firstScreen.addEventListener(MouseEvent.CLICK, firstScreenClickedHandler);
		}
		
		private function firstScreenClickedHandler(e:MouseEvent)
		{
			requestContent(1);
		}
		
	}

}