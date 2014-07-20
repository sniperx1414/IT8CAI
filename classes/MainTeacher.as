package  classes
{
	import classes.teacher.*;
	import com.greensock.data.ColorTransformVars;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import classes.functions.Functions;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.ScalePlugin;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.data.TransformAroundCenterVars;
	/**
	 * ...
	 * @author Anthony P. Alaan
	 */
	public class MainTeacher extends MovieClip 
	{
		
		public function MainTeacher() 
		{
			TweenPlugin.activate([ScalePlugin, AutoAlphaPlugin,TransformAroundCenterPlugin]);
			this.mclocation = new Point(155,116);
			this.addEventListener(Event.ADDED_TO_STAGE, added);
			this.btnexit.addEventListener(MouseEvent.CLICK, function():void {
				Static.it8.showConfirm("Confirm exit?", function():void {
					exit("login");
				});
			});
			this.btnsections.addEventListener(MouseEvent.CLICK, function():void {
				mcsections = new MCSections();
				showMC(mcsections);
			});
			this.btnstudents.addEventListener(MouseEvent.CLICK, function():void {
				mcstudents = new MCStudents();
				showMC(mcstudents);
			});
			this.btnquizzes.addEventListener(MouseEvent.CLICK, function():void {
				mcquizzes = new MCQuizzes();
				showMC(mcquizzes);
			});
			this.btnquizresults.addEventListener(MouseEvent.CLICK, function():void {
				mcquizresults = new MCQuizResults();
				showMC(mcquizresults);
			});
			Functions.setButtonEvents([_btnquizresults,_btnquizzes,_btnsections,_btnstudents]);
		}
		private var mclocation:Point;
		private var mcsections:MCSections, mcstudents:MCStudents, mcquizzes:MCQuizzes,mcquizresults:MCQuizResults;
		private function showMC(mc:MovieClip):void {
			for (var i:int = 0; i < this.numChildren; i++) 
			{
				if (getChildAt(i) is MCSections || getChildAt(i) is MCStudents || getChildAt(i) is MCQuizzes || getChildAt(i) is MCQuizResults) {
					Functions.outro(getChildAt(i) as MovieClip, 0.5, function(tar:DisplayObject):void {
						removeChild(tar);
					},[getChildAt(i)] );
					//removeChildAt(i); i--;
				}
			}
			this.addChild(mc);
			mc.x = this.mclocation.x;
			mc.y = this.mclocation.y;
			mc.alpha = 0;
			Functions.intro(mc);
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
		public function get _btnstudents():SimpleButton { return btnstudents; }
		public function get _btnsections():SimpleButton { return btnsections; }
		public function get _btnquizzes():SimpleButton { return btnquizzes; }
		public function get _btnquizresults():SimpleButton { return btnquizresults; }
	}

}