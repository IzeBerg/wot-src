package net.wg.gui.lobby.hangar
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class CrewDropDownEvent extends Event
   {
      
      public static const SHOW_DROP_DOWN:String = "showCompanyDropDown";
      
      public static const HIDE_DROP_DOWN:String = "hideCompanyDropDown";
       
      
      private var _dropDownref:MovieClip = null;
      
      public function CrewDropDownEvent(param1:String, param2:MovieClip)
      {
         super(param1,true,true);
         this._dropDownref = param2;
      }
      
      public function get dropDownref() : MovieClip
      {
         return this._dropDownref;
      }
   }
}
