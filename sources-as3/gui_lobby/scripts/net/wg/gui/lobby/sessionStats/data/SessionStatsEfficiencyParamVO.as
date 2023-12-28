package net.wg.gui.lobby.sessionStats.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class SessionStatsEfficiencyParamVO extends DAAPIDataClass
   {
      
      private static const PARAMS:String = "params";
      
      private static const TOTAL:String = "total";
       
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var icon:String = "";
      
      public var params:DataProvider = null;
      
      public var total:SessionBattleStatsRendererVO = null;
      
      public function SessionStatsEfficiencyParamVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == PARAMS)
         {
            this.params = new DataProvider();
            for each(_loc3_ in param2)
            {
               this.params.push(new SessionBattleStatsRendererVO(_loc3_));
            }
            return false;
         }
         if(param2 && param1 == TOTAL)
         {
            this.total = new SessionBattleStatsRendererVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.params)
         {
            for each(_loc1_ in this.params)
            {
               _loc1_.dispose();
            }
            this.params.cleanUp();
         }
         this.params = null;
         if(this.total)
         {
            this.total.dispose();
            this.total = null;
         }
         super.onDispose();
      }
   }
}
