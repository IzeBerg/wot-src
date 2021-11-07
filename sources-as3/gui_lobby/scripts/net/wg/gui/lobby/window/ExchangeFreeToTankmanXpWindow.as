package net.wg.gui.lobby.window
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.IconsTypes;
   import net.wg.data.constants.generated.ACTION_PRICE_CONSTANTS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.SkillsItemRenderer;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.gui.components.controls.ActionPriceBg;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.NumericStepper;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.components.controls.WalletResourcesStatus;
   import net.wg.infrastructure.base.meta.IExchangeFreeToTankmanXpWindowMeta;
   import net.wg.infrastructure.base.meta.impl.ExchangeFreeToTankmanXpWindowMeta;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.utils.Padding;
   
   public class ExchangeFreeToTankmanXpWindow extends ExchangeFreeToTankmanXpWindowMeta implements IExchangeFreeToTankmanXpWindowMeta
   {
      
      private static const INIT_DATA_INVALID:String = "initDataInv";
      
      private static const SELECTED_VALUE_INVALID:String = "selValInvalid";
      
      private static const RECALC_VALUE_INVALID:String = "recalcValueInvalid";
      
      private static const WALLET_STATE_INVALID:String = "walletStateInvalid";
      
      private static const WARNING_INVALID:String = "warningInvalid";
      
      private static const MOVINGCONTAINER_NAME:String = "movingContainer";
      
      private static const CHANGE_ROLE_OFFSET:int = -55;
      
      private static const WINDOW_RIGHT_ADDITIONAL_PADDING:int = 4;
       
      
      public var nsLevel:NumericStepper;
      
      public var form_bg:MovieClip;
      
      public var itToPay:IconText;
      
      public var actionPrice:ActionPrice;
      
      public var walletStatus:WalletResourcesStatus;
      
      public var background:Sprite;
      
      public var warningMc:ExchangeFreeToTankmanXpWarning;
      
      public var submitBtn:SoundButtonEx;
      
      public var cancelBtn:SoundButtonEx;
      
      public var skillAfter:SkillsItemRenderer;
      
      public var skillBefore:SkillsItemRenderer;
      
      public var afterTeachingHeader:TextField;
      
      public var percentTF:TextField;
      
      public var blockMc:MovieClip;
      
      public var changeRoleDiscountIcon:ActionPriceBg;
      
      private var _initData:ExchangeFreeToTankmanInitVO;
      
      private var _selectedValue:uint;
      
      private var _originalWindowHeight:Number = NaN;
      
      private var _expandedWindowHeight:Number = NaN;
      
      private var _alertWalletVisible:Boolean = false;
      
      private var _price:Number = 0;
      
      private var _actionPriceVo:ActionPriceVO;
      
      private var _useDiscount:Boolean;
      
      private var _initMax:Boolean = false;
      
      public function ExchangeFreeToTankmanXpWindow()
      {
         super();
         showWindowBgForm = false;
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         var _loc2_:Padding = null;
         super.setWindow(param1);
         if(param1)
         {
            window.title = MENU.TEACHINGSKILL_TITLE;
            _loc2_ = window.contentPadding as Padding;
            App.utils.asserter.assertNotNull(_loc2_,"padding" + Errors.CANT_NULL);
            _loc2_.right -= WINDOW_RIGHT_ADDITIONAL_PADDING;
            window.contentPadding = _loc2_;
            addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler,false,0,true);
         }
      }
      
      override protected function setInitData(param1:ExchangeFreeToTankmanInitVO) : void
      {
         this._initData = param1;
         invalidate(INIT_DATA_INVALID);
      }
      
      override protected function setCalcValueResponse(param1:Number, param2:ActionPriceVO) : void
      {
         this._price = param1;
         if(param2)
         {
            this._actionPriceVo = param2;
            this._useDiscount = this._actionPriceVo.useAction;
            this._actionPriceVo.ico = IconsTypes.FREE_XP;
         }
         invalidate(RECALC_VALUE_INVALID);
      }
      
      public function as_setWalletStatus(param1:Object) : void
      {
         App.utils.voMgr.walletStatusVO.update(param1);
         this.updateWalletStatus();
      }
      
      override protected function preInitialize() : void
      {
         super.preInitialize();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.onSubmitBtnClickHandler,false,0,true);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler,false,0,true);
         this.nsLevel.addEventListener(IndexEvent.INDEX_CHANGE,this.onNsLevelIndexChangeHandler,false,0,true);
         this.changeRoleDiscountIcon.state = ACTION_PRICE_CONSTANTS.STATE_ALIGN_TOP;
         this.changeRoleDiscountIcon.visible = false;
         this.changeRoleDiscountIcon.addEventListener(MouseEvent.ROLL_OVER,this.onChangeRoleDiscountIconOverHandler);
         this.changeRoleDiscountIcon.addEventListener(MouseEvent.ROLL_OUT,this.onChangeRoleDiscountIconOutHandler);
         try
         {
            this.warningMc.textField.text = App.utils.locale.makeString(MENU.TEACHINGSKILL_FREEXPISTIGHT);
         }
         catch(e:Error)
         {
         }
         this.warningMc.visible = false;
         this.blockMc.visible = false;
         var _loc1_:int = getChildIndex(this.background) + 1;
         var _loc2_:Sprite = new Sprite();
         _loc2_.name = MOVINGCONTAINER_NAME;
         addChildAt(_loc2_,_loc1_);
         _loc2_.addChild(this.afterTeachingHeader);
         _loc2_.addChild(this.skillAfter);
         _loc2_.addChild(this.submitBtn);
         _loc2_.addChild(this.cancelBtn);
         constraints.addElement(this.background.name,this.background,Constraints.ALL);
         constraints.addElement(this.form_bg.name,this.form_bg,Constraints.ALL);
         constraints.addElement(MOVINGCONTAINER_NAME,_loc2_,Constraints.BOTTOM);
         this.percentTF.text = COMMON.COMMON_PERCENT;
         this.actionPrice.iconPosition = ActionPrice.RIGHT_LBL;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(this._initData)
         {
            if(isInvalid(INIT_DATA_INVALID))
            {
               this.nsLevel.minimum = this._initData.lastSkillLevel;
               this.nsLevel.maximum = this._initData.nextSkillLevel;
               if(!this._initMax)
               {
                  this.nsLevel.value = this.nsLevel.maximum;
                  this._initMax = true;
               }
               else if(this.nsLevel.value >= this.nsLevel.maximum)
               {
                  this.nsLevel.value = this.nsLevel.maximum;
               }
               this.nsLevel.enabled = this.isWalletNotVisibleAndSkillLevelChanged();
               this.skillBefore.setData(this._initData.beforeSkill);
               this.skillAfter.setData(this._initData.afterSkill);
               this._selectedValue = this.nsLevel.value;
               invalidate(SELECTED_VALUE_INVALID);
               invalidate(WARNING_INVALID);
            }
            if(isInvalid(SELECTED_VALUE_INVALID))
            {
               calcValueRequestS(this._selectedValue);
            }
         }
         if(isInvalid(WARNING_INVALID) && !isNaN(this._originalWindowHeight))
         {
            _loc1_ = !this.nsLevel.enabled && !this._alertWalletVisible;
            if(_loc1_ != this.warningMc.visible)
            {
               this.warningMc.visible = _loc1_;
               if(_loc1_)
               {
                  window.height = this._expandedWindowHeight;
               }
               else
               {
                  window.height = this._originalWindowHeight;
               }
            }
         }
         if(isInvalid(WALLET_STATE_INVALID))
         {
            if(!this._alertWalletVisible && this._initData)
            {
               this.nsLevel.enabled = this.isSkillLevelChanged();
            }
            else
            {
               this.nsLevel.enabled = false;
            }
            invalidate(WARNING_INVALID);
         }
         if(isInvalid(RECALC_VALUE_INVALID))
         {
            if(this._initData)
            {
               this.nsLevel.enabled = this.isWalletNotVisibleAndSkillLevelChanged();
            }
            else
            {
               this.nsLevel.enabled = !this._alertWalletVisible;
            }
            if(!this._alertWalletVisible)
            {
               this.actionPrice.setData(this._actionPriceVo);
               this.itToPay.visible = !this.actionPrice.visible;
               this.itToPay.text = App.utils.locale.integer(this._price);
               this.changeRoleDiscountIcon.x = CHANGE_ROLE_OFFSET + this.itToPay.x + this.itToPay.width;
               this.changeRoleDiscountIcon.visible = this._useDiscount;
               this.submitBtn.enabled = this._price > 0;
               this._initData.afterSkill.level = this._selectedValue;
               this.skillAfter.data = this._initData.afterSkill;
            }
            else
            {
               this.actionPrice.visible = false;
               this.itToPay.visible = false;
               this.submitBtn.enabled = false;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.changeRoleDiscountIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onChangeRoleDiscountIconOverHandler);
         this.changeRoleDiscountIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onChangeRoleDiscountIconOutHandler);
         this.changeRoleDiscountIcon = null;
         this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.onSubmitBtnClickHandler);
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         this.form_bg = null;
         this.background = null;
         this.blockMc = null;
         this.warningMc = null;
         this.afterTeachingHeader = null;
         this.itToPay.dispose();
         this.itToPay = null;
         this.actionPrice.dispose();
         this.actionPrice = null;
         this.submitBtn.dispose();
         this.submitBtn = null;
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.nsLevel.dispose();
         this.nsLevel = null;
         this.skillAfter.dispose();
         this.skillAfter = null;
         this.skillBefore.dispose();
         this.skillBefore = null;
         if(this.walletStatus)
         {
            this.walletStatus.dispose();
            this.walletStatus = null;
         }
         this._initData = null;
         this._actionPriceVo = null;
         super.onDispose();
      }
      
      private function updateWalletStatus() : void
      {
         if(App.utils)
         {
            this._alertWalletVisible = this.walletStatus.updateStatus(App.utils.voMgr.walletStatusVO.freeXpStatus);
            invalidate(WALLET_STATE_INVALID,RECALC_VALUE_INVALID);
         }
      }
      
      private function onNsLevelIndexChangeHandler(param1:IndexEvent) : void
      {
         this._selectedValue = this.nsLevel.value;
         invalidate(SELECTED_VALUE_INVALID);
      }
      
      private function onEnterFrameHandler(param1:Event) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         this._originalWindowHeight = window.height;
         this._expandedWindowHeight = this._originalWindowHeight + this.warningMc.height - 30;
         invalidate(WARNING_INVALID);
      }
      
      private function onSubmitBtnClickHandler(param1:ButtonEvent) : void
      {
         applyS();
      }
      
      private function onCancelBtnClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
      
      private function isWalletNotVisibleAndSkillLevelChanged() : Boolean
      {
         return !this._alertWalletVisible && this.isSkillLevelChanged();
      }
      
      private function isSkillLevelChanged() : Boolean
      {
         return this._initData.lastSkillLevel != this._initData.nextSkillLevel;
      }
      
      private function onChangeRoleDiscountIconOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_XP,null,this._actionPriceVo.newPrices,this._actionPriceVo.oldPrices);
      }
      
      private function onChangeRoleDiscountIconOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
