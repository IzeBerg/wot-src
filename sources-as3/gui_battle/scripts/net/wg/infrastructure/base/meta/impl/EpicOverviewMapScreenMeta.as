package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.views.epicOverviewMapScreen.data.EpicOverviewMapScreenVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EpicOverviewMapScreenMeta extends BattleDisplayable
   {
       
      
      private var _epicOverviewMapScreenVO:EpicOverviewMapScreenVO;
      
      public function EpicOverviewMapScreenMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._epicOverviewMapScreenVO)
         {
            this._epicOverviewMapScreenVO.dispose();
            this._epicOverviewMapScreenVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setKeyBindings(param1:Object) : void
      {
         var _loc2_:EpicOverviewMapScreenVO = this._epicOverviewMapScreenVO;
         this._epicOverviewMapScreenVO = new EpicOverviewMapScreenVO(param1);
         this.setKeyBindings(this._epicOverviewMapScreenVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setKeyBindings(param1:EpicOverviewMapScreenVO) : void
      {
         var _loc2_:String = "as_setKeyBindings" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
