package net.wg.gui.battle.battleRoyale.views.shamrock.components.results
{
   public class BonusShamrockLabel extends AbstractShamrockLabel
   {
      
      private static const LABEL_GAP:int = 2;
       
      
      public function BonusShamrockLabel()
      {
         super();
      }
      
      override protected function alignContent() : void
      {
         var _loc1_:int = labelTF.textWidth + _maxValueWidth + LABEL_GAP;
         labelTF.x = -_loc1_ >> 1;
         valueTF.x = labelTF.x + labelTF.textWidth + LABEL_GAP;
      }
   }
}
