package net.wg.gui.events
{
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class SortableTableListEvent extends ListEventEx
   {
      
      public static const RENDERER_CLICK:String = "tableRendererClick";
      
      public static const RENDERER_PRESS:String = "tableRendererPress";
      
      public static const RENDERER_ROLL_OVER:String = "tableRendererRollOver";
      
      public static const RENDERER_ROLL_OUT:String = "tableRendererRollOut";
      
      public static const RENDERER_DOUBLE_CLICK:String = "tableRendererDoubleClick";
      
      public static const LIST_INDEX_CHANGE:String = "tablelistIndexChange";
      
      public static const RENDERERS_DATA_CNAHGE:String = "renderersDataChange";
       
      
      private var _changedRenderers:Vector.<IListItemRenderer>;
      
      public function SortableTableListEvent(param1:String, param2:Vector.<IListItemRenderer> = null, param3:Boolean = false, param4:Boolean = true, param5:int = -1, param6:int = -1, param7:int = -1, param8:IListItemRenderer = null, param9:Object = null, param10:uint = 0, param11:uint = 0, param12:Boolean = false)
      {
         super(param1,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
         this._changedRenderers = param2;
      }
      
      public static function createByListEvent(param1:ListEvent) : SortableTableListEvent
      {
         var _loc2_:String = "";
         switch(param1.type)
         {
            case ListEvent.ITEM_CLICK:
               _loc2_ = RENDERER_CLICK;
               break;
            case ListEvent.ITEM_PRESS:
               _loc2_ = RENDERER_PRESS;
               break;
            case ListEvent.ITEM_ROLL_OVER:
               _loc2_ = RENDERER_ROLL_OVER;
               break;
            case ListEvent.ITEM_ROLL_OUT:
               _loc2_ = RENDERER_ROLL_OUT;
               break;
            case ListEvent.ITEM_DOUBLE_CLICK:
               _loc2_ = RENDERER_DOUBLE_CLICK;
               break;
            case ListEvent.INDEX_CHANGE:
               _loc2_ = LIST_INDEX_CHANGE;
         }
         return new SortableTableListEvent(_loc2_,null,param1.bubbles,param1.cancelable,param1.index,param1.columnIndex,param1.rowIndex,param1.itemRenderer,param1.itemData,param1.controllerIdx,param1.buttonIdx,param1.isKeyboard);
      }
      
      public function get changedRenderers() : Vector.<IListItemRenderer>
      {
         return this._changedRenderers;
      }
   }
}
