package net.wg.gui.lobby.header.headerButtonBar
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.IconsTypes;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   import net.wg.gui.components.assets.interfaces.INewIndicator;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.WalletResourcesStatus;
   import net.wg.gui.lobby.header.LobbyHeader;
   import net.wg.gui.lobby.header.vo.HBC_FinanceVo;
   import net.wg.infrastructure.interfaces.ITweenAnimatorHandler;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.IWalletStatusVO;
   
   public class HBC_Finance extends HBC_ActionItem implements ITweenAnimatorHandler
   {
      
      private static const MIN_SCREEN_PADDING:int = 10;
      
      private static const NARROW_FONT_SIZE:int = 12;
      
      private static const MAX_FONT_SIZE:int = 14;
      
      private static const NEW_INDICATOR_X:Number = -10;
      
      private static const MAX_SCREEN_PRC_BORDER:Number = 0.14;
      
      private static const RIGHT_PADDING:int = -7;
      
      private static const LEFT_PADDING:int = 1;
      
      private static const SHORT_ICON_PADDING:int = -4;
      
      private static const WALLET_TOP_Y:int = 1;
      
      private static const WALLET_CENTER_Y:int = 8;
      
      private static const MONEY_TOP_Y:int = 9;
      
      private static const MONEY_CENTER_Y:int = 16;
       
      
      public var moneyIconText:IconText = null;
      
      public var wallet:WalletResourcesStatus = null;
      
      public var discountAnimation:MovieClip = null;
      
      private var _newIndicatorIsInited:Boolean = false;
      
      private var _newIndicator:INewIndicator = null;
      
      private var _financeVo:HBC_FinanceVo = null;
      
      public function HBC_Finance()
      {
         super();
         minScreenPadding.left = MIN_SCREEN_PADDING;
         minScreenPadding.right = MIN_SCREEN_PADDING;
         additionalScreenPadding.left = 0;
         additionalScreenPadding.right = 0;
         maxFontSize = MAX_FONT_SIZE;
         narrowFontSize = NARROW_FONT_SIZE;
         this.moneyIconText.textAlign = TextFormatAlign.LEFT;
      }
      
      override public function updateButtonBounds(param1:Rectangle) : void
      {
         if(this.discountAnimation != null)
         {
            this.discountAnimation.x = param1.x + (param1.width >> 1);
            this.discountAnimation.y = param1.height;
         }
         super.updateButtonBounds(param1);
      }
      
      override protected function updateSize() : void
      {
         updateFontSize(this.moneyIconText.textField,useFontSize);
         var _loc1_:IUIComponentEx = !!this.moneyIconText.visible ? this.moneyIconText : this.wallet;
         var _loc2_:Number = doItTextField.textWidth;
         var _loc3_:Number = _loc1_.actualWidth;
         var _loc4_:Number = Math.max(_loc3_,_loc2_) + RIGHT_PADDING;
         _loc1_.x = (_loc4_ - _loc3_ >> 1) + LEFT_PADDING;
         bounds.width = _loc4_;
         var _loc5_:Boolean = _loc2_ > 0;
         doItTextField.x = _loc4_ - _loc2_ >> 1;
         this.moneyIconText.y = !!_loc5_ ? Number(MONEY_TOP_Y) : Number(MONEY_CENTER_Y);
         this.wallet.y = !!_loc5_ ? Number(WALLET_TOP_Y) : Number(WALLET_CENTER_Y);
         super.updateSize();
      }
      
      override protected function updateData() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:IWalletStatusVO = null;
         if(this._financeVo)
         {
            _loc1_ = maxScreenPrc < MAX_SCREEN_PRC_BORDER;
            this.moneyIconText.xCorrect = !!_loc1_ ? Number(SHORT_ICON_PADDING) : Number(0);
            this.moneyIconText.icon = this._financeVo.icon;
            this.moneyIconText.text = this._financeVo.money;
            this.moneyIconText.textSize = useFontSize;
            this.moneyIconText.textFieldYOffset = screen == LobbyHeader.MAX_SCREEN ? Number(-1) : Number(0);
            this.moneyIconText.validateNow();
            this.wallet.icoType = this._financeVo.icon;
            _loc2_ = App.utils.voMgr.walletStatusVO;
            switch(this._financeVo.icon)
            {
               case CURRENCIES_CONSTANTS.FREE_XP:
                  this.moneyIconText.visible = !this.wallet.updateStatus(_loc2_.freeXpStatus);
                  this.moneyIconText.icon = IconsTypes.FREE_XP;
                  break;
               case CURRENCIES_CONSTANTS.GOLD:
                  this.moneyIconText.visible = !this.wallet.updateStatus(_loc2_.goldStatus);
                  break;
               case CURRENCIES_CONSTANTS.CREDITS:
                  this.moneyIconText.visible = !this.wallet.updateStatus(_loc2_.creditsStatus);
                  break;
               case CURRENCIES_CONSTANTS.CRYSTAL:
                  this.moneyIconText.visible = !this.wallet.updateStatus(_loc2_.crystalStatus);
                  break;
               default:
                  this.wallet.visible = false;
            }
            doItTextField.text = this._financeVo.btnDoText;
            if(this._financeVo.isNew || this._newIndicatorIsInited)
            {
               if(!this._newIndicatorIsInited)
               {
                  this._newIndicator = App.utils.classFactory.getComponent(Linkages.NEW_INDICATOR_LINKAGE,INewIndicator);
                  addChildAt(DisplayObject(this._newIndicator),getChildIndex(this.moneyIconText));
                  this._newIndicator.x = NEW_INDICATOR_X;
                  this._newIndicatorIsInited = true;
               }
               this._newIndicator.visible = this._financeVo.isNew;
            }
         }
         super.updateData();
         this.updateDiscountAnimationState();
         if(this._financeVo)
         {
            this._financeVo.playDiscountAnimation = false;
         }
      }
      
      override protected function isDiscountEnabled() : Boolean
      {
         return this._financeVo.isDiscountEnabled || this._financeVo.isHasAction;
      }
      
      override protected function onDispose() : void
      {
         this._financeVo = null;
         this.moneyIconText.dispose();
         this.moneyIconText = null;
         this.wallet.dispose();
         this.wallet = null;
         if(this._newIndicatorIsInited)
         {
            this._newIndicator.dispose();
            this._newIndicator = null;
         }
         if(this.discountAnimation != null && contains(this.discountAnimation))
         {
            removeChild(this.discountAnimation);
         }
         this.discountAnimation = null;
         super.onDispose();
      }
      
      override protected function isNeedUpdateFont() : Boolean
      {
         return super.isNeedUpdateFont() || useFontSize != doItTextField.getTextFormat().size;
      }
      
      public function onComplete() : void
      {
         if(this.discountAnimation != null)
         {
            if(contains(this.discountAnimation))
            {
               removeChild(this.discountAnimation);
            }
            this.discountAnimation = null;
         }
      }
      
      private function updateDiscountAnimationState() : void
      {
         if(this._financeVo.playDiscountAnimation)
         {
            if(this.discountAnimation == null)
            {
               this.discountAnimation = App.utils.classFactory.getComponent(Linkages.GOLD_FISH_BUTTON_ANIMATION,MovieClip);
            }
            if(this.discountAnimation != null)
            {
               if(!contains(this.discountAnimation))
               {
                  addChildAt(this.discountAnimation,0);
               }
               this.discountAnimation.visible = false;
               this.discountAnimation.gotoAndStop(1);
               this.discountAnimation.addFrameScript(this.discountAnimation.totalFrames - 1,this.onDiscountAnimationFinished);
            }
         }
         else
         {
            if(this.discountAnimation != null && contains(this.discountAnimation))
            {
               removeChild(this.discountAnimation);
            }
            this.discountAnimation = null;
         }
         if(this.discountAnimation != null)
         {
            if(this._financeVo.isDiscountEnabled && this._financeVo.playDiscountAnimation)
            {
               this.discountAnimation.gotoAndPlay(1);
               if(buttonActionContent != null)
               {
                  buttonActionContent.setEnabled(false);
               }
            }
            else
            {
               this.discountAnimation.stop();
            }
            this.discountAnimation.visible = this._financeVo.isDiscountEnabled && this._financeVo.playDiscountAnimation;
         }
      }
      
      private function onDiscountAnimationFinished() : void
      {
         if(this.discountAnimation != null)
         {
            this.discountAnimation.stop();
            if(contains(this.discountAnimation))
            {
               removeChild(this.discountAnimation);
            }
            this.discountAnimation = null;
         }
         if(buttonActionContent != null)
         {
            buttonActionContent.setEnabled(true);
         }
      }
      
      override public function set data(param1:Object) : void
      {
         this._financeVo = HBC_FinanceVo(param1);
         super.data = param1;
      }
      
      override protected function get leftPadding() : Number
      {
         var _loc1_:Number = 0;
         switch(screen)
         {
            case LobbyHeader.WIDE_SCREEN:
               _loc1_ = wideScreenPrc;
               break;
            case LobbyHeader.MAX_SCREEN:
               _loc1_ = maxScreenPrc;
         }
         return minScreenPadding.left + additionalScreenPadding.left * _loc1_ ^ 0;
      }
      
      override protected function get rightPadding() : Number
      {
         var _loc1_:Number = 0;
         switch(screen)
         {
            case LobbyHeader.WIDE_SCREEN:
               _loc1_ = wideScreenPrc;
               break;
            case LobbyHeader.MAX_SCREEN:
               _loc1_ = maxScreenPrc;
         }
         return minScreenPadding.right + additionalScreenPadding.right * _loc1_ ^ 0;
      }
   }
}
