package classes.teacher 
{
	import fl.controls.ComboBox;
	import fl.controls.DataGrid;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import classes.functions.Connect;
	import classes.functions.Functions;
	import flash.events.Event;
	import classes.Static;
	import flash.events.MouseEvent;
	import classes.teacher.*;
	import classes.Mode;
	
	
	/**
	 * ...
	 * @author Anthony P. Alaan
	 */
	public class MCQuizzes extends MovieClip 
	{
		
		public function MCQuizzes() 
		{
			Functions.setButtonEvents([_btnnew, _btnedit, _btndelete]);
			this.setQuizzes();
			this._btnnew.addEventListener(MouseEvent.CLICK, function():void {
				quizinfo = new MCQuiz(Mode.NEW);
				quizinfo.onclose = function():void {
					Functions.outro(quizinfo, 0.5, function():void {
						removeChild(quizinfo);
						setQuizzes();
					});
				};
				addChild(quizinfo);
				quizinfo.x = -107.1;
				quizinfo.y = -135.85;
				Functions.intro(quizinfo);
			});
			this._btnedit.addEventListener(MouseEvent.CLICK, function():void {
				if (_tablequizzes.selectedIndex != -1) {
					quizinfo = new MCQuiz(Mode.EDIT, selectedquizid);
					quizinfo.onclose = function():void {
						Functions.outro(quizinfo, 0.5, function():void {
							removeChild(quizinfo);
							setQuizzes();
						});
					};
					addChild(quizinfo);
					quizinfo.x = -107.1;
					quizinfo.y = -135.85;
					Functions.intro(quizinfo);
				}
			});
			this._btndelete.addEventListener(MouseEvent.CLICK, function():void {
				if (_tablequizzes.selectedIndex != -1) {
					Static.it8.showConfirm("Confirm delete selected quiz?", function():void {
						Connect.execute("delete from quizzes where quiz_id = '"+selectedquizid+"';", function(e:Event):void {
							setQuizzes();
						});
					});
				}
			});
		}
		private var quizinfo:MCQuiz;
		
		private function setQuizzes():void {
			Connect.search("select q.quiz_id, q.quiz_desc,if(q.active, 'yes','no'),q.lesson_id,lesson_name,count(*), " +
			"sum(qq.points) from quiz_questions qq left join quizzes q on q.quiz_id = qq.quiz_id left join " +
			"lessons l on l.lesson_id = q.lesson_id where q.teacher_id = '" + Static.user_id + "' group by qq.quiz_id;", 
			["a","b","c","d","e","f","g"], 
			function(e:Event):void {
				Functions.setDataGrid(_tablequizzes, 
				[
					Functions.getRecords(e.target.data.a),
					Functions.getRecords(e.target.data.b),
					Functions.getRecords(e.target.data.c),
					Functions.getRecords(e.target.data.d),
					Functions.getRecords(e.target.data.e),
					Functions.getRecords(e.target.data.f),
					Functions.getRecords(e.target.data.g)
				]
				, ["Quiz ID","Quiz Description","Active","Lesson ID","Lesson","Items","Points"]);
				Functions.hideColumn(_tablequizzes, 0);
				Functions.hideColumn(_tablequizzes, 3);
			});
		}
		public function get selectedquizid():String { return this._tablequizzes.selectedItem["Quiz ID"] as String; }
		
		
		public function get _tablequizzes():DataGrid { return this.tablequizzes; }
		public function get _btnnew():SimpleButton { return this.btnnew; }
		public function get _btnedit():SimpleButton { return this.btnedit; }
		public function get _btndelete():SimpleButton { return this.btndelete; }
	}

}