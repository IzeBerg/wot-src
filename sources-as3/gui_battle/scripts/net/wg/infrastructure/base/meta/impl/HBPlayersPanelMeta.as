package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   
   public class HBPlayersPanelMeta extends BattleDisplayable
   {
       
      
      public var acceptSquad:Function;
      
      public var addToSquad:Function;
      
      public var switchToOtherPlayer:Function;
      
      public function HBPlayersPanelMeta()
      {
         super();
      }
      
      public function acceptSquadS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.acceptSquad,"acceptSquad" + Errors.CANT_NULL);
         this.acceptSquad(param1);
      }
      
      public function addToSquadS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.addToSquad,"addToSquad" + Errors.CANT_NULL);
         this.addToSquad(param1);
      }
      
      public function switchToOtherPlayerS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.switchToOtherPlayer,"switchToOtherPlayer" + Errors.CANT_NULL);
         this.switchToOtherPlayer(param1);
      }
   }
}
