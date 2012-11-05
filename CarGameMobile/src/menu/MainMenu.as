package menu 
{
	
	import flash.display.*;
	import flash.events.*;
	
	public class MainMenu extends Sprite
	{
		
		private var contentManipulator:ContentManipulator = new ContentManipulator();
		
		public function MainMenu(carGame:CarGameMain) 
		{
			contentManipulator.actualGame = carGame;
			init();
		}
		
		private function init()
		{
			addChild(contentManipulator);
			contentManipulator.setUpContent(0);
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
	}

}