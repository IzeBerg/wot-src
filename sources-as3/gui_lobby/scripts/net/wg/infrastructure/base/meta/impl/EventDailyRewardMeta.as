package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.eventHangar.data.EventDailyRewardVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EventDailyRewardMeta extends BaseDAAPIComponent
   {
       
      
      public var onClick:Function;
      
      private var _eventDailyRewardVO:EventDailyRewardVO;
      
      public function EventDailyRewardMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._eventDailyRewardVO)
         {
            this._eventDailyRewardVO.dispose();
            this._eventDailyRewardVO = null;
         }
         super.onDispose();
      }
      
      public function onClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onClick,"onClick" + Errors.CANT_NULL);
         this.onClick();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:EventDailyRewardVO = this._eventDailyRewardVO;
         this._eventDailyRewardVO = new EventDailyRewardVO(param1);
         this.setData(this._eventDailyRewardVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:EventDailyRewardVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
