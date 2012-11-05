/**
 * Copyright (c) 2010 Johnson Center for Simulation at Pine Technical College
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package As3Math.general
{
	import As3Math.*;
	import As3Math.general.*;
	import flash.events.*;
	import revent.rEvent;
	use namespace am_friend;
	
	public class amUpdateEvent extends rEvent 
	{
		public static const ENTITY_UPDATED:String = "entityUpdated";
		
		am_friend var _entity:amEntity = null;
		
		public function amUpdateEvent(type:String = null) 
		{ 
			super(type);
		}
		
		public override function clone():rEvent 
		{ 
			var clonedEvent:amUpdateEvent = new amUpdateEvent(type);
			clonedEvent._entity = this._entity;
			return clonedEvent;
		}
		
		public function get entity():amEntity
		{
			return _entity;
		}
	}
}