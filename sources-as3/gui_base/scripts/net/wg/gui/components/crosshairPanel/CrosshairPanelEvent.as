package net.wg.gui.components.crosshairPanel
{
   import flash.events.Event;
   
   public class CrosshairPanelEvent extends Event
   {
      
      public static const SOUND:String = "sound";
       
      
      private var _key:String = null;
      
      public function CrosshairPanelEvent(param1:String, param2:String = null)
      {
         super(param1,true);
         this._key = param2;
      }
      
      public function get key() : String
      {
         return this._key;
      }
      
      override public function clone() : Event
      {
         return new CrosshairPanelEvent(type,this._key);
      }
   }
}
