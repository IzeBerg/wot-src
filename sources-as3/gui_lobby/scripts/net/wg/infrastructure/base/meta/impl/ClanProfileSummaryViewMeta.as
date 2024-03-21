package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSummaryBlockVO;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSummaryLeaguesVO;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSummaryViewStatusVO;
   import net.wg.gui.lobby.clans.profile.views.ClanProfileBaseView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ClanProfileSummaryViewMeta extends ClanProfileBaseView
   {
       
      
      public var hyperLinkGotoMap:Function;
      
      public var hyperLinkGotoDetailsMap:Function;
      
      public var sendRequestHandler:Function;
      
      private var _clanProfileSummaryViewStatusVO:ClanProfileSummaryViewStatusVO;
      
      private var _clanProfileSummaryBlockVO:ClanProfileSummaryBlockVO;
      
      private var _clanProfileSummaryBlockVO1:ClanProfileSummaryBlockVO;
      
      private var _clanProfileSummaryBlockVO2:ClanProfileSummaryBlockVO;
      
      private var _clanProfileSummaryLeaguesVO:ClanProfileSummaryLeaguesVO;
      
      public function ClanProfileSummaryViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._clanProfileSummaryViewStatusVO)
         {
            this._clanProfileSummaryViewStatusVO.dispose();
            this._clanProfileSummaryViewStatusVO = null;
         }
         if(this._clanProfileSummaryBlockVO)
         {
            this._clanProfileSummaryBlockVO.dispose();
            this._clanProfileSummaryBlockVO = null;
         }
         if(this._clanProfileSummaryBlockVO1)
         {
            this._clanProfileSummaryBlockVO1.dispose();
            this._clanProfileSummaryBlockVO1 = null;
         }
         if(this._clanProfileSummaryBlockVO2)
         {
            this._clanProfileSummaryBlockVO2.dispose();
            this._clanProfileSummaryBlockVO2 = null;
         }
         if(this._clanProfileSummaryLeaguesVO)
         {
            this._clanProfileSummaryLeaguesVO.dispose();
            this._clanProfileSummaryLeaguesVO = null;
         }
         super.onDispose();
      }
      
      public function hyperLinkGotoMapS() : void
      {
         App.utils.asserter.assertNotNull(this.hyperLinkGotoMap,"hyperLinkGotoMap" + Errors.CANT_NULL);
         this.hyperLinkGotoMap();
      }
      
      public function hyperLinkGotoDetailsMapS() : void
      {
         App.utils.asserter.assertNotNull(this.hyperLinkGotoDetailsMap,"hyperLinkGotoDetailsMap" + Errors.CANT_NULL);
         this.hyperLinkGotoDetailsMap();
      }
      
      public function sendRequestHandlerS() : void
      {
         App.utils.asserter.assertNotNull(this.sendRequestHandler,"sendRequestHandler" + Errors.CANT_NULL);
         this.sendRequestHandler();
      }
      
      public final function as_updateStatus(param1:Object) : void
      {
         var _loc2_:ClanProfileSummaryViewStatusVO = this._clanProfileSummaryViewStatusVO;
         this._clanProfileSummaryViewStatusVO = new ClanProfileSummaryViewStatusVO(param1);
         this.updateStatus(this._clanProfileSummaryViewStatusVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateGeneralBlock(param1:Object) : void
      {
         var _loc2_:ClanProfileSummaryBlockVO = this._clanProfileSummaryBlockVO;
         this._clanProfileSummaryBlockVO = new ClanProfileSummaryBlockVO(param1);
         this.updateGeneralBlock(this._clanProfileSummaryBlockVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateFortBlock(param1:Object) : void
      {
         var _loc2_:ClanProfileSummaryBlockVO = this._clanProfileSummaryBlockVO1;
         this._clanProfileSummaryBlockVO1 = new ClanProfileSummaryBlockVO(param1);
         this.updateFortBlock(this._clanProfileSummaryBlockVO1);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateGlobalMapBlock(param1:Object) : void
      {
         var _loc2_:ClanProfileSummaryBlockVO = this._clanProfileSummaryBlockVO2;
         this._clanProfileSummaryBlockVO2 = new ClanProfileSummaryBlockVO(param1);
         this.updateGlobalMapBlock(this._clanProfileSummaryBlockVO2);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateLeaguesBlock(param1:Object) : void
      {
         var _loc2_:ClanProfileSummaryLeaguesVO = this._clanProfileSummaryLeaguesVO;
         this._clanProfileSummaryLeaguesVO = new ClanProfileSummaryLeaguesVO(param1);
         this.updateLeaguesBlock(this._clanProfileSummaryLeaguesVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function updateStatus(param1:ClanProfileSummaryViewStatusVO) : void
      {
         var _loc2_:String = "as_updateStatus" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateGeneralBlock(param1:ClanProfileSummaryBlockVO) : void
      {
         var _loc2_:String = "as_updateGeneralBlock" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateFortBlock(param1:ClanProfileSummaryBlockVO) : void
      {
         var _loc2_:String = "as_updateFortBlock" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateGlobalMapBlock(param1:ClanProfileSummaryBlockVO) : void
      {
         var _loc2_:String = "as_updateGlobalMapBlock" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateLeaguesBlock(param1:ClanProfileSummaryLeaguesVO) : void
      {
         var _loc2_:String = "as_updateLeaguesBlock" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
