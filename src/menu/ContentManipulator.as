package menu {
	
	import flash.display.*;
	import flash.events.*;
	import menu.screens.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	public class ContentManipulator extends MovieClip {
		
		private var currentContent=0;
		private var oldContentPointer:MovieClip;
		private var contentPointer:MovieClip;
		
		var firstScreen:FirstScreenImpl = new FirstScreenImpl();
		var selectVehicleScreen:SelectVehicleScreenImpl = new SelectVehicleScreenImpl();
		var selectLevelScreen:SelectLevelScreenImpl = new SelectLevelScreenImpl();
		
		public var actualGame:CarGameMain;
		
		var idLevelSelected:String = new String();
			
		private var contentArray:Array=new Array();
		
		public function ContentManipulator() {
			
		}
		
		public function setUpContent(defaultScreen:int=0) {
			contentArray[0]=firstScreen;
			contentArray[1]=selectVehicleScreen;
			contentArray[2]=selectLevelScreen;
			contentArray[3]=selectLevelScreen;	
			contentArray[4]=actualGame;
			//actualGame.visible = false;
			
			contentPointer=contentArray[defaultScreen];
			oldContentPointer=contentArray[defaultScreen];
			addEventListeners();
			contentPointer.init();
			contentPointer.visible = true;
		}
		
		private function addEventListeners() {
			for (var i:int = 0; i < contentArray.length; i++) {
				if(i!=4) addChild(contentArray[i]);
				contentArray[i].visible = false;
				contentArray[i].addEventListener(ContentRequester.REQUEST_CONTENT, contentChangeRequest);
			}
		}
		
		private function contentChangeRequest(e:Event) {
			trace("contentChangeRequest");
			contentChanged(e.target.contentId,e.target.requestObject);
		}
		
		private function contentChanged(requestedLink:int,requestObject:Object=null):void {
			trace(requestedLink);
			trace(currentContent);
			if(requestedLink!=currentContent) {
				
				if(requestObject!=null) {
					collectContentChangedData(requestObject);
				}
								
				currentContent=requestedLink;
				contentPointer=contentArray[requestedLink];
				removeContent();
			}
		}
		
		function removeContent() {
			TweenMax.to(oldContentPointer, 0.4, { alpha:0, ease:Circ.easeIn,onComplete:addNewContent});
		}
		
		function addNewContent() {
			
			oldContentPointer.destroy();
			oldContentPointer.visible = false;
			//removeChild(oldContentPointer);
			//addChild(contentPointer);
			contentPointer.visible = true;
			contentPointer.alpha=1;
			contentPointer.init();
			TweenMax.to(contentPointer, 0.4, { alpha:1, ease:Circ.easeIn});
			oldContentPointer=contentPointer;
			
			/*
			if(currentContent==2) {
				contentPointer.initGame(idLevelSelected);
			} 
			*/
		}
		
		function collectContentChangedData(requestObject:Object) {
			if(requestObject.from=="levelSelect") {
				idLevelSelected = String(requestObject.levelSelected);				
			}
		}
		
	}
	
}