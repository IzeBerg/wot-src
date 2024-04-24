package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionsMapPlanVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PersonalMissionsMapViewMeta extends BaseDAAPIComponent
   {
       
      
      public var onRegionClick:Function;
      
      private var _personalMissionsMapPlanVO:PersonalMissionsMapPlanVO;
      
      public function PersonalMissionsMapViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._personalMissionsMapPlanVO)
         {
            this._personalMissionsMapPlanVO.dispose();
            this._personalMissionsMapPlanVO = null;
         }
         super.onDispose();
      }
      
      public function onRegionClickS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onRegionClick,"onRegionClick" + Errors.CANT_NULL);
         this.onRegionClick(param1);
      }
      
      public final function as_setPlanData(param1:Object) : void
      {
         var _loc2_:PersonalMissionsMapPlanVO = this._personalMissionsMapPlanVO;
         this._personalMissionsMapPlanVO = new PersonalMissionsMapPlanVO(param1);
         this.setPlanData(this._personalMissionsMapPlanVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setPlanData(param1:PersonalMissionsMapPlanVO) : void
      {
         var _loc2_:String = "as_setPlanData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
