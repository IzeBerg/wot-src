package net.wg.gui.lobby.missions.components.detailedView
{
   import net.wg.gui.components.controls.ButtonIconNormal;
   
   public class MissionDetailsConditionRendererSmall extends MissionDetailsConditionRendererAbstract
   {
      
      private static const SMALL_DESC_WIDTH:int = 100;
      
      private static const BIG_DESC_WIDTH:int = 150;
       
      
      public function MissionDetailsConditionRendererSmall()
      {
         super();
      }
      
      override protected function updateListButtonLayout() : void
      {
         listBtn.x = descTF.x + descTF.textWidth + LIST_BTN_X_GAP;
         listBtn.y = descTF.y + descTF.textHeight - listBtn.height + LIST_BTN_Y_GAP ^ 0;
      }
      
      override protected function initListButton() : void
      {
         ButtonIconNormal(listBtn).iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_ICON_BUTTON_LIST;
      }
      
      override protected function getDescTextFieldSize() : int
      {
         return rendererData.useWideTextField && !rendererData.isCondition ? int(BIG_DESC_WIDTH) : int(SMALL_DESC_WIDTH);
      }
   }
}
