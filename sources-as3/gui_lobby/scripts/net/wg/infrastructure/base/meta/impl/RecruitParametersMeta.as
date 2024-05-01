package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.vo.RecruitParametersVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RecruitParametersMeta extends BaseDAAPIComponent
   {
       
      
      public var onNationChanged:Function;
      
      public var onVehicleClassChanged:Function;
      
      public var onVehicleChanged:Function;
      
      public var onTankmanRoleChanged:Function;
      
      public var setPredefinedTankman:Function;
      
      private var _recruitParametersVO:RecruitParametersVO;
      
      private var _recruitParametersVO1:RecruitParametersVO;
      
      private var _recruitParametersVO2:RecruitParametersVO;
      
      private var _recruitParametersVO3:RecruitParametersVO;
      
      public function RecruitParametersMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._recruitParametersVO)
         {
            this._recruitParametersVO.dispose();
            this._recruitParametersVO = null;
         }
         if(this._recruitParametersVO1)
         {
            this._recruitParametersVO1.dispose();
            this._recruitParametersVO1 = null;
         }
         if(this._recruitParametersVO2)
         {
            this._recruitParametersVO2.dispose();
            this._recruitParametersVO2 = null;
         }
         if(this._recruitParametersVO3)
         {
            this._recruitParametersVO3.dispose();
            this._recruitParametersVO3 = null;
         }
         super.onDispose();
      }
      
      public function onNationChangedS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onNationChanged,"onNationChanged" + Errors.CANT_NULL);
         this.onNationChanged(param1);
      }
      
      public function onVehicleClassChangedS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onVehicleClassChanged,"onVehicleClassChanged" + Errors.CANT_NULL);
         this.onVehicleClassChanged(param1);
      }
      
      public function onVehicleChangedS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onVehicleChanged,"onVehicleChanged" + Errors.CANT_NULL);
         this.onVehicleChanged(param1);
      }
      
      public function onTankmanRoleChangedS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onTankmanRoleChanged,"onTankmanRoleChanged" + Errors.CANT_NULL);
         this.onTankmanRoleChanged(param1);
      }
      
      public function setPredefinedTankmanS(param1:Object) : void
      {
         App.utils.asserter.assertNotNull(this.setPredefinedTankman,"setPredefinedTankman" + Errors.CANT_NULL);
         this.setPredefinedTankman(param1);
      }
      
      public final function as_setVehicleClassData(param1:Object) : void
      {
         var _loc2_:RecruitParametersVO = this._recruitParametersVO;
         this._recruitParametersVO = new RecruitParametersVO(param1);
         this.setVehicleClassData(this._recruitParametersVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setVehicleData(param1:Object) : void
      {
         var _loc2_:RecruitParametersVO = this._recruitParametersVO1;
         this._recruitParametersVO1 = new RecruitParametersVO(param1);
         this.setVehicleData(this._recruitParametersVO1);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setTankmanRoleData(param1:Object) : void
      {
         var _loc2_:RecruitParametersVO = this._recruitParametersVO2;
         this._recruitParametersVO2 = new RecruitParametersVO(param1);
         this.setTankmanRoleData(this._recruitParametersVO2);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setNationsData(param1:Object) : void
      {
         var _loc2_:RecruitParametersVO = this._recruitParametersVO3;
         this._recruitParametersVO3 = new RecruitParametersVO(param1);
         this.setNationsData(this._recruitParametersVO3);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setVehicleClassData(param1:RecruitParametersVO) : void
      {
         var _loc2_:String = "as_setVehicleClassData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setVehicleData(param1:RecruitParametersVO) : void
      {
         var _loc2_:String = "as_setVehicleData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setTankmanRoleData(param1:RecruitParametersVO) : void
      {
         var _loc2_:String = "as_setTankmanRoleData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setNationsData(param1:RecruitParametersVO) : void
      {
         var _loc2_:String = "as_setNationsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
