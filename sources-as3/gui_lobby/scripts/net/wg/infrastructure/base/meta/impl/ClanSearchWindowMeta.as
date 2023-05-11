package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.gui.lobby.clans.search.VOs.ClanSearchWindowInitDataVO;
   import net.wg.gui.lobby.clans.search.VOs.ClanSearchWindowStateDataVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ClanSearchWindowMeta extends AbstractWindowView
   {
       
      
      public var search:Function;
      
      public var previousPage:Function;
      
      public var nextPage:Function;
      
      public var dummyButtonPress:Function;
      
      private var _clanSearchWindowInitDataVO:ClanSearchWindowInitDataVO;
      
      private var _clanSearchWindowStateDataVO:ClanSearchWindowStateDataVO;
      
      private var _dummyVO:DummyVO;
      
      public function ClanSearchWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._clanSearchWindowInitDataVO)
         {
            this._clanSearchWindowInitDataVO.dispose();
            this._clanSearchWindowInitDataVO = null;
         }
         if(this._clanSearchWindowStateDataVO)
         {
            this._clanSearchWindowStateDataVO.dispose();
            this._clanSearchWindowStateDataVO = null;
         }
         if(this._dummyVO)
         {
            this._dummyVO.dispose();
            this._dummyVO = null;
         }
         super.onDispose();
      }
      
      public function searchS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.search,"search" + Errors.CANT_NULL);
         this.search(param1);
      }
      
      public function previousPageS() : void
      {
         App.utils.asserter.assertNotNull(this.previousPage,"previousPage" + Errors.CANT_NULL);
         this.previousPage();
      }
      
      public function nextPageS() : void
      {
         App.utils.asserter.assertNotNull(this.nextPage,"nextPage" + Errors.CANT_NULL);
         this.nextPage();
      }
      
      public function dummyButtonPressS() : void
      {
         App.utils.asserter.assertNotNull(this.dummyButtonPress,"dummyButtonPress" + Errors.CANT_NULL);
         this.dummyButtonPress();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:ClanSearchWindowInitDataVO = this._clanSearchWindowInitDataVO;
         this._clanSearchWindowInitDataVO = new ClanSearchWindowInitDataVO(param1);
         this.setInitData(this._clanSearchWindowInitDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setStateData(param1:Object) : void
      {
         var _loc2_:ClanSearchWindowStateDataVO = this._clanSearchWindowStateDataVO;
         this._clanSearchWindowStateDataVO = new ClanSearchWindowStateDataVO(param1);
         this.setStateData(this._clanSearchWindowStateDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
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
      
      protected function setInitData(param1:ClanSearchWindowInitDataVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setStateData(param1:ClanSearchWindowStateDataVO) : void
      {
         var _loc2_:String = "as_setStateData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setDummy(param1:DummyVO) : void
      {
         var _loc2_:String = "as_setDummy" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
