package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.views.epicMissionsPanel.data.EpicMissionVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EpicMissionsPanelMeta extends BattleDisplayable
   {
       
      
      private var _epicMissionVO:EpicMissionVO;
      
      public function EpicMissionsPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._epicMissionVO)
         {
            this._epicMissionVO.dispose();
            this._epicMissionVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setPrimaryMission(param1:Object) : void
      {
         var _loc2_:EpicMissionVO = this._epicMissionVO;
         this._epicMissionVO = new EpicMissionVO(param1);
         this.setPrimaryMission(this._epicMissionVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setPrimaryMission(param1:EpicMissionVO) : void
      {
         var _loc2_:String = "as_setPrimaryMission" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
