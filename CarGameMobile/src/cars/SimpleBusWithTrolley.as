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
	
	
	public class SimpleBusWithTrolley extends qb2Group
	{
		
		private var simpleBus:SimpleBus= new SimpleBus();
		
		
		private var jointSkin:JointSkin = new JointSkin();
		private var jointSkinEngine:qb2FlashSpriteActor = new qb2FlashSpriteActor();
		
		private var trolley:TrolleyBus = new TrolleyBus();
		private	var trolleyLink:qb2Body = new qb2Body();
		
		
		private var stage:Stage;
		
		var center:amPoint2d;
		
		private var distanceToTrolley:amPoint2d = new amPoint2d(0, 140);
		
		public function SimpleBusWithTrolley() 
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
			jointSkinEngine.width = 10;
			jointSkinEngine.height = 40;
			
			trolleyLink.addObject(
			  qb2Stock.newRectShape( new amPoint2d(0, 0), jointSkinEngine.width, jointSkinEngine.height, 4)
			);
			
			trolleyLink.actor = jointSkinEngine;
			
			this.addObject(trolleyLink);
			trolleyLink.position = new amPoint2d(center.x, center.y - 25);
			//car
			simpleBus.init(stage);		
			simpleBus.position = center;
			simpleBus.mass = 2000;
			//simpleBus.angularDamping = 2.5;
			addObject(simpleBus);
				
			var circle2:qb2Body = qb2Stock.newCircleBody(new amPoint2d(0, 60), 2, 1500);
			
			//trolley

			trolley.init(stage);
			trolley.position = ( new amPoint2d(center.x, center.y + 170));
		
			addObject(trolley);
			
			
			// joints
			
			var revoluteJoint:qb2RevoluteJoint = new qb2RevoluteJoint(simpleBus, trolleyLink);
			revoluteJoint.collideConnected = false;
			//revoluteJoint.lowerLimit = -2;
			//revoluteJoint.upperLimit = 2;
			revoluteJoint.localAnchor1 = new amPoint2d(0, 120);
			revoluteJoint.localAnchor2 = new amPoint2d(0, -40);
			//revoluteJoint.maxTorque = 29999;
			
			this.addObject(revoluteJoint);
			
			var revoluteJoint2:qb2WeldJoint = new qb2WeldJoint(trolleyLink,trolley);
			revoluteJoint2.collideConnected = false;
			//revoluteJoint2.lowerLimit = 0;
			//revoluteJoint2.upperLimit = 0;
			revoluteJoint2.localAnchor1 = new amPoint2d(0, 50);
			revoluteJoint2.localAnchor2 = new amPoint2d(0, -30);
			//revoluteJoint2.maxTorque = 2000;
			
			this.addObject(revoluteJoint2);
		}
		
		public function get position():amPoint2d
		{
			return simpleBus.position;
		}
		
		public function set position(newPosition:amPoint2d):void
		{
			simpleBus.position = newPosition;
			trolleyLink.position = new amPoint2d(newPosition.x, newPosition.y - 25);
			trolley.position = ( new amPoint2d(newPosition.x, newPosition.y + 170));
			
		}
		
	}

}