package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.views.epicRespawnView.data.RespawnPointVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EpicRespawnViewMeta extends BattleDisplayable
   {
       
      
      public var onLocationSelected:Function;
      
      public var onRespawnBtnClick:Function;
      
      public var onDeploymentReady:Function;
      
      private var _vectorRespawnPointVO:Vector.<RespawnPointVO>;
      
      public function EpicRespawnViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:RespawnPointVO = null;
         if(this._vectorRespawnPointVO)
         {
            for each(_loc1_ in this._vectorRespawnPointVO)
            {
               _loc1_.dispose();
            }
            this._vectorRespawnPointVO.splice(0,this._vectorRespawnPointVO.length);
            this._vectorRespawnPointVO = null;
         }
         super.onDispose();
      }
      
      public function onLocationSelectedS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onLocationSelected,"onLocationSelected" + Errors.CANT_NULL);
         this.onLocationSelected(param1);
      }
      
      public function onRespawnBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onRespawnBtnClick,"onRespawnBtnClick" + Errors.CANT_NULL);
         this.onRespawnBtnClick();
      }
      
      public function onDeploymentReadyS() : void
      {
         App.utils.asserter.assertNotNull(this.onDeploymentReady,"onDeploymentReady" + Errors.CANT_NULL);
         this.onDeploymentReady();
      }
      
      public final function as_setRespawnLocations(param1:Array) : void
      {
         var _loc5_:RespawnPointVO = null;
         var _loc2_:Vector.<RespawnPointVO> = this._vectorRespawnPointVO;
         this._vectorRespawnPointVO = new Vector.<RespawnPointVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorRespawnPointVO[_loc4_] = new RespawnPointVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setRespawnLocations(this._vectorRespawnPointVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setRespawnLocations(param1:Vector.<RespawnPointVO>) : void
      {
         var _loc2_:String = "as_setRespawnLocations" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
