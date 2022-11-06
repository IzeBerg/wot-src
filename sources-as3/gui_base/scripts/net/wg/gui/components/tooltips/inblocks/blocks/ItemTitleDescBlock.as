package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.display.DisplayObject;
   import net.wg.data.VO.PaddingVO;
   import net.wg.gui.components.controls.UILoaderAlt;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ItemTitleDescBlock extends ImageTextBlockInBlocks
   {
       
      
      public var overlay:UILoaderAlt = null;
      
      public var highlight:UILoaderAlt = null;
      
      public function ItemTitleDescBlock()
      {
         super();
      }
      
      override public function cleanUp() : void
      {
         if(this.highlight)
         {
            this.highlight.unload();
            this.highlight.x = this.highlight.y = 0;
         }
         if(this.overlay)
         {
            this.overlay.unload();
            this.overlay.x = this.overlay.y = 0;
         }
         super.cleanUp();
      }
      
      override protected function onDispose() : void
      {
         if(this.overlay != null)
         {
            this.overlay.dispose();
            this.overlay = null;
         }
         if(this.highlight != null)
         {
            this.highlight.dispose();
            this.highlight = null;
         }
         super.onDispose();
      }
      
      override protected function applyData() : void
      {
         var _loc1_:Boolean = StringUtils.isNotEmpty(blockData.overlayPath);
         this.overlay.visible = _loc1_;
         if(_loc1_)
         {
            this.overlay.source = blockData.overlayPath;
         }
         this.highlight.visible = StringUtils.isNotEmpty(blockData.highlightPath);
         if(this.highlight.visible)
         {
            this.highlight.source = blockData.highlightPath;
         }
         super.applyData();
      }
      
      override protected function onLayoutImage() : void
      {
         var _loc1_:PaddingVO = null;
         var _loc2_:PaddingVO = null;
         super.onLayoutImage();
         if(StringUtils.isNotEmpty(blockData.overlayPath))
         {
            _loc1_ = blockData.overlayPadding;
            if(_loc1_)
            {
               this.updateRelativePosition(imageLoader,this.overlay,_loc1_);
            }
         }
         if(StringUtils.isNotEmpty(blockData.highlightPath))
         {
            _loc2_ = blockData.highlightPadding;
            if(_loc2_)
            {
               this.updateRelativePosition(imageLoader,this.highlight,_loc2_);
            }
         }
      }
      
      private function updateRelativePosition(param1:DisplayObject, param2:DisplayObject, param3:PaddingVO) : void
      {
         param2.x = param1.x + param3.left;
         param2.y = param1.y + param3.top;
      }
   }
}
