package net.wg.gui.components.advanced
{
   import net.wg.gui.components.advanced.backButton.BackButtonHelper;
   import net.wg.gui.components.advanced.backButton.BackButtonStates;
   import net.wg.gui.components.controls.SoundButtonEx;
   
   public class ButtonAbout extends SoundButtonEx
   {
      
      private static const HIT_AREA_OFFSET:int = 10;
       
      
      public var content:BackButtonStates = null;
      
      public function ButtonAbout()
      {
         super();
         constraintsDisabled = true;
         preventAutosizing = true;
      }
      
      override protected function updateText() : void
      {
         super.updateText();
         var _loc1_:BackButtonHelper = BackButtonHelper.getInstance();
         _loc1_.updateStatesWidth(this.content);
         if(hitMc != null)
         {
            hitMc.width = this.content.x + this.content.textMc.x + this.content.textMc.width + HIT_AREA_OFFSET;
         }
      }
      
      override protected function setState(param1:String) : void
      {
         super.setState(param1);
         this.content.gotoAndPlay(param1);
      }
      
      override protected function onDispose() : void
      {
         this.content.dispose();
         this.content = null;
         super.onDispose();
      }
      
      override public function set label(param1:String) : void
      {
         this.content.textMc.textField.text = param1;
         super.label = param1;
      }
   }
}
