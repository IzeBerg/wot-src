package net.wg.gui.battle.epicBattle.views.data
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.battleloading.interfaces.IVehiclesDataProvider;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehicleStatsVO;
   import net.wg.infrastructure.events.ListDataProviderEvent;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EpicStatsDataProviderBaseCtrl implements IDisposable
   {
      
      private static const UPDATE_TEAM_ALLY_CALL_ASSERTION:String = "updateTeamDPItems" + Errors.ABSTRACT_INVOKE;
      
      private static const UPDATE_TEAM_ENEMY_CALL_ASSERTION:String = "updateEnemyDPItems" + Errors.ABSTRACT_INVOKE;
       
      
      protected var teamDP:EpicVehicleDataProvider;
      
      protected var enemyDP:EpicVehicleDataProvider;
      
      private var _allyOrder:Vector.<Number> = null;
      
      private var _enemyOrder:Vector.<Number> = null;
      
      public function EpicStatsDataProviderBaseCtrl()
      {
         super();
         this._allyOrder = new Vector.<Number>();
         this._enemyOrder = new Vector.<Number>();
         this.teamDP = new EpicVehicleDataProvider();
         this.teamDP.addEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onTeamDPValidateItemsHandler);
         this.enemyDP = new EpicVehicleDataProvider();
         this.enemyDP.addEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onEnemyDPValidateItemsHandler);
      }
      
      public function addVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>) : void
      {
         var _loc4_:IVehiclesDataProvider = !!param1 ? this.enemyDP : this.teamDP;
         if(_loc4_.addVehiclesInfo(param2,param3))
         {
            _loc4_.invalidate();
         }
         this.updateOrder(param3,param1);
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function setEpicVehiclesStats(param1:Boolean, param2:Vector.<EpicVehicleStatsVO>, param3:Vector.<Number>) : void
      {
         var _loc4_:EpicVehicleDataProvider = !!param1 ? this.enemyDP : this.teamDP;
         this.updateOrder(param3,param1);
         if(_loc4_.updateEpicStats(param2))
         {
            _loc4_.invalidate();
         }
      }
      
      public function setPlayerStatus(param1:Boolean, param2:Number, param3:uint) : void
      {
         var _loc4_:IVehiclesDataProvider = !!param1 ? this.enemyDP : this.teamDP;
         if(_loc4_.setPlayerStatus(param2,param3))
         {
            _loc4_.invalidate();
         }
      }
      
      public function setUserTags(param1:Boolean, param2:Vector.<DAAPIVehicleUserTagsVO>) : void
      {
         var _loc3_:IVehiclesDataProvider = !!param1 ? this.enemyDP : this.teamDP;
         if(_loc3_.setUserTags(param2))
         {
            _loc3_.invalidate();
         }
      }
      
      public function setVehicleStatus(param1:Boolean, param2:Number, param3:uint, param4:Vector.<Number>) : void
      {
         var _loc5_:IVehiclesDataProvider = !!param1 ? this.enemyDP : this.teamDP;
         var _loc6_:Boolean = _loc5_.setVehicleStatus(param2,param3);
         if(_loc6_)
         {
            _loc5_.invalidate();
         }
      }
      
      public function setVehiclesData(param1:Array, param2:Vector.<Number>, param3:Boolean) : void
      {
         var _loc4_:IVehiclesDataProvider = !!param3 ? this.enemyDP : this.teamDP;
         _loc4_.setSource(param1);
         _loc4_.invalidate();
      }
      
      public function sortVehicles() : void
      {
         if(this.enemyDP.setSorting(this._enemyOrder))
         {
            this.enemyDP.invalidate();
         }
         if(this.teamDP.setSorting(this._allyOrder))
         {
            this.teamDP.invalidate();
         }
      }
      
      public function updateVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>) : void
      {
         var _loc4_:IVehiclesDataProvider = !!param1 ? this.enemyDP : this.teamDP;
         var _loc5_:Boolean = _loc4_.updateVehiclesInfo(param2);
         if(_loc5_)
         {
            _loc4_.invalidate();
         }
      }
      
      protected function onDispose() : void
      {
         if(this._enemyOrder)
         {
            this._enemyOrder.splice(0,this._enemyOrder.length);
            this._enemyOrder = null;
         }
         if(this._allyOrder)
         {
            this._allyOrder.splice(0,this._allyOrder.length);
            this._allyOrder = null;
         }
         this.teamDP.removeEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onTeamDPValidateItemsHandler);
         this.teamDP.cleanUp();
         this.teamDP = null;
         this.enemyDP.removeEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onEnemyDPValidateItemsHandler);
         this.enemyDP.cleanUp();
         this.enemyDP = null;
      }
      
      private function updateOrder(param1:Vector.<Number>, param2:Boolean) : void
      {
         if(param1 && param1.length > 0)
         {
            if(param2)
            {
               this._enemyOrder = param1.slice();
            }
            else
            {
               this._allyOrder = param1.slice();
            }
         }
      }
      
      protected function updateTeamDPItems(param1:ListDataProviderEvent) : void
      {
         DebugUtils.LOG_ERROR(UPDATE_TEAM_ALLY_CALL_ASSERTION);
         throw new AbstractException(UPDATE_TEAM_ALLY_CALL_ASSERTION);
      }
      
      protected function updateEnemyDPItems(param1:ListDataProviderEvent) : void
      {
         DebugUtils.LOG_ERROR(UPDATE_TEAM_ENEMY_CALL_ASSERTION);
         throw new AbstractException(UPDATE_TEAM_ENEMY_CALL_ASSERTION);
      }
      
      private function onTeamDPValidateItemsHandler(param1:ListDataProviderEvent) : void
      {
         this.updateTeamDPItems(param1);
      }
      
      private function onEnemyDPValidateItemsHandler(param1:ListDataProviderEvent) : void
      {
         this.updateEnemyDPItems(param1);
      }
   }
}
