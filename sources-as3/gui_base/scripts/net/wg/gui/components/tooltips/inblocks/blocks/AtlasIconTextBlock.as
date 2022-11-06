package net.wg.gui.components.tooltips.inblocks.blocks
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.tooltips.inblocks.data.AtlasIconTextBlockVO;
   import net.wg.gui.components.tooltips.inblocks.events.ToolTipBlockEvent;
   import net.wg.infrastructure.managers.IAtlasManager;
   
   public class AtlasIconTextBlock extends SpriteTextBlockInBlocks
   {
       
      
      private var _blockData:AtlasIconTextBlockVO = null;
      
      private var _atlasMgr:IAtlasManager;
      
      private var _atlasInited:Boolean = false;
      
      public function AtlasIconTextBlock()
      {
         this._atlasMgr = App.atlasMgr;
         super();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         super.setBlockData(param1);
         this._blockData = AtlasIconTextBlockVO(getData());
      }
      
      override public function cleanUp() : void
      {
         if(this._atlasInited)
         {
            this._atlasMgr.forgetAtlas(this._blockData.atlasName,this.updateIcon);
            this._atlasInited = false;
         }
         content.graphics.clear();
         super.cleanUp();
      }
      
      override public function getHeight() : Number
      {
         return this._blockData && this._blockData.ignoreIconSize ? Number(titleTF.textHeight) : Number(super.getHeight());
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
         this._blockData = null;
         this._atlasMgr = null;
      }
      
      override protected function getBlockVO(param1:Object) : DAAPIDataClass
      {
         return new AtlasIconTextBlockVO(param1);
      }
      
      override protected function applyData() : void
      {
         super.applyData();
         if(this._blockData.atlasName && this._blockData.iconName)
         {
            this._atlasMgr.waitForAtlasInit(this._blockData.atlasName,this.updateIcon);
            this._atlasInited = true;
         }
      }
      
      private function updateIcon() : void
      {
         this._atlasMgr.drawGraphics(this._blockData.atlasName,this._blockData.iconName,content.graphics);
         invalidateBlock();
         dispatchEvent(new ToolTipBlockEvent(ToolTipBlockEvent.SIZE_CHANGE,this));
      }
   }
}
