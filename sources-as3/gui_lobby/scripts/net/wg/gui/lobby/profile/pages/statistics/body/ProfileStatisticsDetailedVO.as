package net.wg.gui.lobby.profile.pages.statistics.body
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ProfileStatisticsDetailedVO extends DAAPIDataClass
   {
       
      
      public var fragsCount:int;
      
      public var deathsCount:int;
      
      public var fragsEfficiency:Number;
      
      public var damageDealt:Number;
      
      public var damageReceived:Number;
      
      public var damageEfficiency:Number;
      
      public var avgFrags:Number;
      
      public var maxFrags:int;
      
      public var avgDamageDealt:Number;
      
      public var avgDamageReceived:Number;
      
      public var avgEnemiesSpotted:Number;
      
      public function ProfileStatisticsDetailedVO(param1:Object)
      {
         super(param1);
      }
      
      public function getFragsCountStr() : String
      {
         return App.utils.locale.integer(this.fragsCount);
      }
      
      public function getAvgDamageDealtStr() : String
      {
         return App.utils.locale.integer(this.avgDamageDealt);
      }
      
      public function getAvgDamageReceivedStr() : String
      {
         return App.utils.locale.integer(this.avgDamageReceived);
      }
      
      public function getDeathsCountStr() : String
      {
         return App.utils.locale.integer(this.deathsCount);
      }
      
      public function getFragsEfficiencyStr() : String
      {
         return App.utils.locale.numberWithoutZeros(this.fragsEfficiency);
      }
      
      public function getDamageDealtStr() : String
      {
         return App.utils.locale.integer(this.damageDealt);
      }
      
      public function getDamageReceivedStr() : String
      {
         return App.utils.locale.integer(this.damageReceived);
      }
      
      public function getDamageEfficiencyStr() : String
      {
         return App.utils.locale.integer(this.damageEfficiency);
      }
      
      public function getAvgFragsStr() : String
      {
         return App.utils.locale.numberWithoutZeros(this.avgFrags);
      }
      
      public function getMaxFragsStr() : String
      {
         return App.utils.locale.numberWithoutZeros(this.maxFrags);
      }
      
      public function getAvgEnemiesSpottedStr() : String
      {
         return App.utils.locale.numberWithoutZeros(this.avgEnemiesSpotted);
      }
   }
}
