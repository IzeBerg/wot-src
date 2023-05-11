package net.wg.gui.lobby.window
{
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import net.wg.data.constants.ColorSchemeNames;
   import net.wg.data.constants.IconsTypes;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.gui.components.assets.ArrowSeparator;
   import net.wg.infrastructure.base.meta.impl.ExchangeWindowMeta;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.utils.Padding;
   
   public class ExchangeWindow extends ExchangeWindowMeta
   {
      
      private static const MAX_LIMIT_PRIMARY_CURRENCY:int = 5000000;
       
      
      public var errorLabel:TextField;
      
      public var topSeparator:ArrowSeparator;
      
      public var bottomSeparator:ArrowSeparator;
      
      public function ExchangeWindow()
      {
         super();
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         var _loc2_:Padding = null;
         super.setWindow(param1);
         if(param1)
         {
            window.title = MENU.EXCHANGE_TITLE;
            _loc2_ = new Padding();
            _loc2_.top = 33;
            _loc2_.right = 11;
            _loc2_.bottom = cancelBtn.height + 20;
            _loc2_.left = 10;
            window.formBgPadding = _loc2_;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         _loc1_.blurX = 2;
         _loc1_.blurY = 2;
         _loc1_.strength = 1;
         _loc1_.quality = 2;
         _loc1_.angle = 90;
         _loc1_.distance = 1;
         _loc1_.color = 0;
         this.errorLabel.filters = [_loc1_];
         onHandPrimaryCurrencyText.filters = ExchangeUtils.getGlow(onHandPrimaryCurrencyText.icon);
         onHandSecondaryCurrencyText.filters = ExchangeUtils.getGlow(onHandSecondaryCurrencyText.icon);
         resultPrimaryCurrencyText.filters = ExchangeUtils.getGlow(resultPrimaryCurrencyText.icon);
         resultSecondaryCurrencyText.filters = ExchangeUtils.getGlow(resultSecondaryCurrencyText.icon);
         toExchangePrimaryCurrencyIco.filters = ExchangeUtils.getGlow(toExchangePrimaryCurrencyIco.icon);
         toExchangeSecondaryCurrencyIco.filters = ExchangeUtils.getGlow(toExchangeSecondaryCurrencyIco.icon);
         var _loc2_:Number = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_GOLD);
         headerMC.rateLabel.text = App.utils.locale.makeString(MENU.EXCHANGE_RATE);
         headerMC.rateFrom.icon = IconsTypes.GOLD;
         headerMC.rateFrom.textColor = _loc2_;
         headerMC.rateFrom.filters = ExchangeUtils.getGlow(IconsTypes.GOLD);
         headerMC.rateTo.icon = IconsTypes.CREDITS;
         headerMC.rateTo.textColor = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_CREDITS);
         headerMC.rateTo.filters = ExchangeUtils.getGlow(IconsTypes.CREDITS);
         nsPrimaryCurrency.textColorId = TEXT_MANAGER_STYLES.GOLD_TEXT;
         nsSecondaryCurrency.textColorId = TEXT_MANAGER_STYLES.CREDITS_TEXT;
      }
      
      override protected function onDispose() : void
      {
         this.topSeparator.dispose();
         this.topSeparator = null;
         this.bottomSeparator.dispose();
         this.bottomSeparator = null;
         this.errorLabel = null;
         super.onDispose();
      }
      
      override protected function applyResultUpdating() : void
      {
         super.applyResultUpdating();
         nsPrimaryCurrency.maximum = Math.min(totalPrimaryCurrency,MAX_LIMIT_PRIMARY_CURRENCY);
         nsSecondaryCurrency.maximum = nsPrimaryCurrency.maximum * actualRate;
      }
      
      override protected function applyPrimaryCurrencyChange() : void
      {
         super.applyPrimaryCurrencyChange();
         this.errorLabel.visible = totalPrimaryCurrency <= 0;
      }
   }
}
