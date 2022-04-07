package net.wg.gui.lobby.training
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.BaseDropList;
   
   public class DropList extends BaseDropList
   {
       
      
      public var focusIndicator:MovieClip;
      
      public function DropList()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.focusIndicator = null;
         super.onDispose();
      }
      
      override public function highlightList() : void
      {
         this.focusIndicator.visible = true;
      }
      
      override public function hideHighLight() : void
      {
         this.focusIndicator.visible = false;
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         this.focusIndicator.gotoAndPlay("dragOver");
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         this.focusIndicator.gotoAndPlay("dragOut");
      }
   }
}
