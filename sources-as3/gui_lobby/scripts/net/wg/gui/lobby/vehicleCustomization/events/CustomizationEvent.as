package net.wg.gui.lobby.vehicleCustomization.events
{
   import flash.events.Event;
   
   public class CustomizationEvent extends Event
   {
      
      public static const CLOSE_VIEW:String = "closeView";
      
      public static const SHOW_BUY_WINDOW:String = "showBuyWindow";
      
      public static const SHOW_PROGRESSION_DECALS_WINDOW:String = "showProgressionDecalsWindow";
      
      public static const RESET_FILTER:String = "clearFilter";
      
      public static const REFRESH_FILTER_DATA:String = "refreshFilterData";
      
      public static const SELECT_HOT_FILTER:String = "selectHotFilter";
      
      public static const SHOW_PROPERTIES_SHEET:String = "showPropertiesSheet";
      
      public static const CLOSE_PROPERTIES_SHEET:String = "closePropertiesSheet";
      
      public static const SHOW_INSCRIPTION_CONTROLLER:String = "showInscriptionController";
      
      public static const HIDE_INSCRIPTION_CONTROLLER:String = "hideInscriptionController";
      
      public static const CLEAR_BTN_PRESS:String = "customizationClear";
      
      public static const ELEMENTS_CONROLS_HIDE:String = "customizationControlsHideInvalid";
      
      public static const ITEMS_POPOVER_CLOSED:String = "customizationItemsPopoverStateInvalid";
       
      
      private var _index:int = -1;
      
      private var _select:Boolean = false;
      
      private var _group:String = "";
      
      public function CustomizationEvent(param1:String, param2:Boolean = false, param3:int = -1, param4:String = "", param5:Boolean = true, param6:Boolean = true)
      {
         super(param1,param5,param6);
         this._index = param3;
         this._select = param2;
         this._group = param4;
      }
      
      override public function clone() : Event
      {
         return new CustomizationEvent(type,this._select,this._index,this._group,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("CustomizationEvent","type","select","group","index","bubbles","cancelable");
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function get select() : Boolean
      {
         return this._select;
      }
      
      public function get group() : String
      {
         return this._group;
      }
      
      public function set group(param1:String) : void
      {
         this._group = param1;
      }
   }
}
