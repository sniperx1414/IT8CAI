package classes{
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	
	public class ExecuteFunctionAfter {
		private var f:Function;
		private var args:Array;
		private var tar:Object;
		private var after:Number;
		private var interval:uint;
		
		public function ExecuteFunctionAfter(f:Function, args:Array, tar:Object,after:Number) {
			this.f = f;
			this.args = args;
			this.tar = tar;
			this.after  = after;
		}
		public function start():void {
			this.interval = setInterval(start_, this.after * 1000);
		}
		private function start_():void {
			clearInterval(this.interval);
			this.f.apply(this.tar,this.args);
		}
	}
	
	
	
}