package classes
{
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.Event;
	/**
	 * ...
	 * @author Anthony P. Alaan
	 */
	public class Static 
	{
		
		public function Static() 
		{
			
		}
		
		public static var it8:IT8;
		private static var servername_:String;
		public static var user_name:String;
		public static var user_type:String;
		public static var user_id:String;
		
		public static function get connectPath():String {
			return "http://" + Static.servername + "/it8cai/php/connect.php";
		}
		public static function get servername() { return Static.servername_; }
		public static function loadSettings():void {
			var loader = new URLLoader(new URLRequest("external\\settings.xml"));
			var settings:XML;
			loader.addEventListener(Event.COMPLETE, function(e:Event):void {
				settings = new XML(e.target.data);
				Static.servername_ = settings.servername;
			});
		}
		public static function goto(s:String) {
			Static.it8.gotoAndPlay(s);
		}
	}

}