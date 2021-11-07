package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.gui.lobby.clans.invites.VOs.ClanInvitesViewVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ClanInvitesViewWithTableMeta extends BaseDAAPIComponent
   {
       
      
      public var showMore:Function;
      
      public var refreshTable:Function;
      
      private var _clanInvitesViewVO:ClanInvitesViewVO;
      
      private var _dummyVO:DummyVO;
      
      public function ClanInvitesViewWithTableMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._clanInvitesViewVO)
         {
            this._clanInvitesViewVO.dispose();
            this._clanInvitesViewVO = null;
         }
         if(this._dummyVO)
         {
            this._dummyVO.dispose();
            this._dummyVO = null;
         }
         super.onDispose();
      }
      
      public function showMoreS() : void
      {
         App.utils.asserter.assertNotNull(this.showMore,"showMore" + Errors.CANT_NULL);
         this.showMore();
      }
      
      public function refreshTableS() : void
      {
         App.utils.asserter.assertNotNull(this.refreshTable,"refreshTable" + Errors.CANT_NULL);
         this.refreshTable();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:ClanInvitesViewVO = this._clanInvitesViewVO;
         this._clanInvitesViewVO = this.getClanInvitesViewVOForData(param1);
         this.setData(this._clanInvitesViewVO);
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
      
      protected function getClanInvitesViewVOForData(param1:Object) : ClanInvitesViewVO
      {
         var _loc2_:String = "getClanInvitesViewVOForData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setData(param1:ClanInvitesViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
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
