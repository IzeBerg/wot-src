package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.views.destroyTimers.data.TimersPanelInitVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class TimersPanelMeta extends BattleDisplayable
   {
       
      
      private var _timersPanelInitVO:TimersPanelInitVO;
      
      public function TimersPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._timersPanelInitVO)
         {
            this._timersPanelInitVO.dispose();
            this._timersPanelInitVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:TimersPanelInitVO = this._timersPanelInitVO;
         this._timersPanelInitVO = new TimersPanelInitVO(param1);
         this.setInitData(this._timersPanelInitVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:TimersPanelInitVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
