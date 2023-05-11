package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.profile.pages.ProfileSection;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ProfileHofMeta extends ProfileSection
   {
       
      
      public var showVehiclesRating:Function;
      
      public var showAchievementsRating:Function;
      
      public var changeStatus:Function;
      
      private var _vectorCountersVo:Vector.<CountersVo>;
      
      public function ProfileHofMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:CountersVo = null;
         if(this._vectorCountersVo)
         {
            for each(_loc1_ in this._vectorCountersVo)
            {
               _loc1_.dispose();
            }
            this._vectorCountersVo.splice(0,this._vectorCountersVo.length);
            this._vectorCountersVo = null;
         }
         super.onDispose();
      }
      
      public function showVehiclesRatingS() : void
      {
         App.utils.asserter.assertNotNull(this.showVehiclesRating,"showVehiclesRating" + Errors.CANT_NULL);
         this.showVehiclesRating();
      }
      
      public function showAchievementsRatingS() : void
      {
         App.utils.asserter.assertNotNull(this.showAchievementsRating,"showAchievementsRating" + Errors.CANT_NULL);
         this.showAchievementsRating();
      }
      
      public function changeStatusS() : void
      {
         App.utils.asserter.assertNotNull(this.changeStatus,"changeStatus" + Errors.CANT_NULL);
         this.changeStatus();
      }
      
      public final function as_setBtnCounters(param1:Array) : void
      {
         var _loc5_:CountersVo = null;
         var _loc2_:Vector.<CountersVo> = this._vectorCountersVo;
         this._vectorCountersVo = new Vector.<CountersVo>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorCountersVo[_loc4_] = new CountersVo(param1[_loc4_]);
            _loc4_++;
         }
         this.setBtnCounters(this._vectorCountersVo);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setBtnCounters(param1:Vector.<CountersVo>) : void
      {
         var _loc2_:String = "as_setBtnCounters" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
