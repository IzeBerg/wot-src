package net.wg.gui.battle.pveBase.views.primaryObjective.controls
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class PrimaryObjectiveResult extends UIComponentEx
   {
      
      private static const LOST_FRAME:int = 1;
      
      private static const WIN_FRAME:int = 2;
       
      
      public var icon:BattleAtlasSprite = null;
      
      public var textHint:PrimaryObjectiveText = null;
      
      public var textHintSmall:PrimaryObjectiveText = null;
      
      public var back:MovieClip = null;
      
      public function PrimaryObjectiveResult()
      {
         super();
      }
      
      public function updateStage(param1:Boolean) : void
      {
         this.textHint.visible = !param1;
         this.textHintSmall.visible = param1;
      }
      
      override protected function onDispose() : void
      {
         this.icon = null;
         this.textHint.dispose();
         this.textHint = null;
         this.textHintSmall.dispose();
         this.textHintSmall = null;
         this.back = null;
         super.onDispose();
      }
      
      public function setData(param1:Boolean, param2:String, param3:String) : void
      {
         if(param2.length != 0)
         {
            this.icon.imageName = param2;
         }
         this.icon.visible = param2.length != 0;
         this.textHint.htmlText = param3;
         this.textHintSmall.htmlText = param3;
         if(param1)
         {
            this.back.gotoAndStop(WIN_FRAME);
         }
         else
         {
            this.back.gotoAndStop(LOST_FRAME);
         }
      }
   }
}
