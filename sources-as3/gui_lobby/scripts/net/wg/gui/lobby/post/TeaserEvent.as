package net.wg.gui.lobby.post
{
   import flash.events.Event;
   
   public class TeaserEvent extends Event
   {
      
      public static const HIDE:String = "teaser_hide";
      
      public static const TEASER_CLICK:String = "teaser_click";
       
      
      public function TeaserEvent(param1:String, param2:Boolean = false, param3:Boolean = true)
      {
         super(param1,param2,param3);
      }
      
      public function get teaser() : Teaser
      {
         return Teaser(target);
      }
   }
}
