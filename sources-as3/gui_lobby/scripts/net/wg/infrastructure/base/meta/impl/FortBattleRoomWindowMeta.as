package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.rally.RallyMainWindowWithSearch;
   
   public class FortBattleRoomWindowMeta extends RallyMainWindowWithSearch
   {
       
      
      public var onBrowseClanBattles:Function;
      
      public var onJoinClanBattle:Function;
      
      public var onCreatedBattleRoom:Function;
      
      public var refresh:Function;
      
      public function FortBattleRoomWindowMeta()
      {
         super();
      }
      
      public function onBrowseClanBattlesS() : void
      {
         App.utils.asserter.assertNotNull(this.onBrowseClanBattles,"onBrowseClanBattles" + Errors.CANT_NULL);
         this.onBrowseClanBattles();
      }
      
      public function onJoinClanBattleS(param1:Number, param2:int, param3:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onJoinClanBattle,"onJoinClanBattle" + Errors.CANT_NULL);
         this.onJoinClanBattle(param1,param2,param3);
      }
      
      public function onCreatedBattleRoomS(param1:Number, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onCreatedBattleRoom,"onCreatedBattleRoom" + Errors.CANT_NULL);
         this.onCreatedBattleRoom(param1,param2);
      }
      
      public function refreshS() : void
      {
         App.utils.asserter.assertNotNull(this.refresh,"refresh" + Errors.CANT_NULL);
         this.refresh();
      }
   }
}
