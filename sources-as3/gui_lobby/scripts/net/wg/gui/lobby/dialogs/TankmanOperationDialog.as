package net.wg.gui.lobby.dialogs
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.Aliases;
   import net.wg.data.Colors;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.IconTextPosition;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.ACTION_PRICE_CONSTANTS;
   import net.wg.data.constants.generated.ICON_TEXT_FRAMES;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
   import net.wg.gui.components.common.InputChecker;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.dialogs.data.TankmanOperationDialogVO;
   import net.wg.gui.lobby.tankman.TankmanSkillsInfoBlock;
   import net.wg.infrastructure.base.meta.ITankmanOperationDialogMeta;
   import net.wg.infrastructure.base.meta.impl.TankmanOperationDialogMeta;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IScheduler;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class TankmanOperationDialog extends TankmanOperationDialogMeta implements ITankmanOperationDialogMeta
   {
      
      private static const AUTO_UPDATE_INTERVAL:int = 3000;
      
      private static const NONE_PROTECTED_MODE_PADDING:int = -6;
      
      private static const NONE_PROTECTED_WARN_MODE_PADDING:int = 18;
      
      private static const PROTECTED_MODE_PADDING:int = 15;
      
      private static const ALERT_IMG_X_OFFSET:int = 8;
      
      private static const ICON_TEXT_X_OFFSET_FOR_FREE:int = 4;
      
      private static const ICON_TEXT_X_OFFSET_NOT_FOR_FREE:int = -15;
       
      
      public var mainBlock:TankmanSkillsInfoBlock;
      
      public var questionTf:TextField;
      
      public var inputChecker:InputChecker;
      
      public var alertImg:Image = null;
      
      public var alertTF:TextField = null;
      
      public var priceIconText:IconText = null;
      
      public var actionPrice:ActionPrice = null;
      
      public var separator:ISeparatorAsset = null;
      
      public var warningTF:TextField = null;
      
      private var _model:TankmanOperationDialogVO = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _isProtectedState:Boolean = true;
      
      private var _scheduler:IScheduler;
      
      public function TankmanOperationDialog()
      {
         this._tooltipMgr = App.toolTipMgr;
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.alertImg.visible = false;
         this.priceIconText.visible = false;
         this.actionPrice.visible = false;
         this.separator.visible = false;
         this.separator.setMode(SeparatorConstants.TILE_MODE);
         this.separator.setCenterAsset(Linkages.SEPARATOR_DOTTED_CENTER);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.mainBlock.setData(this._model.tankmanBlockVO);
            this.inputChecker.visible = this._isProtectedState;
            if(!this._isProtectedState)
            {
               this._scheduler.scheduleOnNextFrame(this.updateFocus,secondBtn);
               this.questionTf.htmlText = this._model.questionText;
            }
            else
            {
               secondBtn.enabled = false;
            }
            this.alertTF.visible = StringUtils.isNotEmpty(this._model.alertText);
            if(this.alertTF.visible)
            {
               this.alertTF.htmlText = this._model.alertText;
               App.utils.commons.updateTextFieldSize(this.alertTF,true,true);
               this.alertTF.addEventListener(MouseEvent.ROLL_OVER,this.onAlertTFRollOverHandler);
               this.alertTF.addEventListener(MouseEvent.ROLL_OUT,this.onAlertTFRollOutHandler);
            }
            if(StringUtils.isNotEmpty(this._model.alertImgSrc))
            {
               this.alertImg.source = this._model.alertImgSrc;
               this.alertImg.addEventListener(MouseEvent.ROLL_OVER,this.onAlertImgRollOverHandler);
               this.alertImg.addEventListener(MouseEvent.ROLL_OUT,this.onAlertImgRollOutHandler);
               this.alertImg.x = textField.x + textField.textWidth + ALERT_IMG_X_OFFSET | 0;
               this.alertImg.visible = true;
            }
            else
            {
               this.alertImg.visible = false;
            }
            this.actionPrice.visible = this._model.actionPriceVO != null;
            this.priceIconText.visible = !this.actionPrice.visible && StringUtils.isNotEmpty(this._model.restoreCurrency) && this._model.restorePrice;
            this.separator.visible = this.actionPrice.visible || this.priceIconText.visible;
            if(this.priceIconText.visible)
            {
               if(StringUtils.isNotEmpty(this._model.restoreCurrency))
               {
                  this.priceIconText.useHtmlText = this._model.restoreCurrency == ICON_TEXT_FRAMES.EMPTY;
                  this.priceIconText.iconPosition = IconTextPosition.RIGHT;
                  this.priceIconText.icon = this._model.restoreCurrency;
               }
               if(!this._model.isEnoughMoneyForRestore)
               {
                  this.priceIconText.textColor = Colors.ERROR_COLOR;
               }
               this.priceIconText.text = this._model.restorePrice;
               this.priceIconText.validateNow();
               _loc1_ = this._model.restoreCurrency == ICON_TEXT_FRAMES.EMPTY ? int(ICON_TEXT_X_OFFSET_FOR_FREE) : int(ICON_TEXT_X_OFFSET_NOT_FOR_FREE);
               this.priceIconText.x = width - this.priceIconText.actualWidth + _loc1_ | 0;
            }
            else if(this.actionPrice.visible)
            {
               this.actionPrice.setup(this);
               this.actionPrice.setData(this._model.actionPriceVO);
               this.actionPrice.state = ACTION_PRICE_CONSTANTS.STATE_ALIGN_TOP;
            }
            else
            {
               this.separator.visible = false;
            }
         }
      }
      
      override protected function setData(param1:TankmanOperationDialogVO) : void
      {
         App.utils.asserter.assertNotNull(param1,"data" + Errors.CANT_NULL);
         this._model = param1;
         this._isProtectedState = this._model.isProtectedState;
         this.warningTF.visible = StringUtils.isNotEmpty(this._model.warningText);
         if(this.warningTF.visible)
         {
            this.warningTF.htmlText = this._model.warningText;
            App.utils.commons.updateTextFieldSize(this.warningTF,false,true);
         }
         invalidateData();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.inputChecker,Aliases.INPUT_CHECKER_COMPONENT);
         this.inputChecker.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onInputCheckerRequestFocusHandler);
         this.inputChecker.defaultInterval = AUTO_UPDATE_INTERVAL;
         this._scheduler.scheduleOnNextFrame(this.updateFocus,this.inputChecker.getComponentForFocus());
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.updateFocus);
         this.alertTF.removeEventListener(MouseEvent.ROLL_OVER,this.onAlertTFRollOverHandler);
         this.alertTF.removeEventListener(MouseEvent.ROLL_OUT,this.onAlertTFRollOutHandler);
         this.alertImg.removeEventListener(MouseEvent.ROLL_OVER,this.onAlertImgRollOverHandler);
         this.alertImg.removeEventListener(MouseEvent.ROLL_OUT,this.onAlertImgRollOutHandler);
         this.inputChecker.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onInputCheckerRequestFocusHandler);
         this.mainBlock.dispose();
         this.mainBlock = null;
         this.alertImg.dispose();
         this.alertImg = null;
         this.alertTF = null;
         this._model = null;
         this._tooltipMgr = null;
         this.questionTf = null;
         this.inputChecker = null;
         this.priceIconText.dispose();
         this.priceIconText = null;
         this.actionPrice.dispose();
         this.actionPrice = null;
         this.separator.dispose();
         this.separator = null;
         this.warningTF = null;
         this._scheduler = null;
         super.onDispose();
      }
      
      override protected function getBackgroundActualHeight() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:TextField = null;
         if(this._isProtectedState)
         {
            _loc1_ = this.inputChecker.y + this.inputChecker.height + PROTECTED_MODE_PADDING;
         }
         else
         {
            _loc2_ = StringUtils.isNotEmpty(this._model.warningText);
            _loc3_ = !!_loc2_ ? this.warningTF : this.questionTf;
            _loc1_ = _loc3_.y + _loc3_.height + NONE_PROTECTED_MODE_PADDING;
            if(_loc2_)
            {
               _loc1_ += NONE_PROTECTED_WARN_MODE_PADDING;
            }
         }
         return _loc1_;
      }
      
      private function showAlertTooltip() : void
      {
         this._tooltipMgr.showComplex(this._model.alertTooltip);
      }
      
      private function hideAlertTooltip() : void
      {
         this._tooltipMgr.hide();
      }
      
      private function updateFocus(param1:UIComponent) : void
      {
         setFocus(param1);
      }
      
      private function onAlertTFRollOverHandler(param1:MouseEvent) : void
      {
         this.showAlertTooltip();
      }
      
      private function onAlertTFRollOutHandler(param1:MouseEvent) : void
      {
         this.hideAlertTooltip();
      }
      
      private function onAlertImgRollOverHandler(param1:MouseEvent) : void
      {
         this.showAlertTooltip();
      }
      
      private function onAlertImgRollOutHandler(param1:MouseEvent) : void
      {
         this.hideAlertTooltip();
      }
      
      private function onInputCheckerRequestFocusHandler(param1:FocusRequestEvent) : void
      {
         if(this.inputChecker.isInvalidUserText)
         {
            secondBtn.enabled = true;
            this._scheduler.scheduleOnNextFrame(this.updateFocus,secondBtn);
         }
         else
         {
            secondBtn.enabled = false;
            setFocus(this.inputChecker.getComponentForFocus());
         }
      }
   }
}
