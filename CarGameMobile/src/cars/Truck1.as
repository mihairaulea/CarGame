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
	
	public class Truck1 extends qb2Group
	{
		
		private var stage:Stage;		
		private var center:amPoint2d;
		
		private var truckHead:Truck1Head = new Truck1Head();
		private var trolley:Truck1Trolley = new Truck1Trolley();
		private var trolleyLink:qb2Body = new qb2Body();
		
		private	var revoluteJoint:qb2RevoluteJoint = new qb2RevoluteJoint(truckHead, trolleyLink);
		private	var revoluteJoint2:qb2RevoluteJoint = new qb2RevoluteJoint(trolleyLink,trolley);
		
		public function Truck1() 
		{
			super();
			this.userData = new Object();
			this.userData.isVehicle = true;
		}
		
		public function init(stageParam:Stage)
		{			
			this.stage = stageParam;
			this.actor = new qb2FlashSpriteActor();			
						
			center = new amPoint2d(stage.stageWidth / 2, stage.stageHeight / 2);
			
			// truck head
			truckHead.init(stage);		
			truckHead.position = center;
			truckHead.angularDamping = 2.5;
			addObject(truckHead);
			truckHead.contactGroupIndex = -99;
			
			// trolley
			trolley.init(stage);
			trolley.position = (new amPoint2d(center.x, center.y + 168.2));
			addObject(trolley);
			trolley.contactGroupIndex = -99;
			
			//link
			
			trolleyLink.addObject(
			  qb2Stock.newRectShape( new amPoint2d(0, -14), 3, 20, 2)
			);
			
			this.addObject(trolleyLink);
			trolleyLink.position = new amPoint2d(center.x, center.y + 38);
			trolleyLink.contactGroupIndex = -99;
			//this.position.copy(center);
			
			// joints
			
			revoluteJoint.collideConnected = false;
			//revoluteJoint.lowerLimit = -0.3;
			//revoluteJoint.upperLimit = 0.3;
			revoluteJoint.localAnchor1 = new amPoint2d(0, 14.5);//-143.35);
			revoluteJoint.localAnchor2 = new amPoint2d(0, -20);// alter last param to increase distance between truck and trolley
			revoluteJoint.maxTorque = 29999;
			
			this.addObject(revoluteJoint);
			
			revoluteJoint2.collideConnected = false;
			//revoluteJoint2.lowerLimit = 0;
			//revoluteJoint2.upperLimit = 0;
			revoluteJoint2.localAnchor1 = new amPoint2d(0, +10);
			revoluteJoint2.localAnchor2 = new amPoint2d(0, -143.35);
			//revoluteJoint2.maxTorque = 2000;
			
			this.addObject(revoluteJoint2);
		}
		
		public function get position():amPoint2d
		{
			return truckHead.position;
		}
		
		public function set position(position:amPoint2d):void
		{
			truckHead.position = position;
			trolley.position = (new amPoint2d(position.x, position.y + 168.2));
			trolleyLink.position = new amPoint2d(position.x, position.y + 38);
		}
		
		public function putBackwardsAtPosition(position:amPoint2d)
		{
			this.removeObject(revoluteJoint);
			this.removeObject(revoluteJoint2);
			
			this.rotateBy(3.15);
			
			truckHead.position = position;
			trolleyLink.position = new amPoint2d(position.x, position.y - 38);
			trolley.position = new amPoint2d(position.x, position.y - 168);
			
			this.addObject(revoluteJoint);
			
			revoluteJoint.localAnchor1 = new amPoint2d(0,-19.5);//-143.35);
			revoluteJoint.localAnchor2 = new amPoint2d(0, -20);// alter last param to increase distance between truck and trolley
			
			this.addObject(revoluteJoint2);
			
			revoluteJoint2.localAnchor1 = new amPoint2d(0, +10);
			revoluteJoint2.localAnchor2 = new amPoint2d(0, -143.35);
			
			//trolley.rotateBy(3.15);
			//truckHead.rotateBy(3.15);
			//trolleyLink.rotateBy(3.15);
		}
		
	}

}