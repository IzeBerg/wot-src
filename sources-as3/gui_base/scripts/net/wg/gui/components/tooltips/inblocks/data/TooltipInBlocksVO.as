package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.VO.PaddingVO;
   
   public class TooltipInBlocksVO extends BlocksVO
   {
      
      private static const CONTENT_MARGIN_FIELD_NAME:String = "contentMargin";
       
      
      public var highlightType:String = "";
      
      public var contentMargin:PaddingVO = null;
      
      public var marginAfterBlock:int = 0;
      
      public var marginAfterSeparator:int = 0;
      
      public var width:Number = 0.0;
      
      public function TooltipInBlocksVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == CONTENT_MARGIN_FIELD_NAME)
         {
            this.contentMargin = new PaddingVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.contentMargin != null)
         {
            this.contentMargin.dispose();
         }
         this.contentMargin = null;
         super.onDispose();
      }
   }
}
