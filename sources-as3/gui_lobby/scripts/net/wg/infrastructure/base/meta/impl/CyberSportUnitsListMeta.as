package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.gui.cyberSport.vo.NavigationBlockVO;
   import net.wg.gui.cyberSport.vo.UnitListViewHeaderVO;
   import net.wg.gui.rally.views.list.BaseRallyListView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CyberSportUnitsListMeta extends BaseRallyListView
   {
       
      
      public var getTeamData:Function;
      
      public var refreshTeams:Function;
      
      public var filterVehicles:Function;
      
      public var loadPrevious:Function;
      
      public var loadNext:Function;
      
      private var _dummyVO:DummyVO;
      
      private var _unitListViewHeaderVO:UnitListViewHeaderVO;
      
      private var _navigationBlockVO:NavigationBlockVO;
      
      public function CyberSportUnitsListMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._dummyVO)
         {
            this._dummyVO.dispose();
            this._dummyVO = null;
         }
         if(this._unitListViewHeaderVO)
         {
            this._unitListViewHeaderVO.dispose();
            this._unitListViewHeaderVO = null;
         }
         if(this._navigationBlockVO)
         {
            this._navigationBlockVO.dispose();
            this._navigationBlockVO = null;
         }
         super.onDispose();
      }
      
      public function getTeamDataS(param1:int) : Object
      {
         App.utils.asserter.assertNotNull(this.getTeamData,"getTeamData" + Errors.CANT_NULL);
         return this.getTeamData(param1);
      }
      
      public function refreshTeamsS() : void
      {
         App.utils.asserter.assertNotNull(this.refreshTeams,"refreshTeams" + Errors.CANT_NULL);
         this.refreshTeams();
      }
      
      public function filterVehiclesS() : void
      {
         App.utils.asserter.assertNotNull(this.filterVehicles,"filterVehicles" + Errors.CANT_NULL);
         this.filterVehicles();
      }
      
      public function loadPreviousS() : void
      {
         App.utils.asserter.assertNotNull(this.loadPrevious,"loadPrevious" + Errors.CANT_NULL);
         this.loadPrevious();
      }
      
      public function loadNextS() : void
      {
         App.utils.asserter.assertNotNull(this.loadNext,"loadNext" + Errors.CANT_NULL);
         this.loadNext();
      }
      
      public final function as_setDummy(param1:Object) : void
      {
         var _loc2_:DummyVO = this._dummyVO;
         this._dummyVO = new DummyVO(param1);
         this.setDummy(this._dummyVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setHeader(param1:Object) : void
      {
         var _loc2_:UnitListViewHeaderVO = this._unitListViewHeaderVO;
         this._unitListViewHeaderVO = new UnitListViewHeaderVO(param1);
         this.setHeader(this._unitListViewHeaderVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateNavigationBlock(param1:Object) : void
      {
         var _loc2_:NavigationBlockVO = this._navigationBlockVO;
         this._navigationBlockVO = new NavigationBlockVO(param1);
         this.updateNavigationBlock(this._navigationBlockVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setDummy(param1:DummyVO) : void
      {
         var _loc2_:String = "as_setDummy" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setHeader(param1:UnitListViewHeaderVO) : void
      {
         var _loc2_:String = "as_setHeader" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateNavigationBlock(param1:NavigationBlockVO) : void
      {
         var _loc2_:String = "as_updateNavigationBlock" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
