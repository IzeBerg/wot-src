package net.wg.gui.components.carousels
{
   import flash.display.MovieClip;
   import scaleform.clik.controls.Button;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class AchievementCarousel extends CarouselBase
   {
       
      
      public var achievementBG:MovieClip;
      
      public function AchievementCarousel()
      {
         super();
         leftArrow.enabled = rightArrow.enabled = false;
         leftArrow.visible = rightArrow.visible = false;
         this.achievementBG.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         leftArrow.soundEnabled = true;
         rightArrow.soundEnabled = true;
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      override protected function initPosition() : void
      {
         super.initPosition();
         if(this.achievementBG)
         {
            this.achievementBG.x = renderersMask.x;
            this.achievementBG.y = renderersMask.y;
            this.achievementBG.width = renderersMask.width;
            this.achievementBG.height = renderersMask.height;
         }
      }
      
      override protected function updateContainerPosition() : void
      {
         super.updateContainerPosition();
         if(_renderers.length <= countVisibleSlots)
         {
            leftArrow.visible = rightArrow.visible = false;
            container.x = leftArrow.x + leftArrow.width + padding.left;
         }
         else
         {
            leftArrow.visible = rightArrow.visible = true;
         }
         this.achievementBG.visible = leftArrow.visible;
         updateArrowsState();
      }
      
      override protected function updateRenderPosition(param1:IListItemRenderer, param2:uint, param3:int, param4:Number) : void
      {
         super.updateRenderPosition(param1,param2,param3,param4);
         if(_renderers.length <= countVisibleSlots)
         {
            Button(param1).buttonMode = true;
         }
      }
      
      override protected function populateData(param1:Array) : void
      {
         super.populateData(param1);
         if(_renderers.length > countVisibleSlots)
         {
            this.initPosition();
         }
      }
   }
}
