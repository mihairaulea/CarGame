package 
{
	import flash.display.*;	
	import flash.events.Event;
	import menu.MainMenu;
	import util.ScreenConstants;
	
	//[Frame(factoryClass="QuickB2.misc.qb2FlashPreloader")]
	[SWF(width="800", height="600", frameRate="90", backgroundColor="#787878")]
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
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			this.stage.addEventListener(Event.RESIZE, stage_resizeHandler);
			
			mainMenu = new MainMenu(new CarGameMain(stage));	
			addChild(mainMenu);
		}
		
		private function stage_resizeHandler(event:Event):void
		{
			ScreenConstants.ActualScreenWidth = this.stage.fullScreenWidth;
			ScreenConstants.ActualScreenHeight = this.stage.fullScreenHeight;
			
			trace(this.stage.fullScreenWidth, this.stage.fullScreenHeight);
		}
		
	}	
}