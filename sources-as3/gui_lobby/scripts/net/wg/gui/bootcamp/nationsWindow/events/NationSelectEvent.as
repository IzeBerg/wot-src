package net.wg.gui.bootcamp.nationsWindow.events
{
   import flash.events.Event;
   
   public final class NationSelectEvent extends Event
   {
      
      public static const NATION_SHOW:String = "nationShow";
       
      
      private var _selectedNation:int = 0;
      
      public function NationSelectEvent(param1:String, param2:int = 0, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._selectedNation = param2;
      }
      
      override public function clone() : Event
      {
         return new NationSelectEvent(type,this._selectedNation,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("NationSelectEvent","selectedNation","type","bubbles","cancelable");
      }
      
      public function get selectedNation() : int
      {
         return this._selectedNation;
      }
   }
}
