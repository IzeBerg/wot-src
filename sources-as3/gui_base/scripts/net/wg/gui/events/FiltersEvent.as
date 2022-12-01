package net.wg.gui.events
{
   import flash.events.Event;
   
   public class FiltersEvent extends Event
   {
      
      public static const SEARCH_VALUE_CHANGED:String = "searchNameChanged";
      
      public static const FILTERS_CHANGED:String = "changeFilters";
      
      public static const RESET_ALL_FILTERS:String = "resetAllFilters";
      
      public static const RESET_VEHICLE_FILTERS:String = "resetVehicleFilters";
      
      public static const NATION_FILTER_CHANGED:String = "nationFilterChanged";
      
      public static const MODULES_FILTER_CHANGED:String = "modulesFilterChanged";
       
      
      private var _filtersValue:int;
      
      public var searchValue:String;
      
      public function FiltersEvent(param1:String, param2:int = 0, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._filtersValue = param2;
      }
      
      override public function clone() : Event
      {
         var _loc1_:FiltersEvent = new FiltersEvent(type,this._filtersValue,bubbles,cancelable);
         _loc1_.searchValue = this.searchValue;
         return _loc1_;
      }
      
      public function get filtersValue() : int
      {
         return this._filtersValue;
      }
   }
}
