package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.components.data.RibbonAwardsVO;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionAwardsScreenVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PersonalMissionsOperationAwardsScreenMeta extends AbstractView
   {
       
      
      public var onCloseWindow:Function;
      
      public var onPlaySound:Function;
      
      private var _personalMissionAwardsScreenVO:PersonalMissionAwardsScreenVO;
      
      private var _ribbonAwardsVO:RibbonAwardsVO;
      
      public function PersonalMissionsOperationAwardsScreenMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._personalMissionAwardsScreenVO)
         {
            this._personalMissionAwardsScreenVO.dispose();
            this._personalMissionAwardsScreenVO = null;
         }
         if(this._ribbonAwardsVO)
         {
            this._ribbonAwardsVO.dispose();
            this._ribbonAwardsVO = null;
         }
         super.onDispose();
      }
      
      public function onCloseWindowS() : void
      {
         App.utils.asserter.assertNotNull(this.onCloseWindow,"onCloseWindow" + Errors.CANT_NULL);
         this.onCloseWindow();
      }
      
      public function onPlaySoundS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onPlaySound,"onPlaySound" + Errors.CANT_NULL);
         this.onPlaySound(param1);
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:PersonalMissionAwardsScreenVO = this._personalMissionAwardsScreenVO;
         this._personalMissionAwardsScreenVO = new PersonalMissionAwardsScreenVO(param1);
         this.setInitData(this._personalMissionAwardsScreenVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setAwardData(param1:Object) : void
      {
         var _loc2_:RibbonAwardsVO = this._ribbonAwardsVO;
         this._ribbonAwardsVO = new RibbonAwardsVO(param1);
         this.setAwardData(this._ribbonAwardsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:PersonalMissionAwardsScreenVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setAwardData(param1:RibbonAwardsVO) : void
      {
         var _loc2_:String = "as_setAwardData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
