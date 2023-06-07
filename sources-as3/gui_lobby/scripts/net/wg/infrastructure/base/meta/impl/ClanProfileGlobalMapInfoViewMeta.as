package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileGlobalMapInfoVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ClanProfileGlobalMapInfoViewMeta extends BaseDAAPIComponent
   {
       
      
      private var _clanProfileGlobalMapInfoVO:ClanProfileGlobalMapInfoVO;
      
      public function ClanProfileGlobalMapInfoViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._clanProfileGlobalMapInfoVO)
         {
            this._clanProfileGlobalMapInfoVO.dispose();
            this._clanProfileGlobalMapInfoVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:ClanProfileGlobalMapInfoVO = this._clanProfileGlobalMapInfoVO;
         this._clanProfileGlobalMapInfoVO = new ClanProfileGlobalMapInfoVO(param1);
         this.setData(this._clanProfileGlobalMapInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:ClanProfileGlobalMapInfoVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
