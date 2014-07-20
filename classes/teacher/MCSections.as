package classes.teacher 
{
	import fl.controls.DataGrid;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import classes.functions.Connect;
	import classes.functions.Functions;
	import flash.events.Event;
	import classes.Static;
	/**
	 * ...
	 * @author Anthony P. Alaan
	 */
	public class MCSections extends MovieClip 
	{
		
		public function MCSections() 
		{
			this.setSections();
			Functions.setButtonEvents([_btndelete, _btnedit,_btnnew]);
		}
		private function setSections():void {
			Connect.search("select st.section_teacher_id, st.sec_id,sec_name,st.active,getsectionstudentcount(st.section_teacher_id)" +
			" from section_teacher " +
			"st left join sections s on s.sec_id = st.sec_id where teacher_id = " + Static.user_id + ";", 
				["section_teacher_id", "sec_id","sec_name","active","count"], function(e:Event):void {
					Functions.setDataGrid(_tablesections, 
					[
					Functions.getRecords(e.target.data.section_teacher_id),
					Functions.getRecords(e.target.data.sec_id),
					Functions.getRecords(e.target.data.sec_name),
					Functions.getRecords(e.target.data.active),
					Functions.getRecords(e.target.data.count)
					], 
					["ID","Section ID", "Section Name", "Active","Student Count"]);
					Functions.hideColumn(_tablesections, 0);
					Functions.hideColumn(_tablesections, 1);
					Functions.hideColumn(_tablesections, 3);
			});
		}
		
		
		
		public function get _tablesections():DataGrid { return this.tablesections as DataGrid; }
		public function get _btnnew():SimpleButton { return this.btnnew; }
		public function get _btnedit():SimpleButton { return this.btnedit; }
		public function get _btndelete():SimpleButton { return this.btndelete; }
		
	}

}