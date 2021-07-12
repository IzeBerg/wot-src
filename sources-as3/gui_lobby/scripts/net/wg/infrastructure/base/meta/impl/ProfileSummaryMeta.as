package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.profile.data.ProfileUserVO;
   import net.wg.gui.lobby.profile.pages.ProfileAchievementsSection;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ProfileSummaryMeta extends ProfileAchievementsSection
   {
       
      
      public var getGlobalRating:Function;
      
      private var _profileUserVO:ProfileUserVO;
      
      public function ProfileSummaryMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._profileUserVO)
         {
            this._profileUserVO.dispose();
            this._profileUserVO = null;
         }
         super.onDispose();
      }
      
      public function getGlobalRatingS(param1:String) : Number
      {
         App.utils.asserter.assertNotNull(this.getGlobalRating,"getGlobalRating" + Errors.CANT_NULL);
         return this.getGlobalRating(param1);
      }
      
      public final function as_setUserData(param1:Object) : void
      {
         var _loc2_:ProfileUserVO = this._profileUserVO;
         this._profileUserVO = new ProfileUserVO(param1);
         this.setUserData(this._profileUserVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setUserData(param1:ProfileUserVO) : void
      {
         var _loc2_:String = "as_setUserData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
