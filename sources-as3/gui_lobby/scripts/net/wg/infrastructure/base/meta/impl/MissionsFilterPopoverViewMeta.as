package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.missions.data.MissionsFilterPopoverInitVO;
   import net.wg.gui.lobby.missions.data.MissionsFilterPopoverStateVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class MissionsFilterPopoverViewMeta extends SmartPopOverView
   {
       
      
      public var changeFilter:Function;
      
      public var setDefaultFilter:Function;
      
      private var _missionsFilterPopoverInitVO:MissionsFilterPopoverInitVO;
      
      private var _missionsFilterPopoverStateVO:MissionsFilterPopoverStateVO;
      
      public function MissionsFilterPopoverViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._missionsFilterPopoverInitVO)
         {
            this._missionsFilterPopoverInitVO.dispose();
            this._missionsFilterPopoverInitVO = null;
         }
         if(this._missionsFilterPopoverStateVO)
         {
            this._missionsFilterPopoverStateVO.dispose();
            this._missionsFilterPopoverStateVO = null;
         }
         super.onDispose();
      }
      
      public function changeFilterS(param1:Boolean, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.changeFilter,"changeFilter" + Errors.CANT_NULL);
         this.changeFilter(param1,param2);
      }
      
      public function setDefaultFilterS() : void
      {
         App.utils.asserter.assertNotNull(this.setDefaultFilter,"setDefaultFilter" + Errors.CANT_NULL);
         this.setDefaultFilter();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:MissionsFilterPopoverInitVO = this._missionsFilterPopoverInitVO;
         this._missionsFilterPopoverInitVO = new MissionsFilterPopoverInitVO(param1);
         this.setInitData(this._missionsFilterPopoverInitVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setState(param1:Object) : void
      {
         var _loc2_:MissionsFilterPopoverStateVO = this._missionsFilterPopoverStateVO;
         this._missionsFilterPopoverStateVO = new MissionsFilterPopoverStateVO(param1);
         this.setState(this._missionsFilterPopoverStateVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:MissionsFilterPopoverInitVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setState(param1:MissionsFilterPopoverStateVO) : void
      {
         var _loc2_:String = "as_setState" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
