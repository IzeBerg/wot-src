package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.gui.lobby.clans.search.VOs.ClanSearchInfoDataVO;
   import net.wg.gui.lobby.clans.search.VOs.ClanSearchInfoInitDataVO;
   import net.wg.gui.lobby.clans.search.VOs.ClanSearchInfoStateDataVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ClanSearchInfoMeta extends BaseDAAPIComponent
   {
       
      
      public var sendRequest:Function;
      
      public var openClanProfile:Function;
      
      public var requestData:Function;
      
      private var _clanSearchInfoInitDataVO:ClanSearchInfoInitDataVO;
      
      private var _clanSearchInfoDataVO:ClanSearchInfoDataVO;
      
      private var _clanSearchInfoStateDataVO:ClanSearchInfoStateDataVO;
      
      private var _dummyVO:DummyVO;
      
      public function ClanSearchInfoMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._clanSearchInfoInitDataVO)
         {
            this._clanSearchInfoInitDataVO.dispose();
            this._clanSearchInfoInitDataVO = null;
         }
         if(this._clanSearchInfoDataVO)
         {
            this._clanSearchInfoDataVO.dispose();
            this._clanSearchInfoDataVO = null;
         }
         if(this._clanSearchInfoStateDataVO)
         {
            this._clanSearchInfoStateDataVO.dispose();
            this._clanSearchInfoStateDataVO = null;
         }
         if(this._dummyVO)
         {
            this._dummyVO.dispose();
            this._dummyVO = null;
         }
         super.onDispose();
      }
      
      public function sendRequestS() : void
      {
         App.utils.asserter.assertNotNull(this.sendRequest,"sendRequest" + Errors.CANT_NULL);
         this.sendRequest();
      }
      
      public function openClanProfileS() : void
      {
         App.utils.asserter.assertNotNull(this.openClanProfile,"openClanProfile" + Errors.CANT_NULL);
         this.openClanProfile();
      }
      
      public function requestDataS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.requestData,"requestData" + Errors.CANT_NULL);
         this.requestData(param1);
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:ClanSearchInfoInitDataVO = this._clanSearchInfoInitDataVO;
         this._clanSearchInfoInitDataVO = new ClanSearchInfoInitDataVO(param1);
         this.setInitData(this._clanSearchInfoInitDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:ClanSearchInfoDataVO = this._clanSearchInfoDataVO;
         this._clanSearchInfoDataVO = new ClanSearchInfoDataVO(param1);
         this.setData(this._clanSearchInfoDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setStateData(param1:Object) : void
      {
         var _loc2_:ClanSearchInfoStateDataVO = this._clanSearchInfoStateDataVO;
         this._clanSearchInfoStateDataVO = new ClanSearchInfoStateDataVO(param1);
         this.setStateData(this._clanSearchInfoStateDataVO);
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
      
      protected function setInitData(param1:ClanSearchInfoInitDataVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setData(param1:ClanSearchInfoDataVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setStateData(param1:ClanSearchInfoStateDataVO) : void
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
