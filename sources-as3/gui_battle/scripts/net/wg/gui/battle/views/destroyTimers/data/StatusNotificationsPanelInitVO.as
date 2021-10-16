package net.wg.gui.battle.views.destroyTimers.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class StatusNotificationsPanelInitVO extends DAAPIDataClass
   {
      
      private static const SETTINGS:String = "settings";
       
      
      public var _settings:Vector.<NotificationTimerSettingVO> = null;
      
      public function StatusNotificationsPanelInitVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == SETTINGS)
         {
            _loc3_ = param2 as Array;
            _loc4_ = null;
            if(this._settings && this._settings.length > 0)
            {
               this._settings.splice(0,this._settings.length);
            }
            else
            {
               this._settings = new Vector.<NotificationTimerSettingVO>();
            }
            if(_loc3_ != null)
            {
               for each(_loc4_ in _loc3_)
               {
                  this._settings.push(new NotificationTimerSettingVO(_loc4_));
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
         if(this._settings)
         {
            this._settings.splice(0,this._settings.length);
            this._settings = null;
         }
         super.onDispose();
      }
      
      public function get settings() : Vector.<NotificationTimerSettingVO>
      {
         return this._settings;
      }
   }
}
