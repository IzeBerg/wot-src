package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.gui.lobby.clans.common.ClanBaseInfoVO;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileHeaderStateVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ClanProfileBaseViewMeta extends BaseDAAPIComponent
   {
       
      
      public var onHeaderButtonClick:Function;
      
      public var viewSize:Function;
      
      private var _clanBaseInfoVO:ClanBaseInfoVO;
      
      private var _clanProfileHeaderStateVO:ClanProfileHeaderStateVO;
      
      private var _dummyVO:DummyVO;
      
      public function ClanProfileBaseViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._clanBaseInfoVO)
         {
            this._clanBaseInfoVO.dispose();
            this._clanBaseInfoVO = null;
         }
         if(this._clanProfileHeaderStateVO)
         {
            this._clanProfileHeaderStateVO.dispose();
            this._clanProfileHeaderStateVO = null;
         }
         if(this._dummyVO)
         {
            this._dummyVO.dispose();
            this._dummyVO = null;
         }
         super.onDispose();
      }
      
      public function onHeaderButtonClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onHeaderButtonClick,"onHeaderButtonClick" + Errors.CANT_NULL);
         this.onHeaderButtonClick(param1);
      }
      
      public function viewSizeS(param1:Number, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.viewSize,"viewSize" + Errors.CANT_NULL);
         this.viewSize(param1,param2);
      }
      
      public final function as_setClanInfo(param1:Object) : void
      {
         var _loc2_:ClanBaseInfoVO = this._clanBaseInfoVO;
         this._clanBaseInfoVO = new ClanBaseInfoVO(param1);
         this.setClanInfo(this._clanBaseInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setHeaderState(param1:Object) : void
      {
         var _loc2_:ClanProfileHeaderStateVO = this._clanProfileHeaderStateVO;
         this._clanProfileHeaderStateVO = new ClanProfileHeaderStateVO(param1);
         this.setHeaderState(this._clanProfileHeaderStateVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_showDummy(param1:Object) : void
      {
         var _loc2_:DummyVO = this._dummyVO;
         this._dummyVO = new DummyVO(param1);
         this.showDummy(this._dummyVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setClanInfo(param1:ClanBaseInfoVO) : void
      {
         var _loc2_:String = "as_setClanInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setHeaderState(param1:ClanProfileHeaderStateVO) : void
      {
         var _loc2_:String = "as_setHeaderState" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function showDummy(param1:DummyVO) : void
      {
         var _loc2_:String = "as_showDummy" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
