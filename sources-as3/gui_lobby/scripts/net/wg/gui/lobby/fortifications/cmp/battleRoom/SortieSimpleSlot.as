package net.wg.gui.lobby.fortifications.cmp.battleRoom
{
   import flash.display.Sprite;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.interfaces.IButtonIconTextTransparent;
   import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
   
   public class SortieSimpleSlot extends RallySimpleSlotRenderer
   {
       
      
      public var lockBackground:Sprite = null;
      
      public function SortieSimpleSlot()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(commander != null)
         {
            addTooltipSubscriber(commander);
         }
         App.utils.asserter.assertNotNull(this.lockBackground,"lockBackground in " + name + Errors.CANT_NULL);
         takePlaceBtn.label = FORTIFICATIONS.SORTIE_SLOT_TAKEPLACE;
         this.grayTakePlaceFirstButton.label = FORTIFICATIONS.SORTIE_SLOT_TAKEPLACE;
      }
      
      override protected function onDispose() : void
      {
         this.lockBackground = null;
         if(commander != null)
         {
            removeTooltipSubscriber(commander);
         }
         super.onDispose();
      }
      
      public function get grayTakePlaceFirstButton() : IButtonIconTextTransparent
      {
         return takePlaceFirstTimeBtn as IButtonIconTextTransparent;
      }
      
      public function set grayTakePlaceFirstButton(param1:IButtonIconTextTransparent) : void
      {
         takePlaceFirstTimeBtn = param1 as SoundButtonEx;
         App.utils.asserter.assertNotNull(takePlaceFirstTimeBtn,"takePlaceFirstTimeBtn" + Errors.CANT_NULL);
      }
   }
}
