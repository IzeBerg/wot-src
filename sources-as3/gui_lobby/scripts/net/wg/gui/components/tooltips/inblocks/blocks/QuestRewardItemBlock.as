package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.display.DisplayObject;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.inblocks.data.ImageBlockVO;
   import net.wg.gui.components.tooltips.inblocks.data.QuestRewardImageBlockVO;
   import net.wg.gui.lobby.questsWindow.data.PaddingsVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class QuestRewardItemBlock extends ImageBlock
   {
       
      
      public var overlay:UILoaderAlt = null;
      
      private var _blockData:QuestRewardImageBlockVO = null;
      
      public function QuestRewardItemBlock()
      {
         super();
      }
      
      override public function cleanUp() : void
      {
         this.overlay.unload();
         this.overlay.x = this.overlay.y = 0;
         this.overlay.setSourceSize(this.overlay.originalWidth,this.overlay.originalHeight);
         super.cleanUp();
      }
      
      override public function getHeight() : Number
      {
         return imageLoader.height;
      }
      
      override public function setBlockData(param1:Object) : void
      {
         super.setBlockData(param1);
         this._blockData = QuestRewardImageBlockVO(this.data);
      }
      
      override protected function createData(param1:Object) : ImageBlockVO
      {
         return new QuestRewardImageBlockVO(param1);
      }
      
      override protected function onDispose() : void
      {
         this.overlay.dispose();
         this.overlay = null;
         this._blockData = null;
         super.onDispose();
      }
      
      override protected function onValidateBlock() : Boolean
      {
         var _loc1_:PaddingsVO = null;
         if(StringUtils.isNotEmpty(this._blockData.overlayPath))
         {
            _loc1_ = this._blockData.overlayPadding;
            if(_loc1_)
            {
               this.updateRelativePosition(imageLoader,this.overlay,_loc1_);
            }
         }
         return super.onValidateBlock();
      }
      
      override protected function applyData() : void
      {
         var _loc1_:String = this._blockData.overlayPath;
         var _loc2_:Boolean = StringUtils.isNotEmpty(_loc1_);
         this.overlay.visible = _loc2_;
         if(_loc2_)
         {
            this.overlay.source = _loc1_;
         }
         super.applyData();
      }
      
      private function updateRelativePosition(param1:DisplayObject, param2:DisplayObject, param3:PaddingsVO) : void
      {
         param2.x = param1.x + param3.left;
         param2.y = param1.y + param3.top;
      }
   }
}
