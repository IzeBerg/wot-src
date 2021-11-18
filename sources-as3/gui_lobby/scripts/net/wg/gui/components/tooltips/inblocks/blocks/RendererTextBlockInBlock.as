package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.tooltips.inblocks.data.RendererDataVO;
   import net.wg.gui.components.tooltips.inblocks.data.RendererTextBlockVO;
   import net.wg.gui.components.tooltips.inblocks.events.ToolTipBlockEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class RendererTextBlockInBlock extends SpriteTextBlockInBlocks
   {
       
      
      private var _renderer:IListItemRenderer;
      
      public function RendererTextBlockInBlock()
      {
         super();
      }
      
      override public function cleanUp() : void
      {
         this.clearRenderer();
         super.cleanUp();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this.clearRenderer();
         super.setBlockData(param1);
      }
      
      override protected function getBlockVO(param1:Object) : DAAPIDataClass
      {
         return new RendererTextBlockVO(param1);
      }
      
      override protected function applyData() : void
      {
         var _loc1_:RendererTextBlockVO = RendererTextBlockVO(getData());
         var _loc2_:RendererDataVO = _loc1_.rendererData;
         this._renderer = App.utils.classFactory.getComponent(_loc2_.rendererType,IListItemRenderer);
         this._renderer.addEventListener(Event.CHANGE,this.onRendererChangeHandler);
         this._renderer.setData(_loc2_.data);
         content.addChild(DisplayObject(this._renderer));
         super.applyData();
      }
      
      override protected function getContentWidth() : int
      {
         if(this._renderer != null && this._renderer.visible)
         {
            return this._renderer.width;
         }
         return 0;
      }
      
      private function clearRenderer() : void
      {
         if(this._renderer != null)
         {
            this._renderer.removeEventListener(Event.CHANGE,this.onRendererChangeHandler);
            this._renderer.dispose();
            content.removeChild(DisplayObject(this._renderer));
            this._renderer = null;
         }
      }
      
      private function onRendererChangeHandler(param1:Event) : void
      {
         invalidateBlock();
         dispatchEvent(new ToolTipBlockEvent(ToolTipBlockEvent.SIZE_CHANGE,this));
      }
   }
}
