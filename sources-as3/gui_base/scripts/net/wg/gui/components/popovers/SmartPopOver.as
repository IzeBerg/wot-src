package net.wg.gui.components.popovers
{
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   import net.wg.infrastructure.managers.ITweenManagerHelper;
   import net.wg.utils.ITweenManager;
   
   public class SmartPopOver extends PopOver
   {
       
      
      private var fadeInTween:ITween;
      
      public function SmartPopOver()
      {
         super();
         visible = false;
      }
      
      override protected function invokeLayout() : void
      {
         var _loc2_:ITweenPropertiesVO = null;
         var _loc1_:Object = _layout.invokeLayout();
         if(_loc1_ && !visible)
         {
            alpha = 0;
            _loc2_ = App.utils.tweenAnimator.createPropsForAlpha(this,this.tweenMgrHelper.getFadeDurationFast(),1,0);
            _loc2_.setPaused(false);
            this.fadeInTween = this.tweenMgr.createNewTween(_loc2_);
            visible = true;
         }
      }
      
      private function get tweenMgr() : ITweenManager
      {
         return App.tweenMgr;
      }
      
      private function get tweenMgrHelper() : ITweenManagerHelper
      {
         return App.tweenMgr.getTweenManagerHelper();
      }
      
      override protected function onDispose() : void
      {
         if(this.fadeInTween != null)
         {
            this.tweenMgr.disposeTweenS(this.fadeInTween);
            this.fadeInTween = null;
         }
         super.onDispose();
      }
   }
}
