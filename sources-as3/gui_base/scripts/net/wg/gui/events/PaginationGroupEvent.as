package net.wg.gui.events
{
   import flash.events.Event;
   
   public class PaginationGroupEvent extends Event
   {
      
      public static const PAGE_CHANGED:String = "pageChanged";
      
      public static const GROUP_CHANGED:String = "groupChanged";
       
      
      private var _pageIndex:int;
      
      public function PaginationGroupEvent(param1:String, param2:int = 0, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._pageIndex = param2;
      }
      
      override public function clone() : Event
      {
         return new PaginationGroupEvent(type,this._pageIndex,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("PaginationGroupEvent","type","pageIndex","bubbles","cancelable");
      }
      
      public function get pageIndex() : int
      {
         return this._pageIndex;
      }
   }
}
