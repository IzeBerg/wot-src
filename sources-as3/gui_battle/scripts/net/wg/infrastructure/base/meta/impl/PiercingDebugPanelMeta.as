package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.views.piercingDebugPanel.data.DebugPanelVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PiercingDebugPanelMeta extends BattleDisplayable
   {
       
      
      private var _debugPanelVO:DebugPanelVO;
      
      public function PiercingDebugPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._debugPanelVO)
         {
            this._debugPanelVO.dispose();
            this._debugPanelVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:DebugPanelVO = this._debugPanelVO;
         this._debugPanelVO = new DebugPanelVO(param1);
         this.setData(this._debugPanelVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:DebugPanelVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
