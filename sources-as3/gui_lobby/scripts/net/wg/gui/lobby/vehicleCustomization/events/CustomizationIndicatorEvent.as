package net.wg.gui.lobby.vehicleCustomization.events
{
   import flash.events.Event;
   
   public class CustomizationIndicatorEvent extends Event
   {
      
      public static const REMOVAL:String = "ItemAssignedToTankRemovalEvent";
       
      
      private var _id:Number;
      
      private var _itemsList:Object;
      
      private var _seasonType:int;
      
      public function CustomizationIndicatorEvent(param1:String, param2:Number, param3:Object, param4:int = -1)
      {
         super(param1,true,false);
         this._id = param2;
         this._itemsList = param3;
         this._seasonType = param4;
      }
      
      override public function clone() : Event
      {
         return new CustomizationIndicatorEvent(type,this._id,this._itemsList);
      }
      
      override public function toString() : String
      {
         return formatToString("CustomizationIndicatorEvent","type","id","itemsList","seasonType");
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      public function get itemsList() : Object
      {
         return this._itemsList;
      }
      
      public function get seasonType() : int
      {
         return this._seasonType;
      }
   }
}
