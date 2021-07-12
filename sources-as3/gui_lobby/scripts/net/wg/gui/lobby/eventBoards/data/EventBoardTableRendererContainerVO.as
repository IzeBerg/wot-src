package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.constants.generated.EVENTBOARDS_ALIASES;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class EventBoardTableRendererContainerVO extends DAAPIDataClass
   {
      
      private static const TABLE_DP:String = "tableDP";
       
      
      private var _tableDP:DataProvider = null;
      
      public function EventBoardTableRendererContainerVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:Class = null;
         if(param1 == TABLE_DP)
         {
            this._tableDP = new DataProvider();
            for each(_loc3_ in param2)
            {
               _loc4_ = _loc3_.rendererLinkage;
               switch(_loc4_)
               {
                  case EVENTBOARDS_ALIASES.AWARD_STRIPE_RENDERER:
                     _loc5_ = AwardStripeRendererVO;
                     break;
                  case EVENTBOARDS_ALIASES.BASE_PLAYER_AWARD_RENDERER:
                     _loc5_ = BasePlayerAwardRendererVO;
                     break;
                  case EVENTBOARDS_ALIASES.TOP_PLAYER_AWARD_RENDERER:
                     _loc5_ = TopPlayerAwardRendererVO;
                     break;
                  case EVENTBOARDS_ALIASES.BASE_PLAYER_BATTLE_RENDERER:
                     _loc5_ = BasePlayerBattleRendererVO;
                     break;
                  default:
                     App.utils.asserter.assert(false,"rendererLinkage contains an invalid value: " + _loc4_);
                     break;
               }
               this._tableDP.push(new _loc5_(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDAAPIDataClass = null;
         for each(_loc1_ in this._tableDP)
         {
            _loc1_.dispose();
         }
         this._tableDP.cleanUp();
         this._tableDP = null;
         super.onDispose();
      }
      
      public function get tableDP() : DataProvider
      {
         return this._tableDP;
      }
   }
}
