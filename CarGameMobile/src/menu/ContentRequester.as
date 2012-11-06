package menu {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class ContentRequester extends MovieClip {
		
		public var contentId:int=0;
		public var requestObject:Object=null;
		public static var REQUEST_CONTENT:String="requestContent";
		
		public function ContentRequester() {
			
		}
		
		public function init() {
			
		}
		
		public function requestContent(contentToRequest:int,requestObjectParam:Object=null) {
			contentId = contentToRequest;
			requestObject=requestObjectParam;
			dispatchEvent(new Event(ContentRequester.REQUEST_CONTENT));
		}
		
		public function destroy() {
			
		}
		
		public function sendNotification(notification:Object) {
			
		}
		
	}
	
}