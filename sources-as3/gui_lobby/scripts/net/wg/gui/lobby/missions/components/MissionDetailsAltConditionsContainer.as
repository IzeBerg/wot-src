package net.wg.gui.lobby.missions.components
{
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionDetailsAltConditionsContainer extends MissionAltConditionsContainer
   {
       
      
      public function MissionDetailsAltConditionsContainer()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            labelTF.y = separator.height - labelTF.height >> 2;
         }
      }
      
      override public function get height() : Number
      {
         return labelTF.height;
      }
   }
}
