package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.CUSTOMIZATION_ALIASES;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSlotIdVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSlotUpdateVO;
   import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselRendererVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
   
   public class CustomizationEndPointIcon extends SoundButtonEx implements ICustomizationEndPointIcon
   {
      
      private static const NONE:uint = 0;
      
      private static const POSITION_CHANGING_FLAG:uint = 1;
      
      private static const ALPHA_CHANGING_FLAG:uint = 2;
      
      private static const SCALE_CHANGING_FLAG:uint = 4;
      
      private static const ALL:uint = POSITION_CHANGING_FLAG + ALPHA_CHANGING_FLAG + SCALE_CHANGING_FLAG;
       
      
      public var uid:uint = 1.0;
      
      public var uiActionFlags:uint = 7.0;
      
      public var slotData:CustomizationSlotUpdateVO = null;
      
      protected var _currentState:int = 0;
      
      public function CustomizationEndPointIcon()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.removeHitArea();
      }
      
      override protected function onDispose() : void
      {
         this.slotData = null;
         super.onDispose();
      }
      
      public function applyState(param1:int, param2:Boolean = true) : void
      {
      }
      
      public function getLocked() : Boolean
      {
         return this._currentState == CUSTOMIZATION_ALIASES.ANCHOR_STATE_LOCKED;
      }
      
      public function getSupportedType() : int
      {
         return 0;
      }
      
      public function installItem(param1:CustomizationCarouselRendererVO) : void
      {
         this.onInstallItemDropHandler();
         dispatchEvent(new CustomizationItemEvent(CustomizationItemEvent.INSTALL_ITEM,param1.intCD));
      }
      
      public function isAnchorFilled() : Boolean
      {
         return this.slotData != null && this.slotData.itemIntCD > 0;
      }
      
      public function onDragEnd() : void
      {
      }
      
      public function onDragStart() : void
      {
      }
      
      public function onDragTargetChange(param1:Boolean) : void
      {
      }
      
      public function onMagneticReset() : void
      {
      }
      
      public function playZoomIn() : void
      {
      }
      
      public function playZoomOut() : void
      {
      }
      
      public function setIsDecalAnchor(param1:Boolean) : void
      {
      }
      
      public function setSlotData(param1:CustomizationSlotUpdateVO) : void
      {
         this.slotData = param1;
         this.uid = param1.uid;
      }
      
      protected final function deactivateAll() : void
      {
         this.uiActionFlags = NONE;
      }
      
      protected final function deactivateAlpha() : void
      {
         this.uiActionFlags = POSITION_CHANGING_FLAG + SCALE_CHANGING_FLAG;
      }
      
      protected final function activateAll() : void
      {
         this.uiActionFlags = ALL;
      }
      
      protected function onInstallItemDropHandler() : void
      {
      }
      
      private function removeHitArea() : void
      {
         var _loc1_:Sprite = new Sprite();
         addChild(_loc1_);
         hitArea = _loc1_;
      }
      
      public function get id() : CustomizationSlotIdVO
      {
         return this.slotData != null && this.slotData.slotId != null ? this.slotData.slotId : null;
      }
   }
}
