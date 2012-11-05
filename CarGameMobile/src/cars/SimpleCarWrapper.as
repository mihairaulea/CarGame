package cars 
{
	
	import As3Math.consts.*;
	import As3Math.general.*;
	import As3Math.geo2d.*;
	import flash.display.*;
	import flash.display.DisplayObjectContainer;
	import QuickB2.events.*;
	import QuickB2.misc.qb2Keyboard;
	import QuickB2.objects.qb2Object;
	import QuickB2.objects.tangibles.*;
	import QuickB2.stock.*;
	import TopDown.ai.*;
	import TopDown.ai.brains.*;
	import TopDown.ai.controllers.*;
	import TopDown.carparts.*;
	import TopDown.debugging.*;
	import TopDown.objects.*;
	import TopDown.stock.*;
	import QuickB2.misc.acting.*;
	import QuickB2.objects.joints.*;
	
	
	public class SimpleCarWrapper extends qb2Group
	{
		
		var simpleCar:SimpleCar = new SimpleCar();
		
		public function SimpleCarWrapper() 
		{			
			this.userData = new Object();
			this.userData.isVehicle = true;
		}
		
		public function init(stageParam:Stage)
		{			
			simpleCar.init(stageParam);
			this.actor = new qb2FlashSpriteActor();
			addObject(simpleCar);
		}
		
		public function get position():amPoint2d
		{
			return simpleCar.position;
		}
		
		public function set position(newPosition:amPoint2d):void
		{
			simpleCar.position = newPosition;
			
		}
			
	}

}