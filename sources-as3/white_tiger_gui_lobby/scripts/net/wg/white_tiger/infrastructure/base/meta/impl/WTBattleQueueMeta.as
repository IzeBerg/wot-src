package net.wg.white_tiger.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.meta.impl.BattleQueueMeta;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.white_tiger.gui.lobby.battleQueue.data.QuickStartPanelVO;
   
   public class WTBattleQueueMeta extends BattleQueueMeta
   {
       
      
      public var onQuickStartPanelAction:Function;
      
      private var _quickStartPanelVO:QuickStartPanelVO;
      
      public function WTBattleQueueMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._quickStartPanelVO)
         {
            this._quickStartPanelVO.dispose();
            this._quickStartPanelVO = null;
         }
         super.onDispose();
      }
      
      public function onQuickStartPanelActionS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onQuickStartPanelAction,"onQuickStartPanelAction" + Errors.CANT_NULL);
         this.onQuickStartPanelAction(param1);
      }
      
      public final function as_showQuickStartPanel(param1:Object) : void
      {
         var _loc2_:QuickStartPanelVO = this._quickStartPanelVO;
         this._quickStartPanelVO = this.getQuickStartPanelVOForData(param1);
         this.showQuickStartPanel(this._quickStartPanelVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function getQuickStartPanelVOForData(param1:Object) : QuickStartPanelVO
      {
         var _loc2_:String = "getQuickStartPanelVOForData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function showQuickStartPanel(param1:QuickStartPanelVO) : void
      {
         var _loc2_:String = "as_showQuickStartPanel" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
