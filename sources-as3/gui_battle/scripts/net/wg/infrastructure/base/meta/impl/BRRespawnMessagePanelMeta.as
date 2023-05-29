package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.battleRoyale.data.RespawnMessageVO;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BRRespawnMessagePanelMeta extends BattleDisplayable
   {
       
      
      private var _respawnMessageVO:RespawnMessageVO;
      
      public function BRRespawnMessagePanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._respawnMessageVO)
         {
            this._respawnMessageVO.dispose();
            this._respawnMessageVO = null;
         }
         super.onDispose();
      }
      
      public final function as_addMessage(param1:Object) : void
      {
         var _loc2_:RespawnMessageVO = this._respawnMessageVO;
         this._respawnMessageVO = new RespawnMessageVO(param1);
         this.addMessage(this._respawnMessageVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function addMessage(param1:RespawnMessageVO) : void
      {
         var _loc2_:String = "as_addMessage" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
