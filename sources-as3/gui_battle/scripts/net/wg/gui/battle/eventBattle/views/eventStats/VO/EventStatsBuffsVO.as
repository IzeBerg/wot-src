package net.wg.gui.battle.eventBattle.views.eventStats.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class EventStatsBuffsVO extends DAAPIDataClass
   {
      
      private static const BUFFS:String = "buffs";
       
      
      public var buffs:DataProvider = null;
      
      public function EventStatsBuffsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         if(param1 == BUFFS)
         {
            this.buffs = new DataProvider();
            _loc4_ = param2 as Array;
            for each(_loc3_ in _loc4_)
            {
               this.buffs.push(new EventBuffsVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:EventBuffsVO = null;
         if(this.buffs)
         {
            for each(_loc1_ in this.buffs)
            {
               _loc1_.dispose();
            }
            this.buffs.cleanUp();
            this.buffs = null;
         }
         super.onDispose();
      }
   }
}
