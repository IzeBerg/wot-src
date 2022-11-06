package net.wg.gui.tutorial.windows
{
   import flash.text.TextField;
   import net.wg.gui.tutorial.meta.ITutorialBattleNoResultsMeta;
   import net.wg.gui.tutorial.meta.impl.TutorialBattleNoResultsMeta;
   import scaleform.clik.constants.InvalidationType;
   
   public class TutorialBattleNoResultsWindow extends TutorialBattleNoResultsMeta implements ITutorialBattleNoResultsMeta
   {
       
      
      public var textField:TextField;
      
      protected var data:Object;
      
      public function TutorialBattleNoResultsWindow()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this.data)
         {
            this.textField.text = this.data.text;
         }
      }
      
      override protected function onDispose() : void
      {
         this.data = null;
         super.onDispose();
      }
      
      public function as_setData(param1:Object) : void
      {
         this.data = param1;
         invalidate(InvalidationType.DATA);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.useBottomBtns = false;
         window.title = BATTLE_TUTORIAL.WINDOWS_RESULT_TITLE;
      }
   }
}
