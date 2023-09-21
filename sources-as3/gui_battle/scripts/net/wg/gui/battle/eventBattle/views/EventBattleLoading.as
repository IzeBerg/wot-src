package net.wg.gui.battle.eventBattle.views
{
   import flash.events.MouseEvent;
   import net.wg.gui.bootcamp.introVideoPage.BCIntroVideoPage;
   import scaleform.clik.events.ButtonEvent;
   
   public class EventBattleLoading extends BCIntroVideoPage
   {
      
      private static const TEXT_GROUP_OFFSET_LEFT:int = 125;
      
      private static const TEXT_GROUP_OFFSET_BOTTOM:int = 100;
      
      private static const LOADING_PROGRESS_OFFSET_BOTTOM:int = 40;
       
      
      public function EventBattleLoading()
      {
         super();
         eventModeEnabled = true;
         customTextPaddingLeft = TEXT_GROUP_OFFSET_LEFT;
         customTextPaddingBottom = TEXT_GROUP_OFFSET_BOTTOM;
         customLoadingProgressBottom = LOADING_PROGRESS_OFFSET_BOTTOM;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         btnLeft.addEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         btnRight.addEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         waitingTF.visible = btnSelect.visible = btnStart.visible = btnSkip.visible = btnSkipVideo.visible = false;
      }
      
      override protected function onDispose() : void
      {
         btnLeft.removeEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         btnRight.removeEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         super.onDispose();
      }
      
      override public function as_loaded() : void
      {
         loadingProgress.gotoAndStop(loadingProgress.totalFrames);
      }
      
      override protected function onStageClickHandler(param1:MouseEvent) : void
      {
      }
      
      private function onButtonsClickHandler(param1:ButtonEvent) : void
      {
         imageGoRight = param1.currentTarget == btnRight;
         tweenFadeOut();
      }
   }
}
