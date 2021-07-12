package net.wg.gui.components.carousels
{
   import scaleform.clik.controls.Button;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class SkillsCarousel extends CarouselBase
   {
       
      
      public function SkillsCarousel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         rightArrow.soundEnabled = true;
         leftArrow.soundEnabled = true;
      }
      
      override protected function updateContainerPosition() : void
      {
         super.updateContainerPosition();
         if(_renderers.length <= 0)
         {
            this.visible = false;
         }
         else if(_renderers.length <= countVisibleSlots)
         {
            leftArrow.visible = rightArrow.visible = false;
            leftArrow.enabled = rightArrow.enabled = false;
            leftArrow.mouseEnabled = rightArrow.mouseEnabled = false;
         }
         else
         {
            leftArrow.visible = rightArrow.visible = true;
            leftArrow.mouseEnabled = rightArrow.mouseEnabled = true;
         }
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
   }
}
