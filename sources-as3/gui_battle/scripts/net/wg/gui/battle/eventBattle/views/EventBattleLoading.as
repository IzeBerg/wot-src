package net.wg.gui.battle.eventBattle.views
{
   import flash.events.MouseEvent;
   import net.wg.gui.bootcamp.introVideoPage.BCIntroVideoPage;
   import scaleform.clik.events.ButtonEvent;
   
   public class EventBattleLoading extends BCIntroVideoPage
   {
       
      
      public function EventBattleLoading()
      {
         super();
      }
      
      override public function as_loaded() : void
      {
         loadingProgress.gotoAndStop(loadingProgress.totalFrames);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         btnLeft.addEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         btnRight.addEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         waitingTF.visible = btnSelect.visible = btnSkip.visible = btnSkipVideo.visible = closeBtn.visible = false;
      }
      
      override protected function onDispose() : void
      {
         btnLeft.removeEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         btnRight.removeEventListener(ButtonEvent.CLICK,this.onButtonsClickHandler);
         super.onDispose();
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
