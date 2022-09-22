package net.wg.gui.lobby.sessionStats.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class SessionStatsOverviewVO extends DAAPIDataClass
   {
      
      private static const TABS:String = "tabs";
       
      
      public var tabs:DataProvider = null;
      
      public var headerImg:String = "";
      
      public var title:String = "";
      
      public var isExpanded:Boolean = false;
      
      public var battleCount:int = 0;
      
      public var lastBattleCount:int = 0;
      
      public function SessionStatsOverviewVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:SessionStatsTabVO = null;
         var _loc4_:Object = null;
         if(param1 == TABS && param2)
         {
            this.tabs = new DataProvider();
            for each(_loc4_ in param2)
            {
               _loc3_ = new SessionStatsTabVO(_loc4_);
               this.tabs.push(_loc3_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this.tabs)
         {
            _loc1_.dispose();
         }
         this.tabs.cleanUp();
         this.tabs = null;
         super.onDispose();
      }
   }
}
