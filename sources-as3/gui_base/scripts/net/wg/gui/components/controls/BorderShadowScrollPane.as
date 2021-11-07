package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import scaleform.clik.constants.InvalidationType;
   
   public class BorderShadowScrollPane extends ResizableScrollPane
   {
       
      
      public var topShadow:MovieClip;
      
      public var bottomShadow:MovieClip;
      
      public function BorderShadowScrollPane()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.topShadow.mouseChildren = this.topShadow.mouseEnabled = false;
         this.bottomShadow.mouseChildren = this.bottomShadow.mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.topShadow.y = 0;
            this.bottomShadow.y = height - this.bottomShadow.height;
         }
      }
      
      override protected function onDispose() : void
      {
         this.topShadow = null;
         this.bottomShadow = null;
         super.onDispose();
      }
      
      override protected function applyTargetChanges() : void
      {
         super.applyTargetChanges();
         if(target)
         {
            if(getChildIndex(target) > getChildIndex(this.topShadow))
            {
               swapChildren(target,this.topShadow);
            }
            if(getChildIndex(target) > getChildIndex(this.bottomShadow))
            {
               swapChildren(target,this.bottomShadow);
            }
         }
      }
   }
}
