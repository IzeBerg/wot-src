package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ILobbyHeaderMeta extends IEventDispatcher
   {
       
      
      function menuItemClickS(param1:String) : void;
      
      function showLobbyMenuS() : void;
      
      function showDashboardS() : void;
      
      function showExchangeWindowS() : void;
      
      function showExchangeXPWindowS() : void;
      
      function showWotPlusViewS() : void;
      
      function showPremiumViewS() : void;
      
      function onPremShopClickS() : void;
      
      function onReservesClickS() : void;
      
      function onCrystalClickS() : void;
      
      function onPaymentS() : void;
      
      function movePlatoonPopoverS(param1:int) : void;
      
      function showSquadS(param1:int) : void;
      
      function openFullscreenBattleSelectorS() : void;
      
      function closeFullscreenBattleSelectorS() : void;
      
      function fightClickS(param1:int, param2:String) : void;
      
      function as_setScreen(param1:String) : void;
      
      function as_updateWalletBtn(param1:String, param2:Object) : void;
      
      function as_doDisableNavigation() : void;
      
      function as_doDisableHeaderButton(param1:String, param2:Boolean) : void;
      
      function as_doSoftDisableHeaderButton(param1:String, param2:Boolean) : void;
      
      function as_doDeselectHeaderButton(param1:String) : void;
      
      function as_setGoldFishEnabled(param1:Boolean, param2:Boolean, param3:String, param4:String) : void;
      
      function as_updateSquad(param1:Boolean, param2:String, param3:String, param4:Boolean, param5:String, param6:Boolean, param7:Object) : void;
      
      function as_nameResponse(param1:Object) : void;
      
      function as_setBadge(param1:Object, param2:Boolean) : void;
      
      function as_setWotPlusData(param1:Object) : void;
      
      function as_setPremiumParams(param1:Object) : void;
      
      function as_setPremShopData(param1:String, param2:String, param3:String, param4:String) : void;
      
      function as_updateBattleType(param1:String, param2:String, param3:Boolean, param4:String, param5:String, param6:String, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean) : void;
      
      function as_setServer(param1:String, param2:String, param3:String) : void;
      
      function as_updatePingStatus(param1:int, param2:Boolean) : void;
      
      function as_updateAnonymizedState(param1:Boolean) : void;
      
      function as_setWalletStatus(param1:Object) : void;
      
      function as_disableFightButton(param1:Boolean) : void;
      
      function as_setFightButton(param1:String) : void;
      
      function as_setCoolDownForReady(param1:uint) : void;
      
      function as_showBubbleTooltip(param1:String, param2:int) : void;
      
      function as_setFightBtnTooltip(param1:String, param2:Boolean) : void;
      
      function as_updateOnlineCounter(param1:String, param2:String, param3:String, param4:Boolean) : void;
      
      function as_initOnlineCounter(param1:Boolean) : void;
      
      function as_setServerName(param1:String) : void;
      
      function as_setHangarMenuData(param1:Array) : void;
      
      function as_setButtonCounter(param1:String, param2:String) : void;
      
      function as_removeButtonCounter(param1:String) : void;
      
      function as_setHeaderButtons(param1:Array) : void;
      
      function as_hideMenu(param1:Boolean) : void;
      
      function as_toggleVisibilityMenu(param1:uint) : void;
      
      function as_setIsPlatoonDropdownShowing(param1:Boolean) : void;
      
      function as_setIsFullscreenBattleSelectorShowing(param1:Boolean) : void;
      
      function as_setButtonHighlight(param1:String, param2:String) : void;
   }
}
