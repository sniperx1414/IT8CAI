package classes.functions {
	import flash.net.URLVariables;
	import classes.Static;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLLoader;
	public class Connect {
		private static var servername:String;
		private static var username:String;
		private static var password:String;
		//
		//public static function setConnection(servername:String, username:String, password:String = "", dbname:String):void {
			//Connect.servername = servername;
			//Connect.username = username;
			//Connect.password = password;
			//conn = new Connection(servername, 3306, username, password, dbname);
		//}
		public static function search(query:String,cols:Array,onComplete:Function):void {
			var s:String = "";
			for (var i:int = 0; i < cols.length; i++) 
			{
				if (i == 0) s += cols[i];
				else s += "|" + cols[i];
			}
			var vars:URLVariables = new URLVariables();
			vars.query = query;
			vars.colnames = s;
			vars.requestName = "search";
			Connect.request(vars, onComplete);
		}
		public static function execute(command:String,onComplete:Function):void {
			var vars:URLVariables = new URLVariables();
			vars.requestName = "executeCommand";
			vars.command = command;
			Connect.request(vars, onComplete);
		}
		public static function executeCommands(commands:Array, onComplete:Function):void {
			var s:String = "";
			for (var i:int = 0; i < commands.length; i++) 
			{
				if (i == 0) s += commands[i];
				else s += "|" + commands[i];
			}
			var vars:URLVariables = new URLVariables();
			vars.commands = s;
			vars.requestName = "executeCommands";
			Connect.request(vars, onComplete);
		}
		public static function request(variables:URLVariables, onComplete:Function):void {
			var varSend:URLRequest = new URLRequest(Static.connectPath);
			varSend.method  = URLRequestMethod.POST;
			varSend.data = variables;
			var varLoader:URLLoader = new URLLoader();
			varLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
			varLoader.addEventListener(Event.COMPLETE, onComplete);
			varLoader.load(varSend);
		}
	}
	
	
}