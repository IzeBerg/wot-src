package net.wg.gui.battle.eventBattle.views
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.gui.bootcamp.containers.TutorialPageContainer;
   import net.wg.gui.bootcamp.introVideoPage.BCIntroVideoPage;
   import scaleform.gfx.MouseEventEx;
   
   public class EventBattleLoading extends BCIntroVideoPage
   {
      
      private static const HEADER_OFFSET:int = 198;
      
      private static const DESCRIPTION_OFFSET:int = 140;
       
      
      public var glow:MovieClip = null;
      
      public function EventBattleLoading()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         btnLeft.addEventListener(MouseEvent.CLICK,this.onButtonsClickHandler);
         btnRight.addEventListener(MouseEvent.CLICK,this.onButtonsClickHandler);
         loadingProgress.visible = false;
         btnSkip.visible = false;
         closeBtn.visible = false;
         btnSelect.visible = false;
         btnSkipVideo.visible = false;
      }
      
      override protected function onDispose() : void
      {
         btnLeft.removeEventListener(MouseEvent.CLICK,this.onButtonsClickHandler);
         btnRight.removeEventListener(MouseEvent.CLICK,this.onButtonsClickHandler);
         this.glow = null;
         super.onDispose();
      }
      
      override public function as_loaded() : void
      {
         loadingProgress.gotoAndStop(loadingProgress.totalFrames);
      }
      
      override public function as_showIntroPage(param1:Boolean, param2:Boolean) : void
      {
      }
      
      override protected function onStageClickHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      protected function onButtonsClickHandler(param1:MouseEvent) : void
      {
         if(MouseEventEx(param1).buttonIdx == MouseEventEx.RIGHT_BUTTON || MouseEventEx(param1).buttonIdx == MouseEventEx.MIDDLE_BUTTON)
         {
            return;
         }
         if(!introData.showTutorialPages)
         {
            continueToBattle();
         }
         else
         {
            if(param1.currentTarget == btnRight)
            {
               imageGoRight = true;
            }
            else if(param1.currentTarget == btnLeft)
            {
               imageGoRight = false;
            }
            tweenFadeOut();
         }
      }
      
      override protected function updateUIPosition() : void
      {
         super.updateUIPosition();
         this.setTextsPosition();
         this.glow.width = App.appWidth;
         this.glow.height = App.appHeight;
      }
      
      override protected function updateBackgroundRenderer() : void
      {
         super.updateBackgroundRenderer();
         this.setTextsPosition();
      }
      
      private function setTextsPosition() : void
      {
         var _loc1_:TutorialPageContainer = getCurrentPage();
         _loc1_.setTextsY(App.appHeight - backgroundContainer.y,HEADER_OFFSET,DESCRIPTION_OFFSET);
      }
   }
}
