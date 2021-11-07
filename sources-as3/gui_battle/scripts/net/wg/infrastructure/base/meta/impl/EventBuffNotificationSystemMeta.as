package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.eventBattle.views.eventBuffNotificationSystem.data.BuffNotificationInfoVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EventBuffNotificationSystemMeta extends BattleDisplayable
   {
       
      
      private var _buffNotificationInfoVO:BuffNotificationInfoVO;
      
      public function EventBuffNotificationSystemMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._buffNotificationInfoVO)
         {
            this._buffNotificationInfoVO.dispose();
            this._buffNotificationInfoVO = null;
         }
         super.onDispose();
      }
      
      public final function as_showBuffNotification(param1:Object) : void
      {
         var _loc2_:BuffNotificationInfoVO = this._buffNotificationInfoVO;
         this._buffNotificationInfoVO = new BuffNotificationInfoVO(param1);
         this.showBuffNotification(this._buffNotificationInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function showBuffNotification(param1:BuffNotificationInfoVO) : void
      {
         var _loc2_:String = "as_showBuffNotification" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
