package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.text.TextField;
   import net.wg.gui.components.advanced.interfaces.IProgressBarAnim;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationBonusDeltaVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class CustomizationBonusDelta extends UIComponentEx implements IUpdatableComponent
   {
       
      
      public var titleTF:TextField = null;
      
      public var valueTF:TextField = null;
      
      public var statusBar:IProgressBarAnim = null;
      
      private var _data:CustomizationBonusDeltaVO = null;
      
      public function CustomizationBonusDelta()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.titleTF.htmlText = this._data.title;
            this.valueTF.htmlText = this._data.valueStr;
         }
      }
      
      override protected function onDispose() : void
      {
         this.statusBar.dispose();
         this.statusBar = null;
         this.titleTF = null;
         this.valueTF = null;
         this._data = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != null)
         {
            this._data = CustomizationBonusDeltaVO(param1);
            this.statusBar.setData(this._data.statusBarData);
            invalidateData();
         }
      }
   }
}
