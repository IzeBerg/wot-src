package net.wg.gui.components.controls.events
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class DropdownMenuEvent extends Event
   {
      
      public static const SHOW_DROP_DOWN:String = "showDropDown";
      
      public static const CLOSE_DROP_DOWN:String = "closeDropDown";
       
      
      private var _dropDownRef:MovieClip = null;
      
      public function DropdownMenuEvent(param1:String, param2:MovieClip)
      {
         super(param1,true,true);
         this._dropDownRef = param2;
      }
      
      public function get dropDownRef() : MovieClip
      {
         return this._dropDownRef;
      }
   }
}
