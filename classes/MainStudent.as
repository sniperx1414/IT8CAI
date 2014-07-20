package classes
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import flash.events.MouseEvent;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	/**
	 * ...
	 * @author Anthony P. Alaan
	 */
	public class MainStudent extends MovieClip 
	{
		
		public function MainStudent() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, added);
			this.x = 0 - this.width;
			this.btnexit.addEventListener(MouseEvent.CLICK, function():void {
				Static.it8.showConfirm("Are you sure you want to exit?", function():void {
					exit("login");
				});
			});
		}
		private function added(e:Event):void {
			this.intro();
		}
		private function intro():void {
			this.x = 0 - this.width;
			TweenLite.to(this,1, new TweenLiteVars().x(1366 / 2 - this.width / 2).ease(Linear.easeNone));
		}
		private function exit(goto:String):void {
			TweenLite.to(this, 1, new TweenLiteVars().y(0 - this.height).ease(Linear.easeNone).onComplete(function():void {
				Static.goto(goto);
			}));
		}
	}

}