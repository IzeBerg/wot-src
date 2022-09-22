package net.wg.gui.lobby.missions.components.detailedView
{
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionDetailedConditionRenderer extends MissionDetailsConditionRendererAbstract
   {
      
      private static const ICON_X:int = -50;
      
      private static const ICON_Y:int = -42;
      
      private static const DESC_WIDTH_SCALE:Number = 1.5;
      
      private static const PROGRESS_DESC_TOP_DEFAULT:int = 4;
       
      
      public function MissionDetailedConditionRenderer()
      {
         super();
      }
      
      override protected function updateIconLayout() : void
      {
         icon.x = ICON_X;
         icon.y = ICON_Y;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(rendererData && isInvalid(InvalidationType.DATA))
         {
            progressDescTF.y = PROGRESS_DESC_TOP_DEFAULT;
         }
      }
      
      override protected function getDescTextFieldSize() : int
      {
         if(rendererData.useWideTextField && !rendererData.isCondition)
         {
            return descTF.width * DESC_WIDTH_SCALE >> 0;
         }
         return descTF.width;
      }
      
      override protected function updateListButtonLayout() : void
      {
         listBtn.x = descTF.x;
         listBtn.y = descTF.y + descTF.textHeight + LIST_BTN_Y_GAP ^ 0;
      }
      
      override protected function initListButton() : void
      {
         listBtn.label = QUESTS.MISSIONDETAILS_BATTLECONDITION_LIST;
      }
   }
}
