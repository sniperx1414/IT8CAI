package classes
{
	import flash.display.MovieClip;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import flash.events.Event;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	
	/**
	 * ...
	 * @author Anthony P. Alaan
	 */
	public class Splash extends MovieClip 
	{
		
		public function Splash() 
		{
			this.y = 0 - this.height;
			this.this_ = this;
			this.addEventListener(Event.ADDED_TO_STAGE, added);
		}
		private var this_:Splash;
		private function added(e:Event):void {
			TweenLite.to(this, 1, new TweenLiteVars().ease(Linear.easeNone).y(768 / 2 - this.height / 2));
			trace("ok");
			var interval:uint = setInterval(function():void {
				clearInterval(interval);
				TweenLite.to(this_, 1, new TweenLiteVars().y(0 - this_.height).ease(Linear.easeNone).onComplete(function():void {
					Static.goto("login");
				}));
			}, 3000);
		}
		
	}

}