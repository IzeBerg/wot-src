package net.wg.gui.lobby.vehicleCustomization.events.propertiesSheet
{
   import flash.events.Event;
   
   public class CustomizationSheetRendererEvent extends Event
   {
      
      public static const ACTION_BTN_CLICK:String = "actionBtnClick";
       
      
      private var _actionType:int = -1;
      
      private var _actionData:int = -1;
      
      public function CustomizationSheetRendererEvent(param1:String, param2:int, param3:int = -1)
      {
         super(param1,true);
         this._actionType = param2;
         this._actionData = param3;
      }
      
      override public function clone() : Event
      {
         return new CustomizationSheetRendererEvent(type,this._actionType,this._actionData);
      }
      
      public function get actionType() : int
      {
         return this._actionType;
      }
      
      public function get actionData() : int
      {
         return this._actionData;
      }
   }
}
