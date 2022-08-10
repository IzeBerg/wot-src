package net.wg.gui.components.tooltips.inblocks.data
{
   public class RendererTextBlockVO extends SpriteTextBlockVO
   {
      
      private static const VAL_DATA:String = "rendererData";
       
      
      private var _rendererData:RendererDataVO;
      
      public function RendererTextBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == VAL_DATA)
         {
            this._rendererData = new RendererDataVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._rendererData.dispose();
         this._rendererData = null;
         super.onDispose();
      }
      
      public function get rendererData() : RendererDataVO
      {
         return this._rendererData;
      }
   }
}
