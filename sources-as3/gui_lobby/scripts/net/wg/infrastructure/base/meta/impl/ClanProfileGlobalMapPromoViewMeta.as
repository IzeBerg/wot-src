package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileGlobalMapPromoVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ClanProfileGlobalMapPromoViewMeta extends BaseDAAPIComponent
   {
       
      
      public var showInfo:Function;
      
      public var showMap:Function;
      
      private var _clanProfileGlobalMapPromoVO:ClanProfileGlobalMapPromoVO;
      
      public function ClanProfileGlobalMapPromoViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._clanProfileGlobalMapPromoVO)
         {
            this._clanProfileGlobalMapPromoVO.dispose();
            this._clanProfileGlobalMapPromoVO = null;
         }
         super.onDispose();
      }
      
      public function showInfoS() : void
      {
         App.utils.asserter.assertNotNull(this.showInfo,"showInfo" + Errors.CANT_NULL);
         this.showInfo();
      }
      
      public function showMapS() : void
      {
         App.utils.asserter.assertNotNull(this.showMap,"showMap" + Errors.CANT_NULL);
         this.showMap();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:ClanProfileGlobalMapPromoVO = this._clanProfileGlobalMapPromoVO;
         this._clanProfileGlobalMapPromoVO = new ClanProfileGlobalMapPromoVO(param1);
         this.setData(this._clanProfileGlobalMapPromoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:ClanProfileGlobalMapPromoVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
