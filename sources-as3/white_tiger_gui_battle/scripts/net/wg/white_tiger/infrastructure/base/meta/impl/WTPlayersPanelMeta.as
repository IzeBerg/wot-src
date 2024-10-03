package net.wg.white_tiger.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.PlayersPanelBase;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.VO.BossBotInfoVO;
   
   public class WTPlayersPanelMeta extends PlayersPanelBase
   {
       
      
      private var _bossBotInfoVO:BossBotInfoVO;
      
      public function WTPlayersPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._bossBotInfoVO)
         {
            this._bossBotInfoVO.dispose();
            this._bossBotInfoVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setBossBotInfo(param1:Object) : void
      {
         var _loc2_:BossBotInfoVO = this._bossBotInfoVO;
         this._bossBotInfoVO = new BossBotInfoVO(param1);
         this.setBossBotInfo(this._bossBotInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setBossBotInfo(param1:BossBotInfoVO) : void
      {
         var _loc2_:String = "as_setBossBotInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
