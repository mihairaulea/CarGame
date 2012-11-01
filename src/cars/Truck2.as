package cars 
{
	
	import As3Math.consts.*;
	import As3Math.general.*;
	import As3Math.geo2d.*;
	import flash.display.*;
	import flash.display.DisplayObjectContainer;
	import QuickB2.events.*;
	import QuickB2.misc.qb2Keyboard;
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
	
	public class Truck2 extends qb2Group
	{
		
		private var stage:Stage;		
		var center:amPoint2d;
		
		var truckHead:Truck2Head = new Truck2Head();
		var trolley:Truck2Trolley = new Truck2Trolley();
		var trolley2:Truck2Trolley2 = new Truck2Trolley2();
		var trolleyLink2:qb2Body = new qb2Body();
		
		var truck2IntermediateWheels:Truck2IntermediateWheels = new Truck2IntermediateWheels();
		
		
		public function Truck2() 
		{
			super();
			this.userData = new Object();
			this.userData.isVehicle = true;
		}
		
		public function init(stageParam:Stage)
		{			
			this.stage = stageParam;
			this.actor = new qb2FlashSpriteActor();			
						
			center = new amPoint2d(0, 0);
			
			// truck head
			truckHead.init(stage);		
			truckHead.position = center;
			addObject(truckHead);
			truckHead.contactGroupIndex = -99;
			
			// trolley
			
			trolley.init(stage);
			trolley.position = (new amPoint2d(center.x, center.y + 42));
			//addObject(trolley);
			trolley.contactGroupIndex = -99;
			
			
			// trolley turning wheels			
			truck2IntermediateWheels.init(stage);
			this.addObject(truck2IntermediateWheels);
			truck2IntermediateWheels.contactGroupIndex = -99;
			truck2IntermediateWheels.position = new amPoint2d(center.x, center.y + 158.15);
			truck2IntermediateWheels.angularDamping = 2.5;
								
			// joints
			
			var jointFromTruckHeadMovingWheels:qb2RevoluteJoint = new qb2RevoluteJoint(truckHead,truck2IntermediateWheels);
			jointFromTruckHeadMovingWheels.localAnchor1 = new amPoint2d(0,119.8);
			jointFromTruckHeadMovingWheels.localAnchor2 = new amPoint2d(0, -33.7);
			jointFromTruckHeadMovingWheels.maxTorque = 300;
			jointFromTruckHeadMovingWheels.lowerLimit = -4;
			jointFromTruckHeadMovingWheels.upperLimit =  4;
			this.addObject(jointFromTruckHeadMovingWheels);
			
			var jointFromMovingWheelsToSecondTruck:qb2RevoluteJoint = new qb2RevoluteJoint(truck2IntermediateWheels,trolley2);
			jointFromMovingWheelsToSecondTruck.localAnchor1 = new amPoint2d(0,32.3);
			jointFromMovingWheelsToSecondTruck.localAnchor2 = new amPoint2d(0, -150);
			jointFromMovingWheelsToSecondTruck.maxTorque = 300;
			jointFromMovingWheelsToSecondTruck.lowerLimit = -4;
			jointFromMovingWheelsToSecondTruck.upperLimit =  4;
			this.addObject(jointFromMovingWheelsToSecondTruck);
			
			// trolley 2
			trolley2.init(stage);
			trolley2.position = new amPoint2d(center.x, center.y + 343.65);
			addObject(trolley2);
			trolley2.contactGroupIndex = -99;
			trolley2.angularDamping = 1.5;
			//link
			
			/*
			trolleyLink2.addObject(
			  qb2Stock.newRectShape( new amPoint2d(0, 0), 3, 20, 2)
			);
			
			this.addObject(trolleyLink2);
			trolleyLink2.position = new amPoint2d(center.x, center.y + 116.55);
			trolleyLink2.contactGroupIndex = -99;		
			
			*/
		}
		
		public function get position():amPoint2d
		{
			return truckHead.position;
		}
		
		public function set position(position:amPoint2d):void
		{
			
			truckHead.position = position;
			trolley.position = (new amPoint2d(position.x, position.y + 42));
			truck2IntermediateWheels.position = new amPoint2d(position.x, position.y + 158.15);
			trolley2.position = new amPoint2d(position.x, position.y + 343.65);
			trolleyLink2.position = new amPoint2d(position.x, position.y + 116.55);						
			
		}
		
	}

}