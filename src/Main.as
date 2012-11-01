package 
{
	import flash.display.*;	
	import flash.events.Event;
	import menu.MainMenu;
	
	//[Frame(factoryClass="QuickB2.misc.qb2FlashPreloader")]
	public class Main extends Sprite 
	{
		
		//private var carGame:CarGameMain;
		private var mainMenu:MainMenu;
		
		public function Main()
		{	
			trace("main");
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event)
		{
			trace("init");
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
			mainMenu = new MainMenu(new CarGameMain(stage));	
			addChild(mainMenu);
		}
		
	}	
}