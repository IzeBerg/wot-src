package net.wg.gui.battle.historicalBattles.destroyTimers
{
   import net.wg.data.constants.generated.BATTLE_NOTIFICATIONS_TIMER_TYPES;
   import net.wg.gui.battle.components.StatusNotificationsPanel;
   import net.wg.gui.battle.components.interfaces.IStatusNotification;
   import net.wg.gui.battle.views.destroyTimers.ResupplyTimer;
   import net.wg.gui.battle.views.destroyTimers.SecondaryTimer;
   
   public class HBStatusNotificationPanel extends StatusNotificationsPanel
   {
      
      private static const HB_NOTIFICATION_TIMERS_OFFSET_X:uint = 11;
       
      
      public function HBStatusNotificationPanel()
      {
         super();
      }
      
      override protected function layoutTimers(param1:Array, param2:Array) : void
      {
         var _loc3_:IStatusNotification = null;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         for each(_loc3_ in param1)
         {
            if(_loc3_.isShowing)
            {
               if(_loc7_ > 0)
               {
                  _loc4_ = _loc3_.cropSize();
                  if(_loc4_ && !_loc5_)
                  {
                     _loc6_ -= HB_NOTIFICATION_TIMERS_OFFSET_X;
                  }
                  _loc5_ = _loc4_;
               }
               else if(!(_loc3_ is SecondaryTimer) && !(_loc3_ is ResupplyTimer) || _loc3_.typeId == BATTLE_NOTIFICATIONS_TIMER_TYPES.ORANGE_ZONE || _loc3_.typeId == BATTLE_NOTIFICATIONS_TIMER_TYPES.DAMAGING_ZONE)
               {
                  _loc3_.fullSize();
               }
               else
               {
                  _loc3_.cropSize();
                  _loc5_ = true;
               }
               _loc7_++;
               if(param2.indexOf(_loc3_) == -1)
               {
                  if(_loc3_.x != _loc6_)
                  {
                     _loc3_.tweenToX(_loc6_);
                  }
               }
               else
               {
                  _loc3_.x = _loc6_;
               }
               _loc6_ += _loc3_.actualWidth;
            }
         }
      }
   }
}
