package net.wg.gui.lobby.vehicleCustomization.tooltips.inblocks.blocks
{
   import net.wg.gui.components.tooltips.inblocks.blocks.TextParameterWithIconBlock;
   import net.wg.gui.components.tooltips.inblocks.data.CustomizationItemPropertyVO;
   import net.wg.gui.lobby.vehicleCustomization.CustomizationItemPropertyRenderer;
   
   public class CustomizationItemPropertyBlock extends TextParameterWithIconBlock
   {
      
      private static const MAX_HEIGHT:uint = 23;
      
      private static const MIN_LINES:uint = 2;
       
      
      private var _customizationItemPropertyRenderer:CustomizationItemPropertyRenderer = null;
      
      public function CustomizationItemPropertyBlock()
      {
         super();
         this._customizationItemPropertyRenderer = iconText as CustomizationItemPropertyRenderer;
      }
      
      override protected function onDispose() : void
      {
         this._customizationItemPropertyRenderer = null;
         super.onDispose();
      }
      
      override protected function getDataClass() : Class
      {
         return CustomizationItemPropertyVO;
      }
      
      override protected function applyParamName() : void
      {
         super.applyParamName();
         var _loc1_:CustomizationItemPropertyVO = CustomizationItemPropertyVO(_data);
         this._customizationItemPropertyRenderer.isTextIcon = _loc1_.isTextIcon;
         this._customizationItemPropertyRenderer.isWideOffset = _loc1_.isWideOffset;
      }
      
      override public function get height() : Number
      {
         if(this._customizationItemPropertyRenderer.numLines < MIN_LINES)
         {
            return MAX_HEIGHT;
         }
         return super.height;
      }
   }
}
