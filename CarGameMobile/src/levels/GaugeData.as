package levels 
{
	
	import flash.events.*;
	
	public class GaugeData extends EventDispatcher 
	{
		
		public var POWER_MOVE:Number;
		public var STEER     :Number;
		
		public static var CHANGE:String = "change";
		
		public static var instance:GaugeData = null;
		private static var allowInstantiation:Boolean;
		
		public function GaugeData():void {
			
			if (!allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use SingletonDemo.getInstance() instead of new.");
			}
			
		}
		public static function getInstance():GaugeData {
			if (instance == null) {
				allowInstantiation = true;
				instance = new GaugeData();
				allowInstantiation = false;
			}
			
			return instance;
		}

		public function changed():void
		{
			dispatchEvent(new Event(GaugeData.CHANGE));
		}
		
	}

}