package net.wg.gui.battle.views.destroyTimers.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TimersPanelInitVO extends DAAPIDataClass
   {
      
      private static const MAIN_TIMERS:String = "mainTimers";
      
      private static const SECONDARY_TIMERS:String = "secondaryTimers";
       
      
      public var _mainTimers:Vector.<NotificationTimerSettingVO> = null;
      
      public var _secondaryTimers:Vector.<NotificationTimerSettingVO> = null;
      
      public function TimersPanelInitVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = param2 as Array;
         var _loc4_:Object = null;
         if(param1 == MAIN_TIMERS)
         {
            if(this._mainTimers && this._mainTimers.length > 0)
            {
               this._mainTimers.splice(0,this._mainTimers.length);
            }
            else
            {
               this._mainTimers = new Vector.<NotificationTimerSettingVO>();
            }
            if(_loc3_ != null)
            {
               for each(_loc4_ in _loc3_)
               {
                  this._mainTimers.push(new NotificationTimerSettingVO(_loc4_));
               }
            }
            else
            {
               App.utils.asserter.assert(param2 is Array,param1 + " must be an Array");
            }
            return false;
         }
         if(param1 == SECONDARY_TIMERS)
         {
            if(this._secondaryTimers && this._secondaryTimers.length > 0)
            {
               this._secondaryTimers.splice(0,this._secondaryTimers.length);
            }
            else
            {
               this._secondaryTimers = new Vector.<NotificationTimerSettingVO>();
            }
            if(_loc3_ != null)
            {
               for each(_loc4_ in _loc3_)
               {
                  this._secondaryTimers.push(new NotificationTimerSettingVO(_loc4_));
               }
            }
            else
            {
               App.utils.asserter.assert(param2 is Array,param1 + " must be an Array");
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._mainTimers)
         {
            this._mainTimers.splice(0,this._mainTimers.length);
            this._mainTimers = null;
         }
         if(this._secondaryTimers)
         {
            this._secondaryTimers.splice(0,this._secondaryTimers.length);
            this._secondaryTimers = null;
         }
         super.onDispose();
      }
      
      public function get mainTimers() : Vector.<NotificationTimerSettingVO>
      {
         return this._mainTimers;
      }
      
      public function get secondaryTimers() : Vector.<NotificationTimerSettingVO>
      {
         return this._secondaryTimers;
      }
   }
}
