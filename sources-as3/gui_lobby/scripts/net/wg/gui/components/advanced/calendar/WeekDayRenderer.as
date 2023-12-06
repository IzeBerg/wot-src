package net.wg.gui.components.advanced.calendar
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class WeekDayRenderer extends MovieClip
   {
      
      public static const STATE_NORMAL:String = "normal";
      
      public static const STATE_HIGHLIGHTED:String = "highlighted";
       
      
      public var textField:TextField;
      
      private var _label:String = "";
      
      private var _state:String = "normal";
      
      public function WeekDayRenderer()
      {
         super();
         this.textField.mouseEnabled = false;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         this._label = param1;
         this.updateLabel();
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      public function set state(param1:String) : void
      {
         this._state = param1;
         gotoAndStop(this._state);
         this.updateLabel();
      }
      
      private function updateLabel() : void
      {
         this.textField.text = this._label;
      }
   }
}
