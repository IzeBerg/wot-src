package net.wg.gui.lobby.header.headerButtonBar
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.lobby.header.vo.HBC_PremDataVo;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.utils.ICommons;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.TextFieldEx;
   
   public class HBC_Prem extends HBC_ActionItem implements IStageSizeDependComponent
   {
      
      private static const TEXTS_GAP:int = -6;
      
      private static const PREM_OFFSET_X:int = 52;
      
      private static const SUBSCRIPTION_OFFSET_Y:int = 7;
      
      private static const MAX_FONT_SIZE:int = 14;
      
      private static const MIN_SCREEN_PADDING:int = 15;
      
      private static const ADDITIONAL_SCREEN_PADDING:int = 3;
       
      
      public var textField:TextField = null;
      
      public var premTime:TextField = null;
      
      public var infinityIcon:Sprite = null;
      
      public var premIcon:IImage = null;
      
      private var _premVo:HBC_PremDataVo = null;
      
      private var _commons:ICommons;
      
      private var _useCompactData:Boolean = false;
      
      public function HBC_Prem()
      {
         this._commons = App.utils.commons;
         super();
         minScreenPadding.left = MIN_SCREEN_PADDING;
         minScreenPadding.right = MIN_SCREEN_PADDING;
         additionalScreenPadding.left = ADDITIONAL_SCREEN_PADDING;
         additionalScreenPadding.right = ADDITIONAL_SCREEN_PADDING;
         maxFontSize = MAX_FONT_SIZE;
         App.stageSizeMgr.register(this);
         TextFieldEx.setVerticalAlign(this.premTime,TextFieldEx.VALIGN_CENTER);
      }
      
      override protected function onDispose() : void
      {
         App.stageSizeMgr.unregister(this);
         this._premVo = null;
         this.textField = null;
         this.premTime = null;
         this.infinityIcon = null;
         this.premIcon = null;
         this._commons = null;
         super.onDispose();
      }
      
      override protected function updateSize() : void
      {
         bounds.width = Math.max(this.textField.width,doItTextField.width) ^ 0;
         if(this._premVo.isPremium)
         {
            bounds.width += PREM_OFFSET_X;
         }
         super.updateSize();
      }
      
      override protected function updateData() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         if(data)
         {
            _loc1_ = StringUtils.isNotEmpty(this._premVo.doLabel);
            doItTextField.visible = _loc1_;
            if(_loc1_)
            {
               doItTextField.htmlText = this._premVo.doLabel;
            }
            this.textField.multiline = this.textField.wordWrap = !_loc1_;
            if(this._useCompactData)
            {
               this.textField.htmlText = this._premVo.btnLabelShort;
            }
            else
            {
               this.textField.htmlText = this._premVo.btnLabel;
            }
            this.premIcon.visible = this._premVo.isPremium;
            this.infinityIcon.visible = this._premVo.isSubscription;
            this.premTime.htmlText = this._premVo.timeLabel;
            if(this.premIcon.visible)
            {
               this.premIcon.source = this._premVo.premiumIcon;
            }
            if(this.isNeedUpdateFont())
            {
               updateFontSize(this.textField,useFontSize);
            }
            this._commons.updateTextFieldSize(this.textField,true,true);
         }
         super.updateData();
         if(this.isNeedUpdateFont())
         {
            updateFontSize(doItTextField,useFontSize);
            this._commons.updateTextFieldSize(doItTextField,true,false);
            needUpdateFontSize = false;
         }
         if(_loc1_)
         {
            _loc2_ = this.textField.height + doItTextField.height + TEXTS_GAP;
            this.textField.y = height - _loc2_ >> 1;
            doItTextField.y = this.textField.y + this.textField.height + TEXTS_GAP | 0;
         }
         else
         {
            this.textField.y = SUBSCRIPTION_OFFSET_Y;
         }
         if(this._premVo.isPremium)
         {
            this.textField.x = PREM_OFFSET_X;
            doItTextField.x = PREM_OFFSET_X;
         }
         else
         {
            this.textField.x = 0;
            doItTextField.x = 0;
         }
      }
      
      override protected function isDiscountEnabled() : Boolean
      {
         return this._premVo.isHasAction;
      }
      
      override protected function isNeedUpdateFont() : Boolean
      {
         return super.isNeedUpdateFont() || useFontSize != this.textField.getTextFormat().size || useFontSize != doItTextField.getTextFormat().size;
      }
      
      override protected function needForsTextStyle() : Boolean
      {
         return true;
      }
      
      override public function set data(param1:Object) : void
      {
         this._premVo = HBC_PremDataVo(param1);
         super.data = param1;
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = param1 < StageSizeBoundaries.WIDTH_1600;
         if(this._useCompactData != _loc3_)
         {
            this._useCompactData = _loc3_;
            invalidateData();
         }
      }
   }
}
