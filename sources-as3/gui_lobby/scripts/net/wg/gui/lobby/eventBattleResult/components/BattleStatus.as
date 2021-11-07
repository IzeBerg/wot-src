package net.wg.gui.lobby.eventBattleResult.components
{
   import net.wg.gui.lobby.eventBattleResult.data.ResultDataVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BattleStatus extends ResultAppearMovieClip implements IDisposable
   {
       
      
      public var header:BattleStatusHeader = null;
      
      public function BattleStatus()
      {
         super();
      }
      
      public function setData(param1:ResultDataVO) : void
      {
         this.header.setData(param1);
      }
      
      public final function dispose() : void
      {
         this.header.dispose();
         this.header = null;
      }
   }
}
