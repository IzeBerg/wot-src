package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.gui.lobby.header.vo.AccountBoosterVO;
   import net.wg.gui.lobby.header.vo.AccountDataVo;
   import net.wg.gui.lobby.header.vo.ExtendedSquadInfoVo;
   import net.wg.gui.lobby.header.vo.HBC_FinanceVo;
   import net.wg.gui.lobby.header.vo.HBC_PremDataVo;
   import net.wg.gui.lobby.header.vo.HangarMenuTabItemVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class LobbyHeaderMeta extends BaseDAAPIComponent
   {
       
      
      public var menuItemClick:Function;
      
      public var showLobbyMenu:Function;
      
      public var showDashboard:Function;
      
      public var showExchangeWindow:Function;
      
      public var showExchangeXPWindow:Function;
      
      public var showPremiumView:Function;
      
      public var onPremShopClick:Function;
      
      public var onCrystalClick:Function;
      
      public var onPayment:Function;
      
      public var movePlatoonPopover:Function;
      
      public var showSquad:Function;
      
      public var openFullscreenBattleSelector:Function;
      
      public var closeFullscreenBattleSelector:Function;
      
      public var fightClick:Function;
      
      private var _hBC_FinanceVo:HBC_FinanceVo;
      
      private var _extendedSquadInfoVo:ExtendedSquadInfoVo;
      
      private var _accountDataVo:AccountDataVo;
      
      private var _badgeVisualVO:BadgeVisualVO;
      
      private var _accountBoosterVO:AccountBoosterVO;
      
      private var _hBC_PremDataVo:HBC_PremDataVo;
      
      private var _dataProviderHangarMenuTabItemVO:DataProvider;
      
      private var _vectorString:Vector.<String>;
      
      public function LobbyHeaderMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:HangarMenuTabItemVO = null;
         if(this._hBC_FinanceVo)
         {
            this._hBC_FinanceVo.dispose();
            this._hBC_FinanceVo = null;
         }
         if(this._extendedSquadInfoVo)
         {
            this._extendedSquadInfoVo.dispose();
            this._extendedSquadInfoVo = null;
         }
         if(this._accountDataVo)
         {
            this._accountDataVo.dispose();
            this._accountDataVo = null;
         }
         if(this._badgeVisualVO)
         {
            this._badgeVisualVO.dispose();
            this._badgeVisualVO = null;
         }
         if(this._accountBoosterVO)
         {
            this._accountBoosterVO.dispose();
            this._accountBoosterVO = null;
         }
         if(this._hBC_PremDataVo)
         {
            this._hBC_PremDataVo.dispose();
            this._hBC_PremDataVo = null;
         }
         if(this._dataProviderHangarMenuTabItemVO)
         {
            for each(_loc1_ in this._dataProviderHangarMenuTabItemVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderHangarMenuTabItemVO.cleanUp();
            this._dataProviderHangarMenuTabItemVO = null;
         }
         if(this._vectorString)
         {
            this._vectorString.splice(0,this._vectorString.length);
            this._vectorString = null;
         }
         super.onDispose();
      }
      
      public function menuItemClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.menuItemClick,"menuItemClick" + Errors.CANT_NULL);
         this.menuItemClick(param1);
      }
      
      public function showLobbyMenuS() : void
      {
         App.utils.asserter.assertNotNull(this.showLobbyMenu,"showLobbyMenu" + Errors.CANT_NULL);
         this.showLobbyMenu();
      }
      
      public function showDashboardS() : void
      {
         App.utils.asserter.assertNotNull(this.showDashboard,"showDashboard" + Errors.CANT_NULL);
         this.showDashboard();
      }
      
      public function showExchangeWindowS() : void
      {
         App.utils.asserter.assertNotNull(this.showExchangeWindow,"showExchangeWindow" + Errors.CANT_NULL);
         this.showExchangeWindow();
      }
      
      public function showExchangeXPWindowS() : void
      {
         App.utils.asserter.assertNotNull(this.showExchangeXPWindow,"showExchangeXPWindow" + Errors.CANT_NULL);
         this.showExchangeXPWindow();
      }
      
      public function showPremiumViewS() : void
      {
         App.utils.asserter.assertNotNull(this.showPremiumView,"showPremiumView" + Errors.CANT_NULL);
         this.showPremiumView();
      }
      
      public function onPremShopClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onPremShopClick,"onPremShopClick" + Errors.CANT_NULL);
         this.onPremShopClick();
      }
      
      public function onCrystalClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCrystalClick,"onCrystalClick" + Errors.CANT_NULL);
         this.onCrystalClick();
      }
      
      public function onPaymentS() : void
      {
         App.utils.asserter.assertNotNull(this.onPayment,"onPayment" + Errors.CANT_NULL);
         this.onPayment();
      }
      
      public function movePlatoonPopoverS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.movePlatoonPopover,"movePlatoonPopover" + Errors.CANT_NULL);
         this.movePlatoonPopover(param1);
      }
      
      public function showSquadS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.showSquad,"showSquad" + Errors.CANT_NULL);
         this.showSquad(param1);
      }
      
      public function openFullscreenBattleSelectorS() : void
      {
         App.utils.asserter.assertNotNull(this.openFullscreenBattleSelector,"openFullscreenBattleSelector" + Errors.CANT_NULL);
         this.openFullscreenBattleSelector();
      }
      
      public function closeFullscreenBattleSelectorS() : void
      {
         App.utils.asserter.assertNotNull(this.closeFullscreenBattleSelector,"closeFullscreenBattleSelector" + Errors.CANT_NULL);
         this.closeFullscreenBattleSelector();
      }
      
      public function fightClickS(param1:int, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.fightClick,"fightClick" + Errors.CANT_NULL);
         this.fightClick(param1,param2);
      }
      
      public final function as_updateWalletBtn(param1:String, param2:Object) : void
      {
         var _loc3_:HBC_FinanceVo = this._hBC_FinanceVo;
         this._hBC_FinanceVo = new HBC_FinanceVo(param2);
         this.updateWalletBtn(param1,this._hBC_FinanceVo);
         if(_loc3_)
         {
            _loc3_.dispose();
         }
      }
      
      public final function as_updateSquad(param1:Boolean, param2:String, param3:String, param4:Boolean, param5:String, param6:Boolean, param7:Object) : void
      {
         var _loc8_:ExtendedSquadInfoVo = this._extendedSquadInfoVo;
         this._extendedSquadInfoVo = new ExtendedSquadInfoVo(param7);
         this.updateSquad(param1,param2,param3,param4,param5,param6,this._extendedSquadInfoVo);
         if(_loc8_)
         {
            _loc8_.dispose();
         }
      }
      
      public final function as_nameResponse(param1:Object) : void
      {
         var _loc2_:AccountDataVo = this._accountDataVo;
         this._accountDataVo = new AccountDataVo(param1);
         this.nameResponse(this._accountDataVo);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setBadge(param1:Object, param2:Boolean) : void
      {
         var _loc3_:BadgeVisualVO = this._badgeVisualVO;
         this._badgeVisualVO = new BadgeVisualVO(param1);
         this.setBadge(this._badgeVisualVO,param2);
         if(_loc3_)
         {
            _loc3_.dispose();
         }
      }
      
      public final function as_setBoosterData(param1:Object) : void
      {
         var _loc2_:AccountBoosterVO = this._accountBoosterVO;
         this._accountBoosterVO = new AccountBoosterVO(param1);
         this.setBoosterData(this._accountBoosterVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setPremiumParams(param1:Object) : void
      {
         var _loc2_:HBC_PremDataVo = this._hBC_PremDataVo;
         this._hBC_PremDataVo = new HBC_PremDataVo(param1);
         this.setPremiumParams(this._hBC_PremDataVo);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setHangarMenuData(param1:Array) : void
      {
         var _loc5_:HangarMenuTabItemVO = null;
         var _loc2_:DataProvider = this._dataProviderHangarMenuTabItemVO;
         this._dataProviderHangarMenuTabItemVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderHangarMenuTabItemVO[_loc4_] = new HangarMenuTabItemVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setHangarMenuData(this._dataProviderHangarMenuTabItemVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      public final function as_setHeaderButtons(param1:Array) : void
      {
         var _loc2_:Vector.<String> = this._vectorString;
         this._vectorString = new Vector.<String>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorString[_loc4_] = param1[_loc4_];
            _loc4_++;
         }
         this.setHeaderButtons(this._vectorString);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function updateWalletBtn(param1:String, param2:HBC_FinanceVo) : void
      {
         var _loc3_:String = "as_updateWalletBtn" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function updateSquad(param1:Boolean, param2:String, param3:String, param4:Boolean, param5:String, param6:Boolean, param7:ExtendedSquadInfoVo) : void
      {
         var _loc8_:String = "as_updateSquad" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc8_);
         throw new AbstractException(_loc8_);
      }
      
      protected function nameResponse(param1:AccountDataVo) : void
      {
         var _loc2_:String = "as_nameResponse" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setBadge(param1:BadgeVisualVO, param2:Boolean) : void
      {
         var _loc3_:String = "as_setBadge" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function setBoosterData(param1:AccountBoosterVO) : void
      {
         var _loc2_:String = "as_setBoosterData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setPremiumParams(param1:HBC_PremDataVo) : void
      {
         var _loc2_:String = "as_setPremiumParams" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setHangarMenuData(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setHangarMenuData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setHeaderButtons(param1:Vector.<String>) : void
      {
         var _loc2_:String = "as_setHeaderButtons" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
