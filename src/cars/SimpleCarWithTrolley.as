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
	
	
	public class SimpleCarWithTrolley extends qb2Group
	{
		
		private var simpleCar:SimpleCar = new SimpleCar();
		
		private	var trolleyLink:qb2Body = new qb2Body();
		
		private var jointSkin:JointSkin = new JointSkin();
		private var jointSkinEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
		
		private var trolley:Trolley= new Trolley();
		private var center:amPoint2d;
		
		private var stage:Stage;
		
		private var distanceToTrolley:amPoint2d = new amPoint2d(0, 140);
		
		
		public function SimpleCarWithTrolley() 
		{
			super();
			
			this.userData = new Object();
			this.userData.isVehicle = true;
		}
		
		public function init(stageParam:Stage)
		{
			this.stage = stageParam;
			this.actor = new qb2FlashSpriteActor();	
			
			center = new amPoint2d(0,0);
			
			//trolley link
			
			jointSkinEngine.addChild(jointSkin);
			
			trolleyLink.addObject(
			  qb2Stock.newRectShape( new amPoint2d(0, 0), 5, 40, 4)
			);
			
			trolleyLink.actor = jointSkinEngine;
			trolleyLink.contactCategoryFlags = -99;
			
			this.addObject(trolleyLink);
			
			trolleyLink.position = new amPoint2d(center.x, center.y + 72);
			//car
			simpleCar.init(stage);		
			simpleCar.position = center;
			simpleCar.mass = 1200;
			simpleCar.contactCategoryFlags = -99;
			addObject(simpleCar);
				
			//trolley

			trolley.init(stage);
			trolley.position = ( new amPoint2d(center.x, center.y + 174.05));
		
			trolley.angularDamping = 0;
			trolley.contactCategoryFlags = -99;
			addObject(trolley);
			
			
			var firstJointFreedom:Number = 12.8;
			var secondJointFreedom:Number = 12.8;
			
			var limit:Number = 0.9;
			
			// joints			
			var revoluteJoint:qb2RevoluteJoint = new qb2RevoluteJoint(simpleCar, trolleyLink);
			revoluteJoint.collideConnected = false;
			revoluteJoint.localAnchor1 = new amPoint2d(0, 47.75);
			revoluteJoint.localAnchor2 = new amPoint2d(0, -23);
			revoluteJoint.maxTorque = 1111;
			revoluteJoint.lowerLimit = 	-limit;
			revoluteJoint.upperLimit =  limit;
			this.addObject(revoluteJoint);
			
			var revoluteJoint2:qb2WeldJoint = new qb2WeldJoint(trolleyLink,trolley);
			revoluteJoint2.collideConnected = false;		
			revoluteJoint2.localAnchor1 = new amPoint2d(0, 23);	
			revoluteJoint2.localAnchor2 = new amPoint2d(0, -83);
			//revoluteJoint2.maxTorque = 99999;	
			//revoluteJoint2.lowerLimit = -limit;
			//revoluteJoint2.upperLimit = limit;
			this.addObject(revoluteJoint2);			
		}
		
		public function get position():amPoint2d
		{
			return trolley.position;
		}
		
		public function set position(param:amPoint2d)
		{
			trace("simple car position set function");
			simpleCar.position = param;			
			//trace(simpleCar.position);
			trolleyLink.position = new amPoint2d(param.x, param.y + 72);
			//trace(trolleyLink.position);
			trolley.position = new amPoint2d(param.x, param.y + 174.05);
		}
		
		
	}

}