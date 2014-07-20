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
	public class MCStudents extends MovieClip 
	{
		
		public function MCStudents() 
		{
			Functions.setButtonEvents([_btnconfirm, _btndiscard]);
			this.setSections();
			this._cmbsections.addEventListener(Event.CHANGE, function():void {
				setStudents();
			});
			this._btnconfirm.addEventListener(MouseEvent.CLICK, function():void {
				if (_tablestudents.selectedIndex != -1 && String(_tablestudents.selectedItem["Confirmed"]) == "no") {
					Static.it8.showConfirm("Confirm registration of the student?", function():void {
						Connect.execute("update enrolled set confirmed = true where enrolled_id = '" + selectedenrolledid + "';", 
						function():void {
							setStudents();
						});
					});
				}
			});
			this._btndiscard.addEventListener(MouseEvent.CLICK, function():void {
				if (_tablestudents.selectedIndex != -1 && String(_tablestudents.selectedItem["Confirmed"]) == "no") {
					Static.it8.showConfirm("Discard registration of the student?", function():void {
						Connect.execute("update enrolled set confirmed = false and discarded = true where enrolled_id = '" + selectedenrolledid + "';", 
						function():void {
							setStudents();
						});
					});
				}
			});
		}
		
		private var id:Array, sec_id:Array, sec_name:Array;
		
		private function setSections():void {
			
			Connect.search("select st.section_teacher_id,st.sec_id, sec_name from section_teacher st left join sections s on s.sec_id = st.sec_id " +
			" where st.teacher_id = '" + Static.user_id + "';", 
			["id", "sec_id", "sec_name"], 
				function(e:Event):void {
				id = Functions.getRecords(e.target.data.id);
				sec_id = Functions.getRecords(e.target.data.sec_id);
				sec_name = Functions.getRecords(e.target.data.sec_name);
				Functions.setComboBox(_cmbsections, sec_name);
			});
		}
		public function get selectedsectionteacherid():String { return this.id[this._cmbsections.selectedIndex]; }
		private function setStudents():void {
			if (this._cmbsections.selectedIndex != -1) 
			{
				Connect.search("select e.enrolled_id, e.stud_id, concat(stud_ln,', ',stud_fn,' ',stud_mn), " +
				"stud_gender,stud_bday,user_name,if(confirmed, 'yes', 'no') from enrolled e left join students s on " +
				"s.stud_id = e.stud_id where e.discarded = false and e.active = true and e.section_teacher_id = "+selectedsectionteacherid+";", 
				["a","b","c","d","e","f","g"], function(e:Event):void {
					Functions.setDataGrid(_tablestudents, [
					Functions.getRecords(e.target.data.a),
					Functions.getRecords(e.target.data.b),
					Functions.getRecords(e.target.data.c),
					Functions.getRecords(e.target.data.d),
					Functions.getRecords(e.target.data.e),
					Functions.getRecords(e.target.data.f),
					Functions.getRecords(e.target.data.g)
					], ["ID", "Student ID", "Student Name", "Sex", "Birth Date", "Username", "Confirmed"]);
					Functions.hideColumn(_tablestudents, 0);
					Functions.hideColumn(_tablestudents, 1);
				});
			}
		}
		public function get selectedenrolledid():String { return this._tablestudents.selectedItem["ID"] as String; }
		public function get selectedstudentid():String { return this._tablestudents.selectedIndex["Student ID"] as String; }
		
		
		public function get _cmbsections():ComboBox { return this.cmbsections; }
		public function get _tablestudents():DataGrid { return this.tablestudents; }
		public function get _btnconfirm():SimpleButton { return this.btnconfirm; }
		public function get _btndiscard():SimpleButton { return this.btndiscard; }
	}

}