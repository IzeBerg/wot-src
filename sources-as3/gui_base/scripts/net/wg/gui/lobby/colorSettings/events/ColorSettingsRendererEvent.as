package net.wg.gui.lobby.colorSettings.events
{
   import flash.events.Event;
   
   public class ColorSettingsRendererEvent extends Event
   {
      
      public static const SETTINGS_TYPE_SELECTED:String = "SETTINGS_TYPE_SELECTED";
      
      public static const FILTER_SELECTED:String = "FILTER_SELECTED";
      
      public static const RESET_CLICKED:String = "RESET_CLICKED";
       
      
      private var _itemIndex:int = -1;
      
      public function ColorSettingsRendererEvent(param1:String, param2:int, param3:Boolean = true)
      {
         this._itemIndex = param2;
         super(param1,param3,cancelable);
      }
      
      override public function clone() : Event
      {
         return new ColorSettingsRendererEvent(type,this._itemIndex,bubbles);
      }
      
      public function get itemIndex() : int
      {
         return this._itemIndex;
      }
   }
}
