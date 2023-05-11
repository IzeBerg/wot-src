package net.wg.gui.components.popovers.events
{
   import flash.events.Event;
   
   public class VehicleSelectRendererEvent extends Event
   {
      
      public static const RENDERER_CLICK:String = "RendererClick";
       
      
      private var _dbID:int = -1;
      
      private var _autoClose:Boolean = false;
      
      public function VehicleSelectRendererEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._dbID = param2;
         this._autoClose = param3;
      }
      
      public function get dbID() : int
      {
         return this._dbID;
      }
      
      public function get autoClose() : Boolean
      {
         return this._autoClose;
      }
      
      override public function clone() : Event
      {
         return new VehicleSelectRendererEvent(type,this._dbID,this._autoClose,bubbles,cancelable);
      }
   }
}
