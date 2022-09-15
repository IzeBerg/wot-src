package net.wg.gui.lobby.clans.search.VOs
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.profile.pages.statistics.header.StatisticsHeaderVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ClanSearchInfoDataVO extends DAAPIDataClass
   {
      
      private static const STATS:String = "stats";
       
      
      public var clanId:Number = NaN;
      
      public var clanName:String = "";
      
      public var ratingTitle:String = "";
      
      public var rating:String = "";
      
      private var _stats:Vector.<StatisticsHeaderVO> = null;
      
      public function ClanSearchInfoDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._stats)
         {
            _loc1_.dispose();
         }
         this._stats.splice(0,this._stats.length);
         this._stats = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(STATS == param1)
         {
            this._stats = new Vector.<StatisticsHeaderVO>(0);
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,STATS + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_)
            {
               this._stats.push(new StatisticsHeaderVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get stats() : Vector.<StatisticsHeaderVO>
      {
         return this._stats;
      }
   }
}
