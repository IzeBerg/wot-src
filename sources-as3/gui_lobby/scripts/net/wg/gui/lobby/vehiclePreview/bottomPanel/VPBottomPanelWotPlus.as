package net.wg.gui.lobby.vehiclePreview.bottomPanel
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.vehiclePreview.data.VPWotPlusPanelData;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewBottomPanelWotPlusMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VPBottomPanelWotPlus extends VehiclePreviewBottomPanelWotPlusMeta implements IVPBottomPanel
   {
       
      
      public var rentBtn:SoundButtonEx = null;
      
      private var _data:VPWotPlusPanelData = null;
      
      public function VPBottomPanelWotPlus()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.rentBtn.changeSizeOnlyUpwards = true;
         this.rentBtn.useHtmlText = true;
         this.rentBtn.addEventListener(ButtonEvent.CLICK,this.onRentBtnClickHandler);
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            this.rentBtn.label = this._data.rentButtonLabel;
            this.rentBtn.enabled = this._data.isRentButtonEnable;
         }
      }
      
      override protected function onDispose() : void
      {
         this.rentBtn.removeEventListener(ButtonEvent.CLICK,this.onRentBtnClickHandler);
         this.rentBtn.dispose();
         this.rentBtn = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         super.onDispose();
      }
      
      override protected function setData(param1:VPWotPlusPanelData) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function getBtn() : SoundButtonEx
      {
         return this.rentBtn;
      }
      
      public function getTotalHeight() : Number
      {
         return this.rentBtn.height;
      }
      
      private function onRentBtnClickHandler(param1:ButtonEvent) : void
      {
         onRentClickS();
      }
   }
}
