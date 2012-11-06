package 
{
	import flash.display.*;	
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import menu.MainMenu;
	import util.ScreenConstants;
	
	//[Frame(factoryClass="QuickB2.misc.qb2FlashPreloader")]
	[SWF(width="800", height="600", frameRate="90", backgroundColor="#666666")]
	public class Main extends Sprite 
	{
		
		//private var carGame:CarGameMain;
		private var mainMenu:MainMenu;
		
		public function Main()
		{	
			//Mobile touch
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			trace("main");
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			this.stage.addEventListener(Event.RESIZE, stage_resizeHandler);
			addEventListener(Event.ENTER_FRAME, init);
		}
		
		private function init(e:Event)
		{
			trace("init");
			removeEventListener(Event.ENTER_FRAME, init);
			
			mainMenu = new MainMenu(new CarGameMain(stage));	
			addChild(mainMenu);
		}
		
		private function stage_resizeHandler(event:Event):void
		{
			ScreenConstants.ActualScreenWidth = this.stage.fullScreenWidth;
			ScreenConstants.ActualScreenHeight = this.stage.fullScreenHeight;
		}
		
	}	
}