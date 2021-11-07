package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   
   public class TextBlockVO extends DAAPIDataClass
   {
      
      private static const ITEMS_FIELD_NAME:String = "items";
      
      private static const TOOLTIP:String = "tooltip";
       
      
      public var linkage:String = "";
      
      public var items:Vector.<String> = null;
      
      public var separator:String = "";
      
      public var ellipsis:String = "";
      
      public var endline:String = "";
      
      public var showInNewLine:Boolean = false;
      
      public var complexTooltip:String = "";
      
      public var tooltipVO:ToolTipVO = null;
      
      public function TextBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == ITEMS_FIELD_NAME)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,ITEMS_FIELD_NAME + Errors.CANT_NULL);
            _loc4_ = _loc3_.length;
            this.items = new Vector.<String>(_loc4_,true);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this.items[_loc5_] = _loc3_[_loc5_];
               _loc5_++;
            }
            return false;
         }
         if(param1 == TOOLTIP)
         {
            this.tooltipVO = new ToolTipVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.items != null)
         {
            this.items.fixed = false;
            this.items.splice(0,this.items.length);
            this.items = null;
         }
         if(this.tooltipVO != null)
         {
            this.tooltipVO.dispose();
            this.tooltipVO = null;
         }
         super.onDispose();
      }
   }
}
