package net.wg.gui.battle.pveBase.views.primaryObjective.controls
{
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class PrimaryObjectiveTask extends UIComponentEx
   {
       
      
      public var textHint:PrimaryObjectiveText = null;
      
      public var textHintSmall:PrimaryObjectiveText = null;
      
      public var textMatter:PrimaryObjectiveText = null;
      
      public var textMatterSmall:PrimaryObjectiveText = null;
      
      public function PrimaryObjectiveTask()
      {
         super();
      }
      
      public function updateStage(param1:Boolean) : void
      {
         this.textHint.visible = !param1;
         this.textHintSmall.visible = param1;
         this.textMatter.visible = !param1;
         this.textMatterSmall.visible = param1;
      }
      
      override protected function onDispose() : void
      {
         this.textHint.dispose();
         this.textHint = null;
         this.textHintSmall.dispose();
         this.textHintSmall = null;
         this.textMatter.dispose();
         this.textMatter = null;
         this.textMatterSmall.dispose();
         this.textMatterSmall = null;
         super.onDispose();
      }
      
      public function setText(param1:String, param2:String) : void
      {
         this.textHint.htmlText = param1;
         this.textHintSmall.htmlText = param1;
         this.textMatter.htmlText = param2;
         this.textMatterSmall.htmlText = param2;
      }
   }
}
