package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.profile.data.ProfileGroupBlockVO;
   import net.wg.gui.lobby.profile.pages.summary.ProfileSummary;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ProfileSummaryWindowMeta extends ProfileSummary
   {
       
      
      public var openClanStatistic:Function;
      
      private var _profileGroupBlockVO:ProfileGroupBlockVO;
      
      public function ProfileSummaryWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._profileGroupBlockVO)
         {
            this._profileGroupBlockVO.dispose();
            this._profileGroupBlockVO = null;
         }
         super.onDispose();
      }
      
      public function openClanStatisticS() : void
      {
         App.utils.asserter.assertNotNull(this.openClanStatistic,"openClanStatistic" + Errors.CANT_NULL);
         this.openClanStatistic();
      }
      
      public final function as_setClanData(param1:Object) : void
      {
         var _loc2_:ProfileGroupBlockVO = this._profileGroupBlockVO;
         this._profileGroupBlockVO = new ProfileGroupBlockVO(param1);
         this.setClanData(this._profileGroupBlockVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setClanData(param1:ProfileGroupBlockVO) : void
      {
         var _loc2_:String = "as_setClanData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
