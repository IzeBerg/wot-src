package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileTableStatisticsDataVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ClanProfileTableStatisticsViewMeta extends BaseDAAPIComponent
   {
       
      
      private var _clanProfileTableStatisticsDataVO:ClanProfileTableStatisticsDataVO;
      
      public function ClanProfileTableStatisticsViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._clanProfileTableStatisticsDataVO)
         {
            this._clanProfileTableStatisticsDataVO.dispose();
            this._clanProfileTableStatisticsDataVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:ClanProfileTableStatisticsDataVO = this._clanProfileTableStatisticsDataVO;
         this._clanProfileTableStatisticsDataVO = new ClanProfileTableStatisticsDataVO(param1);
         this.setData(this._clanProfileTableStatisticsDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:ClanProfileTableStatisticsDataVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
