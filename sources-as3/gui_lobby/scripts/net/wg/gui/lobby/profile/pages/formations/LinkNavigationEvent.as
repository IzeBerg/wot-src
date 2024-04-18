package net.wg.gui.lobby.profile.pages.formations
{
   import flash.events.Event;
   
   public class LinkNavigationEvent extends Event
   {
      
      public static const TYPE:String = "LinkNavigationEvent";
       
      
      private var _code:String;
      
      public function LinkNavigationEvent(param1:String)
      {
         super(TYPE,true,false);
         this._code = param1;
      }
      
      public function get code() : String
      {
         return this._code;
      }
   }
}
