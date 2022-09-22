package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RankedBattlesCurrentAwardVO extends DAAPIDataClass
   {
      
      private static const RANK_FIELD:String = "rankVO";
      
      private static const QUAL_FIELD:String = "qualVO";
      
      private static const DIVISION_FIELD:String = "divisionVO";
      
      private static const AWARDS_FIELD:String = "awards";
       
      
      public var rankVO:RankIconVO = null;
      
      public var qualVO:AwardDivisionBaseVO = null;
      
      public var divisionVO:AwardDivisionVO = null;
      
      public var awards:Vector.<AwardItemRendererExVO> = null;
      
      public var state:String = "";
      
      public var subTitle:String = "";
      
      public var bonusBattleText:String = "";
      
      public var bonusBattleTooltip:String = "";
      
      public function RankedBattlesCurrentAwardVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param2)
         {
            if(param1 == AWARDS_FIELD)
            {
               _loc3_ = param2 as Array;
               App.utils.asserter.assertNotNull(_loc3_,AWARDS_FIELD + Errors.CANT_NULL);
               this.awards = new Vector.<AwardItemRendererExVO>(0);
               for each(_loc4_ in param2)
               {
                  this.awards.push(new AwardItemRendererExVO(_loc4_));
               }
               return false;
            }
            if(param1 == RANK_FIELD)
            {
               this.rankVO = new RankIconVO(param2);
               return false;
            }
            if(param1 == QUAL_FIELD)
            {
               this.qualVO = new AwardDivisionBaseVO(param2);
               return false;
            }
            if(param1 == DIVISION_FIELD)
            {
               this.divisionVO = new AwardDivisionVO(param2);
               return false;
            }
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.awards != null)
         {
            for each(_loc1_ in this.awards)
            {
               _loc1_.dispose();
            }
            this.awards.length = 0;
            this.awards = null;
         }
         if(this.rankVO != null)
         {
            this.rankVO.dispose();
            this.rankVO = null;
         }
         if(this.qualVO != null)
         {
            this.qualVO.dispose();
            this.qualVO = null;
         }
         if(this.divisionVO != null)
         {
            this.divisionVO.dispose();
            this.divisionVO = null;
         }
         super.onDispose();
      }
   }
}
