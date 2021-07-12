package net.wg.gui.lobby.sessionStats.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class SessionStatsSettingsBaseVO extends DAAPIDataClass
   {
      
      private static const INPUTS_FIELD:String = "inputs";
       
      
      public var title:String = "";
      
      public var inputs:DataProvider = null;
      
      public function SessionStatsSettingsBaseVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 == INPUTS_FIELD)
         {
            this.inputs = new DataProvider();
            _loc3_ = param2.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               this.inputs.push(new SessionStatsSettingsInputVO(param2[_loc4_]));
               _loc4_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.inputs)
         {
            _loc1_ = null;
            for each(_loc1_ in this.inputs)
            {
               _loc1_.dispose();
            }
            this.inputs.cleanUp();
            this.inputs = null;
         }
         super.onDispose();
      }
   }
}
