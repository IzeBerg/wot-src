package net.wg.gui.components.advanced
{
   import net.wg.data.constants.SortingInfo;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SortingButtonVO extends DAAPIDataClass
   {
      
      public static const SORT_NUMERIC:String = "numeric";
      
      public static const SORT_STRING:String = "string";
       
      
      public var id:String = "";
      
      public var iconSource:String = "";
      
      public var ascendingIconSource:String = "";
      
      public var descendingIconSource:String = "";
      
      public var toolTip:String = "";
      
      public var buttonWidth:Number = NaN;
      
      public var buttonHeight:Number = NaN;
      
      public var enabled:Boolean = true;
      
      public var inverted:Boolean = false;
      
      public var defaultSortDirection:String = "none";
      
      public var sortOrder:int = -1;
      
      public var mouseEnabledOnDisabled:Boolean = false;
      
      public var sortType:String = "numeric";
      
      public var label:String = "";
      
      public function SortingButtonVO(param1:Object)
      {
         super(param1);
      }
      
      public function get defaultSortDir() : uint
      {
         return this.defaultSortDirection == SortingInfo.DESCENDING_SORT ? uint(Array.DESCENDING) : uint(0);
      }
      
      public function get dataSortType() : uint
      {
         return this.sortType == SORT_NUMERIC ? uint(Array.NUMERIC) : uint(Array.CASEINSENSITIVE);
      }
   }
}
