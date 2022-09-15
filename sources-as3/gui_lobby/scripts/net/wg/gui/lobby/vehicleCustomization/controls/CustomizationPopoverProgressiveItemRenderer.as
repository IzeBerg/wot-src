package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationPopoverProgressiveItemRendererVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class CustomizationPopoverProgressiveItemRenderer extends CustomizationPopoverEditedItemRenderer
   {
      
      private static const ICON_OFFSET:int = 80;
      
      private static const NAME_X_NORMAL:int = 122;
       
      
      public var progressionLevelIcon:MovieClip;
      
      public var lockedIcon:Image;
      
      private var _dataVO:CustomizationPopoverProgressiveItemRendererVO = null;
      
      public function CustomizationPopoverProgressiveItemRenderer()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         nameTF.x = NAME_X_NORMAL;
         this.lockedIcon.mouseEnabled = this.lockedIcon.mouseChildren = false;
         this.lockedIcon.source = RES_ICONS.MAPS_ICONS_CUSTOMIZATION_LOCK_ICON;
         this.progressionLevelIcon.mouseEnabled = this.progressionLevelIcon.mouseChildren = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._dataVO && isInvalid(InvalidationType.DATA))
         {
            if(this._dataVO.isTitle)
            {
               this.progressionLevelIcon.visible = this.lockedIcon.visible = false;
            }
            else if(this._dataVO.progressionLevel > 0)
            {
               this.progressionLevelIcon.gotoAndStop(this._dataVO.progressionLevel);
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this.lockedIcon.visible)
            {
               countTF.x = this.lockedIcon.x - countTF.width | 0;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.progressionLevelIcon = null;
         this.lockedIcon.dispose();
         this.lockedIcon = null;
         this._dataVO = null;
         super.onDispose();
      }
      
      override public function setData(param1:Object) : void
      {
         this._dataVO = param1 as CustomizationPopoverProgressiveItemRendererVO;
         super.setData(param1);
      }
      
      override protected function updateVisibility(param1:Boolean) : void
      {
         super.updateVisibility(param1);
         param1 = param1 && this._dataVO;
         this.lockedIcon.visible = param1 && this._dataVO.isProgressiveLocked;
         this.progressionLevelIcon.visible = param1 && this._dataVO.progressionLevel > 0;
         inStorageIcon.visible = param1 && !this._dataVO.price && !this._dataVO.isApplied && !this._dataVO.isProgressiveLocked;
         price.visible = param1 && this._dataVO.price && !this._dataVO.isApplied && !this._dataVO.isProgressiveLocked;
      }
      
      override protected function layoutItemIcon() : void
      {
         itemIcon.x = ICON_OFFSET - (itemIcon.width >> 1);
      }
      
      override protected function layoutName(param1:Boolean) : void
      {
         nameTF.visible = !param1;
      }
   }
}
