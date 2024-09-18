package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.eventBattle.views.bossWidget.VO.DAAPIEventBossWidgetVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EventBossWidgetMeta extends BattleDisplayable
   {
       
      
      private var _dAAPIEventBossWidgetVO:DAAPIEventBossWidgetVO;
      
      public function EventBossWidgetMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._dAAPIEventBossWidgetVO)
         {
            this._dAAPIEventBossWidgetVO.dispose();
            this._dAAPIEventBossWidgetVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setWidgetData(param1:Object) : void
      {
         var _loc2_:DAAPIEventBossWidgetVO = this._dAAPIEventBossWidgetVO;
         this._dAAPIEventBossWidgetVO = new DAAPIEventBossWidgetVO(param1);
         this.setWidgetData(this._dAAPIEventBossWidgetVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setWidgetData(param1:DAAPIEventBossWidgetVO) : void
      {
         var _loc2_:String = "as_setWidgetData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
