package net.wg.gui.battle.views.HWBattleLoading.components
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class LoadingProgress extends UIComponentEx
   {
       
      
      public var loadingBg:MovieClip = null;
      
      public function LoadingProgress()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.loadingBg = null;
         super.onDispose();
      }
      
      override public function get width() : Number
      {
         return this.loadingBg.width * actualScaleX >> 0;
      }
   }
}
