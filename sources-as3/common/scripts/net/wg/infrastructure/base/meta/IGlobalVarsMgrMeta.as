package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IGlobalVarsMgrMeta extends IEventDispatcher
   {
       
      
      function isDevelopmentS() : Boolean;
      
      function isShowLangaugeBarS() : Boolean;
      
      function isShowServerStatsS() : Boolean;
      
      function isChinaS() : Boolean;
      
      function isKoreaS() : Boolean;
      
      function isTutorialRunningS(param1:String) : Boolean;
      
      function isRoamingEnabledS() : Boolean;
      
      function isInRoamingS() : Boolean;
      
      function isFreeXpToTankmanS() : Boolean;
      
      function getLocaleOverrideS() : String;
      
      function isFortificationAvailableS() : Boolean;
      
      function isRentalsEnabledS() : Boolean;
      
      function isPersonalMissionsEnabledS() : Boolean;
      
      function isLoginLoadedAtFirstTimeS() : Boolean;
      
      function isVehicleRestoreEnabledS() : Boolean;
      
      function isTradeInEnabledS() : Boolean;
   }
}
