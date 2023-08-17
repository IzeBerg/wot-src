package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.CountersVo;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.profile.pages.ProfileSection;
   import net.wg.gui.lobby.profile.pages.technique.data.ProfileVehicleDossierVO;
   import net.wg.gui.lobby.profile.pages.technique.data.RatingButtonVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ProfileTechniqueMeta extends ProfileSection
   {
       
      
      public var setSelectedTableColumn:Function;
      
      public var showVehiclesRating:Function;
      
      private var _profileVehicleDossierVO:ProfileVehicleDossierVO;
      
      private var _ratingButtonVO:RatingButtonVO;
      
      private var _vectorCountersVo:Vector.<CountersVo>;
      
      public function ProfileTechniqueMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:CountersVo = null;
         if(this._profileVehicleDossierVO)
         {
            this._profileVehicleDossierVO.dispose();
            this._profileVehicleDossierVO = null;
         }
         if(this._ratingButtonVO)
         {
            this._ratingButtonVO.dispose();
            this._ratingButtonVO = null;
         }
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
      
      public function setSelectedTableColumnS(param1:int, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.setSelectedTableColumn,"setSelectedTableColumn" + Errors.CANT_NULL);
         this.setSelectedTableColumn(param1,param2);
      }
      
      public function showVehiclesRatingS() : void
      {
         App.utils.asserter.assertNotNull(this.showVehiclesRating,"showVehiclesRating" + Errors.CANT_NULL);
         this.showVehiclesRating();
      }
      
      public final function as_responseVehicleDossier(param1:Object) : void
      {
         var _loc2_:ProfileVehicleDossierVO = this._profileVehicleDossierVO;
         this._profileVehicleDossierVO = new ProfileVehicleDossierVO(param1);
         this.responseVehicleDossier(this._profileVehicleDossierVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setRatingButton(param1:Object) : void
      {
         var _loc2_:RatingButtonVO = this._ratingButtonVO;
         this._ratingButtonVO = new RatingButtonVO(param1);
         this.setRatingButton(this._ratingButtonVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
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
      
      protected function responseVehicleDossier(param1:ProfileVehicleDossierVO) : void
      {
         var _loc2_:String = "as_responseVehicleDossier" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setRatingButton(param1:RatingButtonVO) : void
      {
         var _loc2_:String = "as_setRatingButton" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setBtnCounters(param1:Vector.<CountersVo>) : void
      {
         var _loc2_:String = "as_setBtnCounters" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
