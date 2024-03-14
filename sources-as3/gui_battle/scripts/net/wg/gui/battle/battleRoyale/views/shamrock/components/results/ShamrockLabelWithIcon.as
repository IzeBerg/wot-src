package net.wg.gui.battle.battleRoyale.views.shamrock.components.results
{
   import flash.display.Sprite;
   
   public class ShamrockLabelWithIcon extends AbstractShamrockLabel
   {
      
      private static const LABEL_GAP:int = 13;
      
      private static const ICON_GAP:int = -3;
       
      
      public var icon:Sprite = null;
      
      public function ShamrockLabelWithIcon()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.icon = null;
         super.onDispose();
      }
      
      override protected function alignContent() : void
      {
         var _loc1_:int = labelTF.textWidth + _maxValueWidth + this.icon.width + LABEL_GAP + ICON_GAP;
         labelTF.x = -_loc1_ >> 1;
         this.icon.x = labelTF.x + labelTF.textWidth + LABEL_GAP;
         valueTF.x = this.icon.x + this.icon.width + ICON_GAP;
      }
   }
}
