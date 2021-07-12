package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RewardsLeagueVO extends DAAPIDataClass
   {
      
      private static const LEAGUE_FIELD:String = "leagues";
       
      
      public var leagues:Vector.<RewardsLeagueRendererVO> = null;
      
      public var leaguesCount:int = 0;
      
      public var description:String = "";
      
      public function RewardsLeagueVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this.leagues)
         {
            _loc1_.dispose();
         }
         this.leagues.splice(0,this.leagues.length);
         this.leagues = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == LEAGUE_FIELD)
         {
            if(param2)
            {
               _loc3_ = param2 as Array;
               if(_loc3_)
               {
                  this.leagues = new Vector.<RewardsLeagueRendererVO>();
                  _loc4_ = _loc3_.length;
                  _loc5_ = 0;
                  while(_loc5_ < _loc4_)
                  {
                     this.leagues.push(new RewardsLeagueRendererVO(_loc3_[_loc5_]));
                     _loc5_++;
                  }
               }
               this.leaguesCount = this.leagues.length;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}
