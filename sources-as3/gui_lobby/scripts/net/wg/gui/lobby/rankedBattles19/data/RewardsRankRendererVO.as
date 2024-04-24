package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RewardsRankRendererVO extends DAAPIDataClass
   {
      
      private static const BONUSES_FIELD:String = "bonuses";
       
      
      public var state:String = "";
      
      public var rankID:int = -1;
      
      public var levelStr:String = "";
      
      public var tooltip:String = "";
      
      public var bonuses:Vector.<AwardItemRendererExVO> = null;
      
      public function RewardsRankRendererVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.bonuses)
         {
            for each(_loc1_ in this.bonuses)
            {
               _loc1_.dispose();
            }
            this.bonuses.splice(0,this.bonuses.length);
            this.bonuses = null;
            _loc1_ = null;
         }
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == BONUSES_FIELD)
         {
            if(param2)
            {
               _loc3_ = param2 as Array;
               if(_loc3_)
               {
                  this.bonuses = new Vector.<AwardItemRendererExVO>();
                  _loc4_ = _loc3_.length;
                  _loc5_ = 0;
                  while(_loc5_ < _loc4_)
                  {
                     this.bonuses.push(new AwardItemRendererExVO(_loc3_[_loc5_]));
                     _loc5_++;
                  }
               }
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}
