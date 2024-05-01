package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Constraints;
   
   public class DropDownListItemRendererPrice extends DropDownListItemRendererSound
   {
      
      public static const ACTION_FIELD:String = "actionPrice";
       
      
      public var action:Sprite = null;
      
      public var textFieldAction:TextField = null;
      
      private var actionPrice:ActionPriceVO = null;
      
      private var _isToolTipsShown:Boolean = false;
      
      public function DropDownListItemRendererPrice()
      {
         super();
         this.action.visible = false;
         this.textFieldAction.visible = false;
      }
      
      override protected function configUI() : void
      {
         if(!constraintsDisabled)
         {
            constraints.addElement("textFieldAction",this.textFieldAction,Constraints.ALL);
         }
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.action = null;
         this.actionPrice = null;
         this.textFieldAction = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA) && _data)
         {
            this.action.visible = this.actionPrice != null;
            this.updateTextVisibility();
         }
         super.draw();
      }
      
      override public function set label(param1:String) : void
      {
         super.label = param1;
      }
      
      private function updateTextVisibility() : void
      {
         this.textFieldAction.visible = this.action.visible;
         textField.visible = !this.action.visible;
      }
      
      override protected function updateText() : void
      {
         this.updateTextVisibility();
         if(_label != null)
         {
            this.textFieldAction.htmlText = _label;
         }
         super.updateText();
      }
      
      override protected function updateAfterStateChange() : void
      {
         if(!initialized)
         {
            return;
         }
         if(constraints != null && !constraintsDisabled && this.textFieldAction != null)
         {
            constraints.updateElement("textFieldAction",this.textFieldAction);
         }
         super.updateAfterStateChange();
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 && param1.hasOwnProperty(ACTION_FIELD))
         {
            this.actionPrice = param1[ACTION_FIELD];
         }
         super.setData(param1);
      }
      
      override protected function hideTooltip() : void
      {
         if(this._isToolTipsShown)
         {
            App.toolTipMgr.hide();
         }
      }
      
      override protected function showTooltip() : void
      {
         if(this.actionPrice)
         {
            this._isToolTipsShown = true;
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_PRICE,null,this.actionPrice.type,this.actionPrice.key,this.actionPrice.newPrices,this.actionPrice.oldPrices,this.actionPrice.isBuying,this.actionPrice.forCredits,this.actionPrice.rentPackage);
         }
      }
   }
}
