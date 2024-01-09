package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.epicBattle.views.modificationPanel.data.EpicModificationPanelVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EpicModificationPanelMeta extends BattleDisplayable
   {
       
      
      private var _epicModificationPanelVO:EpicModificationPanelVO;
      
      public function EpicModificationPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._epicModificationPanelVO)
         {
            this._epicModificationPanelVO.dispose();
            this._epicModificationPanelVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:EpicModificationPanelVO = this._epicModificationPanelVO;
         this._epicModificationPanelVO = new EpicModificationPanelVO(param1);
         this.setData(this._epicModificationPanelVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:EpicModificationPanelVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
