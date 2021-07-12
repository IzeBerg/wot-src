package net.wg.gui.events
{
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class ListEventEx extends ListEvent
   {
      
      public static const ITEM_CLICK:String = "itemClick";
      
      public static const ITEM_RIGHT_CLICK:String = "itemRightClick";
      
      public static const ITEM_PRESS:String = "itemPress";
      
      public static const ITEM_ROLL_OVER:String = "itemRollOver";
      
      public static const ITEM_ROLL_OUT:String = "itemRollOut";
      
      public static const ITEM_DOUBLE_CLICK:String = "itemDoubleClick";
      
      public static const INDEX_CHANGE:String = "listIndexChange";
      
      public static const ITEM_TEXT_CHANGE:String = "itemTextChange";
      
      public static const ITEM_DRAG_OVER:String = "itemDragOver";
      
      public static const ITEM_DRAG_OUT:String = "itemDragOut";
      
      public static const ITEM_RELEASE_OUTSIDE:String = "itemReleaseOutside";
      
      public static const ITEM_DRAG_START:String = "dragStart";
      
      public static const ITEM_DRAG_STOP:String = "dragStop";
      
      public static const UPDATE_COMPLETE:String = "updateComplete";
       
      
      public function ListEventEx(param1:String, param2:Boolean = false, param3:Boolean = true, param4:int = -1, param5:int = -1, param6:int = -1, param7:IListItemRenderer = null, param8:Object = null, param9:uint = 0, param10:uint = 0, param11:Boolean = false)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
   }
}
