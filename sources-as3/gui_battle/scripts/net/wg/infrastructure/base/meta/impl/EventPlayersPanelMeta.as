package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.PlayersPanelBase;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.VO.DAAPIEventBossBotInfoVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EventPlayersPanelMeta extends PlayersPanelBase
   {
       
      
      private var _dAAPIEventBossBotInfoVO:DAAPIEventBossBotInfoVO;
      
      public function EventPlayersPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._dAAPIEventBossBotInfoVO)
         {
            this._dAAPIEventBossBotInfoVO.dispose();
            this._dAAPIEventBossBotInfoVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setBossBotInfo(param1:Object) : void
      {
         var _loc2_:DAAPIEventBossBotInfoVO = this._dAAPIEventBossBotInfoVO;
         this._dAAPIEventBossBotInfoVO = new DAAPIEventBossBotInfoVO(param1);
         this.setBossBotInfo(this._dAAPIEventBossBotInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setBossBotInfo(param1:DAAPIEventBossBotInfoVO) : void
      {
         var _loc2_:String = "as_setBossBotInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
