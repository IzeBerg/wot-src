package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.random.views.BattlePage;
   import net.wg.gui.components.vehicleStatus.data.VehicleStatusVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class Comp7BattlePageMeta extends BattlePage
   {
       
      
      public var showHelp:Function;
      
      public var moveSpace:Function;
      
      public var notifyCursorOver3dScene:Function;
      
      public var notifyCursorDragging:Function;
      
      private var _vehicleStatusVO:VehicleStatusVO;
      
      public function Comp7BattlePageMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vehicleStatusVO)
         {
            this._vehicleStatusVO.dispose();
            this._vehicleStatusVO = null;
         }
         super.onDispose();
      }
      
      public function showHelpS() : void
      {
         App.utils.asserter.assertNotNull(this.showHelp,"showHelp" + Errors.CANT_NULL);
         this.showHelp();
      }
      
      public function moveSpaceS(param1:Number, param2:Number, param3:Number) : void
      {
         App.utils.asserter.assertNotNull(this.moveSpace,"moveSpace" + Errors.CANT_NULL);
         this.moveSpace(param1,param2,param3);
      }
      
      public function notifyCursorOver3dSceneS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.notifyCursorOver3dScene,"notifyCursorOver3dScene" + Errors.CANT_NULL);
         this.notifyCursorOver3dScene(param1);
      }
      
      public function notifyCursorDraggingS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.notifyCursorDragging,"notifyCursorDragging" + Errors.CANT_NULL);
         this.notifyCursorDragging(param1);
      }
      
      public final function as_updateVehicleStatus(param1:Object) : void
      {
         var _loc2_:VehicleStatusVO = this._vehicleStatusVO;
         this._vehicleStatusVO = new VehicleStatusVO(param1);
         this.updateVehicleStatus(this._vehicleStatusVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function updateVehicleStatus(param1:VehicleStatusVO) : void
      {
         var _loc2_:String = "as_updateVehicleStatus" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
