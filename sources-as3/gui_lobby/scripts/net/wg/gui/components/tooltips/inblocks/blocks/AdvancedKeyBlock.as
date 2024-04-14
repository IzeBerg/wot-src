package net.wg.gui.components.tooltips.inblocks.blocks
{
   import flash.display.MovieClip;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.tooltips.inblocks.data.AdvancedKeyBlockVO;
   
   public class AdvancedKeyBlock extends ImageTextBlockInBlocks
   {
       
      
      public var animation:MovieClip = null;
      
      private var _advancedData:AdvancedKeyBlockVO = null;
      
      public function AdvancedKeyBlock()
      {
         super();
      }
      
      override public function setBlockData(param1:Object) : void
      {
         super.setBlockData(param1);
         this._advancedData = AdvancedKeyBlockVO(getData());
      }
      
      override protected function getBlockVO(param1:Object) : DAAPIDataClass
      {
         return new AdvancedKeyBlockVO(param1);
      }
      
      override protected function onDispose() : void
      {
         this._advancedData = null;
         this.animation = null;
         super.onDispose();
      }
      
      override protected function applyData() : void
      {
         super.applyData();
         if(this._advancedData.animated)
         {
            this.animation.visible = true;
            this.animation.play();
         }
         else
         {
            this.animation.visible = false;
            this.animation.stop();
         }
      }
   }
}
