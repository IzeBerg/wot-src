package net.wg.gui.components.paginator.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PaginatorPageNumVO extends DAAPIDataClass
   {
      
      private static const TOOLTIP:String = "tooltip";
       
      
      public var buttonsGroup:String = "";
      
      public var status:String = "";
      
      public var pageIndex:int = -1;
      
      public var label:String = "";
      
      public var selected:Boolean = false;
      
      private var _tooltip:ToolTipVO = null;
      
      public function PaginatorPageNumVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TOOLTIP)
         {
            this._tooltip = new ToolTipVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._tooltip != null)
         {
            this._tooltip.dispose();
            this._tooltip = null;
         }
         super.onDispose();
      }
      
      public function get tooltip() : ToolTipVO
      {
         return this._tooltip;
      }
   }
}
