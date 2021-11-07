package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.VO.PaddingVO;
   
   public class ImageTextBlockVO extends SpriteTextBlockVO
   {
      
      private static const OVERLAY_PADDING_FIELD_NAME:String = "overlayPadding";
      
      private static const HIGHLIGHT_PADDING_FIELD_NAME:String = "highlightPadding";
       
      
      public var imagePath:String = "";
      
      public var overlayPath:String = "";
      
      public var highlightPath:String = "";
      
      public var overlayPadding:PaddingVO = null;
      
      public var highlightPadding:PaddingVO = null;
      
      public var ignoreImageSize:Boolean = false;
      
      public var flipHorizontal:Boolean = false;
      
      public function ImageTextBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == OVERLAY_PADDING_FIELD_NAME && param2 != null)
         {
            this.overlayPadding = new PaddingVO(param2);
            return false;
         }
         if(param1 == HIGHLIGHT_PADDING_FIELD_NAME && param2 != null)
         {
            this.highlightPadding = new PaddingVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.overlayPadding != null)
         {
            this.overlayPadding.dispose();
            this.overlayPadding = null;
         }
         if(this.highlightPadding != null)
         {
            this.highlightPadding.dispose();
            this.highlightPadding = null;
         }
         super.onDispose();
      }
   }
}
