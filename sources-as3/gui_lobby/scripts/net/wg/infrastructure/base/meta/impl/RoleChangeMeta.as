package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.lobby.tankman.vo.RoleChangeItemVO;
   import net.wg.gui.lobby.tankman.vo.RoleChangeVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RoleChangeMeta extends AbstractWindowView
   {
       
      
      public var onVehicleSelected:Function;
      
      public var changeRole:Function;
      
      private var _roleChangeVO:RoleChangeVO;
      
      private var _arrayRoleChangeItemVO:Array;
      
      private var _actionPriceVO:ActionPriceVO;
      
      public function RoleChangeMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:RoleChangeItemVO = null;
         if(this._roleChangeVO)
         {
            this._roleChangeVO.dispose();
            this._roleChangeVO = null;
         }
         if(this._arrayRoleChangeItemVO)
         {
            for each(_loc1_ in this._arrayRoleChangeItemVO)
            {
               _loc1_.dispose();
            }
            this._arrayRoleChangeItemVO.splice(0,this._arrayRoleChangeItemVO.length);
            this._arrayRoleChangeItemVO = null;
         }
         if(this._actionPriceVO)
         {
            this._actionPriceVO.dispose();
            this._actionPriceVO = null;
         }
         super.onDispose();
      }
      
      public function onVehicleSelectedS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onVehicleSelected,"onVehicleSelected" + Errors.CANT_NULL);
         this.onVehicleSelected(param1);
      }
      
      public function changeRoleS(param1:String, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.changeRole,"changeRole" + Errors.CANT_NULL);
         this.changeRole(param1,param2);
      }
      
      public final function as_setCommonData(param1:Object) : void
      {
         var _loc2_:RoleChangeVO = this._roleChangeVO;
         this._roleChangeVO = new RoleChangeVO(param1);
         this.setCommonData(this._roleChangeVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setRoles(param1:Array) : void
      {
         var _loc5_:RoleChangeItemVO = null;
         var _loc2_:Array = this._arrayRoleChangeItemVO;
         this._arrayRoleChangeItemVO = [];
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._arrayRoleChangeItemVO[_loc4_] = new RoleChangeItemVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setRoles(this._arrayRoleChangeItemVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setPrice(param1:String, param2:Object) : void
      {
         var _loc3_:ActionPriceVO = this._actionPriceVO;
         this._actionPriceVO = new ActionPriceVO(param2);
         this.setPrice(param1,this._actionPriceVO);
         if(_loc3_)
         {
            _loc3_.dispose();
         }
      }
      
      protected function setCommonData(param1:RoleChangeVO) : void
      {
         var _loc2_:String = "as_setCommonData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setRoles(param1:Array) : void
      {
         var _loc2_:String = "as_setRoles" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setPrice(param1:String, param2:ActionPriceVO) : void
      {
         var _loc3_:String = "as_setPrice" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
