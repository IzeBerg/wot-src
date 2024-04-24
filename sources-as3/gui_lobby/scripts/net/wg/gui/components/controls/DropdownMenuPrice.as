package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Constraints;
   
   public class DropdownMenuPrice extends DropdownMenu
   {
      
      public static const ACTION_FIELD:String = "actionPrice";
      
      private static const ENABLE_ALPHA:Number = 1;
      
      private static const DISABLE_ALPHA:Number = 0.5;
      
      private static const IMG_HTML_TAG_REG_EXP:RegExp = new RegExp(/<IMG[ ]+SRC=/ig);
       
      
      public var action:Sprite = null;
      
      public var textFieldAction:TextField = null;
      
      public var textFieldWithoutIco:TextField = null;
      
      private var _isLabelHasIco:Boolean = false;
      
      public function DropdownMenuPrice()
      {
         super();
         this.action.visible = false;
         this.textFieldAction.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.action = null;
         this.textFieldAction = null;
         this.textFieldWithoutIco = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SELECTED_INDEX))
         {
            this.hitTestAndShowTooltip();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(!constraintsDisabled)
         {
            constraints.addElement("textFieldAction",this.textFieldAction,Constraints.ALL);
            constraints.addElement("textFieldWithoutIco",this.textFieldWithoutIco,Constraints.ALL);
         }
      }
      
      override protected function populateText(param1:Object) : void
      {
         if(param1.hasOwnProperty(ACTION_FIELD))
         {
            this.action.visible = param1[ACTION_FIELD] != null;
         }
         else
         {
            this.action.visible = false;
         }
         this.updateTextVisibility();
         super.populateText(param1);
      }
      
      override public function set label(param1:String) : void
      {
         this._isLabelHasIco = param1.search(IMG_HTML_TAG_REG_EXP) > -1;
         super.label = param1;
      }
      
      private function updateTextVisibility() : void
      {
         this.textFieldAction.visible = this.action.visible;
         textField.visible = this._isLabelHasIco && !this.action.visible;
         this.textFieldWithoutIco.visible = !this._isLabelHasIco && !this.action.visible;
      }
      
      override protected function updateText() : void
      {
         this.updateTextVisibility();
         if(_label != null)
         {
            this.textFieldAction.htmlText = _label;
            this.textFieldWithoutIco.htmlText = _label;
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
            constraints.updateElement("textFieldWithoutIco",this.textFieldWithoutIco);
         }
         super.updateAfterStateChange();
         textField.alpha = this.textFieldAction.alpha = this.textFieldWithoutIco.alpha = !!this.enabled ? Number(ENABLE_ALPHA) : Number(DISABLE_ALPHA);
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         this.showTooltip(false);
         super.handleMouseRollOver(param1);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         this.hideTooltip();
         super.handleMouseRollOut(param1);
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         this.hideTooltip();
         super.handleMousePress(param1);
      }
      
      protected function showTooltip(param1:Boolean) : void
      {
         var _loc3_:ActionPriceVO = null;
         if(_dataProvider == null)
         {
            return;
         }
         var _loc2_:Object = _dataProvider.requestItemAt(_selectedIndex);
         if(_loc2_ && _loc2_.hasOwnProperty(ACTION_FIELD))
         {
            _loc3_ = _loc2_[ACTION_FIELD];
            if(_loc3_)
            {
               App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_PRICE,null,_loc3_.type,_loc3_.key,_loc3_.newPrices,_loc3_.oldPrices,_loc3_.isBuying,_loc3_.forCredits,_loc3_.rentPackage);
            }
            else if(param1)
            {
               this.hideTooltip();
            }
         }
      }
      
      private function hitTestAndShowTooltip() : void
      {
         if(this.hitTestPoint(App.stage.mouseX,App.stage.mouseY,true))
         {
            this.showTooltip(true);
         }
      }
      
      protected function hideTooltip() : void
      {
         App.toolTipMgr.hide();
      }
   }
}
