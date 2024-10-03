package net.wg.white_tiger.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.data.BossWidgetVO;
   
   public class WTBossWidgetMeta extends BattleDisplayable
   {
       
      
      private var _bossWidgetVO:BossWidgetVO;
      
      public function WTBossWidgetMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._bossWidgetVO)
         {
            this._bossWidgetVO.dispose();
            this._bossWidgetVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setWidgetData(param1:Object) : void
      {
         var _loc2_:BossWidgetVO = this._bossWidgetVO;
         this._bossWidgetVO = new BossWidgetVO(param1);
         this.setWidgetData(this._bossWidgetVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setWidgetData(param1:BossWidgetVO) : void
      {
         var _loc2_:String = "as_setWidgetData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
