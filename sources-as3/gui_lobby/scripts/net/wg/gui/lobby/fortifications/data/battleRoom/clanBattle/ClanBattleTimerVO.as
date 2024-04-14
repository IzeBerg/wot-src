package net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ClanBattleTimerVO extends DAAPIDataClass
   {
       
      
      public var useUniqueIdentifier:Boolean = false;
      
      public var uniqueIdentifier:Number = -1;
      
      public var deltaTime:int = -1;
      
      public var htmlFormatter:String = "";
      
      public var alertHtmlFormatter:String = "";
      
      public var glowColor:Number = -1;
      
      public var alertGlowColor:Number = -1;
      
      public var timerDefaultValue:String = "--";
      
      public var state:int = -1;
      
      public function ClanBattleTimerVO(param1:Object)
      {
         super(param1);
      }
   }
}
