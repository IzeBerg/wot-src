package net.wg.mock
{
   import flash.events.Event;
   import net.wg.infrastructure.managers.IGlobalVarsManager;
   
   public class MockGlobalVarsManager implements IGlobalVarsManager
   {
       
      
      public function MockGlobalVarsManager()
      {
         super();
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
      }
      
      public function getLocaleOverrideS() : String
      {
         return "";
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return false;
      }
      
      public function isChinaS() : Boolean
      {
         return false;
      }
      
      public function isDevelopmentS() : Boolean
      {
         return false;
      }
      
      public function isFortificationAvailableS() : Boolean
      {
         return false;
      }
      
      public function isFreeXpToTankmanS() : Boolean
      {
         return false;
      }
      
      public function isInRoamingS() : Boolean
      {
         return false;
      }
      
      public function isKoreaS() : Boolean
      {
         return false;
      }
      
      public function isPersonalMissionsEnabledS() : Boolean
      {
         return false;
      }
      
      public function isRentalsEnabledS() : Boolean
      {
         return false;
      }
      
      public function isRoamingEnabledS() : Boolean
      {
         return false;
      }
      
      public function isShowLangaugeBarS() : Boolean
      {
         return false;
      }
      
      public function isShowServerStatsS() : Boolean
      {
         return false;
      }
      
      public function isTutorialRunningS(param1:String) : Boolean
      {
         return false;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return false;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return false;
      }
      
      public function isLoginLoadedAtFirstTimeS() : Boolean
      {
         return false;
      }
      
      public function isVehicleRestoreEnabledS() : Boolean
      {
         return false;
      }
      
      public function isTradeInEnabledS() : Boolean
      {
         return false;
      }
   }
}
