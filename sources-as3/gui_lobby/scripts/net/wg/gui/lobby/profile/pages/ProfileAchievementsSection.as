package net.wg.gui.lobby.profile.pages
{
   import net.wg.gui.lobby.profile.ProfileInvalidationTypes;
   import net.wg.infrastructure.base.meta.IProfileAchievementSectionMeta;
   import net.wg.infrastructure.base.meta.impl.ProfileAchievementSectionMeta;
   
   public class ProfileAchievementsSection extends ProfileAchievementSectionMeta implements IProfileAchievementSectionMeta
   {
       
      
      private var _pendingAchievementsData:Object;
      
      private var _pendingAchievementsDataChanged:Boolean = false;
      
      public function ProfileAchievementsSection()
      {
         this._pendingAchievementsData = {};
         super();
      }
      
      override protected function configUI() : void
      {
         if(_baseDisposed)
         {
            return;
         }
         super.configUI();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(ProfileInvalidationTypes.RARE_ACHMNT_RECEIVED_DATA_INV) && this._pendingAchievementsData != null && this._pendingAchievementsDataChanged)
         {
            this.applyRareAchievementsReceivedData(this._pendingAchievementsData);
            this._pendingAchievementsDataChanged = false;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._pendingAchievementsData)
         {
            this._pendingAchievementsData = App.utils.data.cleanupDynamicObject(this._pendingAchievementsData);
         }
         super.onDispose();
      }
      
      public function as_setRareAchievementData(param1:String, param2:String) : void
      {
         this._pendingAchievementsData[param1] = param2;
         this._pendingAchievementsDataChanged = true;
         invalidate(ProfileInvalidationTypes.RARE_ACHMNT_RECEIVED_DATA_INV);
      }
      
      protected function applyRareAchievementsReceivedData(param1:Object) : void
      {
         App.utils.data.cleanupDynamicObject(param1);
      }
   }
}
