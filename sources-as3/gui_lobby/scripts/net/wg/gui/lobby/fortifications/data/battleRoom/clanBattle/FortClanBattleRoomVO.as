package net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class FortClanBattleRoomVO extends DAAPIDataClass
   {
       
      
      public var mapID:int = -1;
      
      public var mapName:String = "";
      
      public var headerDescr:String = "";
      
      public var teamHeader:String = "";
      
      public var mineClanName:String = "";
      
      public var enemyClanName:String = "";
      
      public var waitForBattleDescr:String = "";
      
      public var isMapEnabled:Boolean = true;
      
      public var isBattleTimerVisible:Boolean = false;
      
      public var isBattleType:Boolean = true;
      
      public var levelsRange:Array = null;
      
      public function FortClanBattleRoomVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.levelsRange)
         {
            this.levelsRange.splice(0,this.levelsRange.length);
            this.levelsRange = null;
         }
         super.onDispose();
      }
   }
}
