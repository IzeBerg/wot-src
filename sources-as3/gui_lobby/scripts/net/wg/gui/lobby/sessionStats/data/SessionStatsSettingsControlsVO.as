package net.wg.gui.lobby.sessionStats.data
{
   import net.wg.data.VO.ButtonPropertiesVO;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SessionStatsSettingsControlsVO extends DAAPIDataClass
   {
      
      private static const STATES_FIELD:String = "states";
      
      private static const WARNING_FIELD:String = "warning";
       
      
      public var warning:SessionStatsSettingsControlsWarningVO = null;
      
      public var states:Vector.<ButtonPropertiesVO> = null;
      
      public function SessionStatsSettingsControlsVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 == STATES_FIELD)
         {
            if(param2)
            {
               this.states = new Vector.<ButtonPropertiesVO>();
               _loc3_ = param2.length;
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  this.states.push(new ButtonPropertiesVO(param2[_loc4_]));
                  _loc4_++;
               }
            }
            return false;
         }
         if(param1 == WARNING_FIELD)
         {
            if(param2)
            {
               this.warning = new SessionStatsSettingsControlsWarningVO(param2);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.states)
         {
            _loc1_ = this.states.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this.states[_loc2_].dispose();
               _loc2_++;
            }
            this.states.splice(0,_loc1_);
            this.states = null;
         }
         if(this.warning)
         {
            this.warning.dispose();
            this.warning = null;
         }
         super.onDispose();
      }
   }
}
