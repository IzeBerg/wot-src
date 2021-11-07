package net.wg.gui.lobby.settings.vo
{
   import net.wg.data.VO.CountersVo;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SettingsTabNewCounterVo extends DAAPIDataClass
   {
      
      private static const COUNTERS_FIELD_NAME:String = "counters";
       
      
      public var subTabId:String = "";
      
      public var counters:Vector.<CountersVo> = null;
      
      public function SettingsTabNewCounterVo(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(param1 == COUNTERS_FIELD_NAME)
         {
            this.counters = new Vector.<CountersVo>();
            _loc3_ = 0;
            _loc4_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc4_,"value must have type Array");
            _loc5_ = _loc4_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               this.counters.push(new CountersVo(_loc4_[_loc3_]));
               _loc3_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.counters)
         {
            while(this.counters.length)
            {
               this.counters.pop().dispose();
            }
            this.counters = null;
         }
         super.onDispose();
      }
   }
}
