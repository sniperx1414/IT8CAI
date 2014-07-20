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
	
	/**
	 * ...
	 * @author Anthony P. Alaan
	 */
	public class MCQuizResults extends MovieClip 
	{
		
		public function MCQuizResults() 
		{
			this.setSections();
			this.setQuizzes();
			this.setQuizResults();
			this._cmbquizzes.addEventListener(Event.CHANGE, function():void {
				setQuizResults();
			});
			this._cmbquizzes.addEventListener(Event.CHANGE, function():void {
				setQuizResults();
			});
		}
		private var section_teacher_id:Array, sec_id:Array, sec_name:Array;
		private var quiz_id:Array;
		private function setQuizResults():void {
			if (this._cmbquizzes.selectedIndex != -1 && this._cmbsections.selectedIndex != -1) {
				Connect.search("select qr.id,concat(stud_ln,', ',stud_fn,' ',stud_mn), quiz_desc, score, items, round((score / items) * 100,2) " +
				"from quiz_results qr left join quizzes q on q.quiz_id = qr.quiz_id left join enrolled e on e.enrolled_id = qr.enrolled_id " +
				"left join students s on s.stud_id = e.stud_id where e.section_teacher_id = '" + selectedsectionteacherid
				+"' and qr.quiz_id = '" + selectedquizid + "';", 
				["a","b","c","d","e","f"], 
				function(e:Event):void {
					Functions.setDataGrid(_tableresults, 
					[
						Functions.getRecords(e.target.data.a),
						Functions.getRecords(e.target.data.b),
						Functions.getRecords(e.target.data.c),
						Functions.getRecords(e.target.data.d),
						Functions.getRecords(e.target.data.e),
						Functions.getRecords(e.target.data.f)
					]
					,["ID", "Student Name", "Quiz Description","Score", "Items", "Grade"]);
				});
			}else {
				this._tableresults.removeAll();
			}
			
		}
		private function setSections():void {
			
			Connect.search("select st.section_teacher_id,st.sec_id, sec_name from section_teacher st left join sections s on s.sec_id = st.sec_id " +
			" where st.teacher_id = '"+Static.user_id+"';", ["id", "sec_id", "sec_name"], function(e:Event):void {
				section_teacher_id = Functions.getRecords(e.target.data.id);
				sec_id = Functions.getRecords(e.target.data.sec_id);
				sec_name = Functions.getRecords(e.target.data.sec_name);
				Functions.setComboBox(_cmbsections, sec_name);
			});
		}
		public function get selectedsectionteacherid():String { return this.section_teacher_id[this._cmbsections.selectedIndex]; }
		private function setQuizzes():void {
			Connect.search("select quiz_id,quiz_desc from quizzes;", 
			["a", "b"], 
			function(e:Event):void {
				quiz_id = Functions.getRecords(e.target.data.a);
				Functions.setComboBox(_cmbquizzes, [Functions.getRecords(e.target.data.b)]);
			});
		}
		public function get selectedquizid():String { return this.quiz_id[this._cmbquizzes.selectedIndex]; }
		
		public function get _tableresults():DataGrid { return this.tableresults; }
		public function get _cmbsections():ComboBox { return this.cmbsections; }
		public function get _cmbquizzes():ComboBox { return this.cmbquizzes; }
		
	}

}