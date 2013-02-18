package com.rancondev.extensions.qrzbar
{
	import flash.events.Event;
	
	public class QRZBarEvent extends Event
	{
		public static const SCANNED : String = "SCANNED";
		public static const CANCLED : String = "CANCLED";
		
		private var _result:String;
		
		public function get result():String
		{
			return _result;
		}
		
		public function QRZBarEvent(type:String, inputResult:String="")
		{
			_result = inputResult;
			super(type);
		}
		
		override public function clone() : Event
		{
			return new QRZBarEvent( result );
		}
	}
}