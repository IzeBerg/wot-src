package net.wg.gui.lobby.missions.data
{
   import net.wg.data.constants.generated.MISSIONS_ALIASES;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class MissionConditionDetailsVO extends MissionDetailsPopUpPanelVO
   {
      
      private static const PROGRESS_LIST:String = "list";
       
      
      private var _list:DataProvider;
      
      public function MissionConditionDetailsVO(param1:Object = null)
      {
         rendererLinkage = param1.rendererLinkage;
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Class = null;
         var _loc4_:Object = null;
         if(param1 == PROGRESS_LIST)
         {
            this._list = new DataProvider();
            switch(rendererLinkage)
            {
               case MISSIONS_ALIASES.VEHICLE_ITEM_RENDERER:
                  _loc3_ = MissionVehicleItemRendererVO;
                  break;
               case MISSIONS_ALIASES.VEHICLE_TYPE_RENDERER:
                  _loc3_ = MissionVehicleTypeRendererVO;
                  break;
               case MISSIONS_ALIASES.ACHIEVEMENT_RENDERER:
                  _loc3_ = MissionDetailsAchievementRendererVO;
                  break;
               default:
                  App.utils.asserter.assert(false,"rendererLinkage contains an invalid value: " + rendererLinkage);
            }
            for each(_loc4_ in param2)
            {
               this._list.push(new _loc3_(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this._list != null)
         {
            for each(_loc1_ in this._list)
            {
               _loc1_.dispose();
            }
            this._list.cleanUp();
            this._list = null;
         }
         super.onDispose();
      }
      
      public function get conditionList() : IDataProvider
      {
         return this._list;
      }
   }
}
