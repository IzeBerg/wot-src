package net.wg.gui.lobby.vehicleCustomization.controls
{
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.controls.BlackButton;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationBillButtonVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationButtonEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class CustomizationBillLineButton extends UIComponentEx implements IUpdatable
   {
      
      private static const BTN_ALPHA:Number = 0.6;
      
      private static const BTN_ICON_OFFSET:Number = 3;
       
      
      public var button:BlackButton = null;
      
      private var _data:CustomizationBillButtonVO = null;
      
      public function CustomizationBillLineButton()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.button.backgroundAlpha = BTN_ALPHA;
         this.button.iconOffsetText = BTN_ICON_OFFSET;
         this.button.soundType = SoundTypes.CUSTOMIZATION_DEFAULT;
         this.button.focusable = false;
         this.button.addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.button.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this.button.dispose();
         this.button = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.button.label = this._data.label;
            this.button.iconSource = this._data.icon;
            this.button.enabled = this._data.enabled;
         }
      }
      
      public function update(param1:Object) : void
      {
         this._data = param1 as CustomizationBillButtonVO;
         invalidateData();
      }
      
      private function onButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CustomizationButtonEvent(CustomizationButtonEvent.BUTTON_PRESSED,this._data.event,true));
      }
   }
}
