package net.wg.gui.lobby.vehicleCustomization.events
{
   import flash.events.Event;
   
   public class CustomizationItemEvent extends Event
   {
      
      public static const INSTALL_ITEM:String = "installItemEvent";
      
      public static const SELECT_ITEM:String = "selectItemEvent";
      
      public static const EDIT_ITEM:String = "editItemEvent";
      
      public static const DESELECT_ITEM:String = "deselectItemEvent";
      
      public static const REMOVE_ITEM:String = "removeItemEvent";
      
      public static const INSTALL_CUSTOM_STYLE:String = "installStyle";
      
      public static const INSTALL_STYLES:String = "installStyles";
      
      public static const SEEN_ITEM:String = "seenItem";
       
      
      private var _itemId:int = 0;
      
      private var _groupId:int = 0;
      
      private var _progressionLevel:int = -1;
      
      private var _fromStorage:Boolean = false;
      
      public function CustomizationItemEvent(param1:String, param2:uint = 0, param3:uint = 0, param4:int = -1, param5:Boolean = false, param6:Boolean = true, param7:Boolean = false)
      {
         super(param1,param6,param7);
         this._itemId = param2;
         this._groupId = param3;
         this._fromStorage = param5;
         this._progressionLevel = param4;
      }
      
      override public function clone() : Event
      {
         return new CustomizationItemEvent(type,this._itemId,this._groupId,this._progressionLevel,this._fromStorage,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("CustomizationItemEvent","type","itemId","fromStorage","groupId","progressionLevel","bubbles","cancelable");
      }
      
      public function get itemId() : uint
      {
         return this._itemId;
      }
      
      public function get groupId() : uint
      {
         return this._groupId;
      }
      
      public function get progressionLevel() : int
      {
         return this._progressionLevel;
      }
      
      public function get fromStorage() : Boolean
      {
         return this._fromStorage;
      }
   }
}
