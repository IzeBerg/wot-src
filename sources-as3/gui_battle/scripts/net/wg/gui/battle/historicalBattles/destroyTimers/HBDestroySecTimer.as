package net.wg.gui.battle.historicalBattles.destroyTimers
{
   import net.wg.gui.battle.views.destroyTimers.SecondaryTimer;
   
   public class HBDestroySecTimer extends SecondaryTimer
   {
      
      private static const SEC_SPACE:String = " ";
      
      private static const HB_TEXT_FIELD_CROP_Y:int = 7;
      
      private static const HB_TEXT_FIELD_CROP_X:int = 30;
      
      private static const HB_TEXT_FIELD_FULL_X:int = 39;
      
      private static const SIZE_WIDTH:uint = 92;
       
      
      private var _secondaryString:String = "";
      
      public function HBDestroySecTimer()
      {
         super();
         this._secondaryString = SEC_SPACE + App.utils.locale.makeString(INGAME_GUI.STUN_SECONDS);
      }
      
      override public function cropSize() : Boolean
      {
         container.textFieldLabel.visible = false;
         container.textField.y = HB_TEXT_FIELD_CROP_Y;
         container.textField.x = HB_TEXT_FIELD_CROP_X;
         return true;
      }
      
      override public function fullSize() : Boolean
      {
         super.fullSize();
         container.textField.x = HB_TEXT_FIELD_FULL_X;
         return true;
      }
      
      override protected function setTimerTimeString() : void
      {
         if(lastStrTime)
         {
            container.textField.text = lastStrTime + this._secondaryString;
         }
      }
      
      override public function get actualWidth() : Number
      {
         if(container.textFieldLabel.visible)
         {
            return super.actualWidth;
         }
         return SIZE_WIDTH;
      }
   }
}
