package net.wg.gui.battle.comp7.infrastructure
{
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   import net.wg.gui.battle.comp7.VO.daapi.Comp7DAAPIVehiclesDataVO;
   import net.wg.gui.battle.comp7.VO.daapi.Comp7InterestPointVO;
   import net.wg.gui.battle.comp7.infrastructure.interfaces.IPoiContainer;
   import net.wg.infrastructure.base.meta.IComp7BattleStatisticDataControllerMeta;
   import net.wg.infrastructure.base.meta.impl.Comp7BattleStatisticDataControllerMeta;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
   
   public class Comp7StatisticsDataController extends Comp7BattleStatisticDataControllerMeta implements IComp7BattleStatisticDataControllerMeta
   {
       
      
      private var _poiContainers:Vector.<IPoiContainer>;
      
      public function Comp7StatisticsDataController()
      {
         this._poiContainers = new Vector.<IPoiContainer>();
         super();
      }
      
      override public function registerComponentController(param1:IBattleComponentDataController) : void
      {
         super.registerComponentController(param1);
         if(param1 is IPoiContainer)
         {
            this._poiContainers.push(IPoiContainer(param1));
         }
      }
      
      override protected function updatePointOfInterest(param1:Comp7InterestPointVO) : void
      {
         var _loc2_:IPoiContainer = null;
         for each(_loc2_ in this._poiContainers)
         {
            _loc2_.updatePointOfInterest(param1);
         }
      }
      
      override protected function onDispose() : void
      {
         this._poiContainers.length = 0;
         this._poiContainers = null;
         super.onDispose();
      }
      
      override protected function getDAAPIVehiclesDataVOForVehData(param1:Object) : DAAPIVehiclesDataVO
      {
         return new Comp7DAAPIVehiclesDataVO(param1);
      }
      
      public function as_removePointOfInterest(param1:uint, param2:uint) : void
      {
         var _loc3_:IPoiContainer = null;
         for each(_loc3_ in this._poiContainers)
         {
            _loc3_.removePointOfInterest(param1,param2);
         }
      }
   }
}
