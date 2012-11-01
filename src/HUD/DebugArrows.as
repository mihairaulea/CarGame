package HUD 
{
	
	import flash.display.*;
	import flash.events.*;
	
	public class DebugArrows extends Sprite
	{
		
		private var leftArrow:LeftArrow = new LeftArrow();
		private var rightArrow:RightArrow = new RightArrow();
		//private var displayTest:DisplayTest = new DisplayTest();
		
		public var currentPointer:int = 0;
		public var noOfLevels:int = 0;
		public static var NEW_LEVEL_REQUEST:String = "newLevelRequest";
		
		private var stageOwn:Stage;
		
		public function DebugArrows() 
		{
			
		}
		
		public function setLevelArrows(stageParam:Stage):void
		{
			this.stageOwn = stageParam;
			
			addChild(leftArrow);
			addChild(rightArrow);
			
			rightArrow.x = stageOwn.stageWidth - rightArrow.width;
			leftArrow.y = rightArrow.y = stageOwn.stageHeight - leftArrow.height;
			//displayTest.output.text = currentPointer as String;
			
			leftArrow.addEventListener(MouseEvent.CLICK, leftArrowClick);
			rightArrow.addEventListener(MouseEvent.CLICK, rightArrowClick);
			stageOwn.addEventListener(Event.RESIZE, stageResize);
		}
		
		private function stageResize(e:Event):void
		{
			rightArrow.x = stageOwn.stageWidth - rightArrow.width;
			leftArrow.y = rightArrow.y = stageOwn.stageHeight - leftArrow.height;		
		}
		
		private function leftArrowClick(e:MouseEvent):void
		{
			var tobePointer:int = currentPointer - 1;
			if ( tobePointer >= 0) 
			{
			currentPointer--;
			dispatchEvent(new Event(DebugArrows.NEW_LEVEL_REQUEST));
			}
			trace("current pointer " + currentPointer);
		}
		
		private function rightArrowClick(e:MouseEvent):void
		{
			var tobePointer:int = currentPointer + 1;
			if ( tobePointer < noOfLevels) 
			{
				currentPointer++;
				dispatchEvent(new Event(DebugArrows.NEW_LEVEL_REQUEST));
			}
			
			trace("current pointer " + currentPointer);
		}
		
	}

}